import { Stack, Typography } from "@mui/material";
import { useEffect, useState } from "react";
import * as ss from "simple-statistics";
import { useAppSelector } from "src/redux/hooks";
import KernelDensityPlot from "./Plot";

export default function GradientKernelDensity() {
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedGradientCluster,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedGradientClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedGradientClusteringResult,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );

  const [kernelDensityData, setKernelDensityData] = useState<{
    [dFpcdP: string]: {
      overall: { x: number; y: number }[];
      cluster: { x: number; y: number }[];
      fvalue: number;
      pvalue: number;
    };
  } | null>(null);

  useEffect(() => {
    if (
      selectedCluster == null ||
      clusterInfo == null ||
      clusteringResult == null ||
      trajectoryAnalysis == null
    ) {
      return;
    }

    const clusterTrials = new Set(
      Object.values(clusteringResult.data)
        .filter((item) => item.label === selectedCluster)
        .map((item) => item.trialId),
    );
    const entries = Object.entries(
      trajectoryAnalysis.clustering.gradients.data,
    );
    const pLength = entries[0][1].length;
    const fpcLength = entries[0][1][0].length;
    const pIndexArray = Array.from({ length: pLength }).map((v, i) => i);
    const fpcIndexArray = Array.from({ length: fpcLength }).map((v, i) => i);
    const newKernelDensityData: typeof kernelDensityData = {};
    const anova = clusteringResult.anova;
    const parameters = trajectoryAnalysis.clustering.parameters;

    let gradientIndex = 0;
    for (const pIndex of pIndexArray) {
      for (const fpcIndex of fpcIndexArray) {
        const dFpcdPRow: number[] = entries.map(([_trialId, item]) => {
          return item[pIndex][fpcIndex];
        });
        const clusterDFpcDPRow = entries
          .filter(([trialId, item]) => {
            return clusterTrials.has(trialId);
          })
          .map(([_trialId, item]) => {
            return item[pIndex][fpcIndex];
          });

        const minValue = Math.min(...dFpcdPRow);
        const maxValue = Math.max(...dFpcdPRow);
        const numPoints = 100; // More points = smoother curve
        const xValues = Array.from(
          { length: numPoints },
          (_, i) => minValue + (i * (maxValue - minValue)) / numPoints,
        );
        const kde = xValues.map((x) => {
          return {
            x: x,
            y: ss.kernelDensityEstimation(dFpcdPRow)(x),
          };
        });
        const clusterKde = xValues.map((x) => {
          return {
            x: x,
            y: ss.kernelDensityEstimation(clusterDFpcDPRow)(x),
            // y:
            //   ss.kernelDensityEstimation(clusterDFpcDPRow)(x) *
            //   (clusterDFpcDPRow.length / dFpcdPRow.length),
          };
        });
        newKernelDensityData[
          `dFpc${fpcIndex}/d${parameters ? parameters[pIndex].name : pIndex}`
        ] = {
          overall: kde,
          cluster: clusterKde,
          fvalue: anova[selectedCluster][gradientIndex].fvalue,
          pvalue: anova[selectedCluster][gradientIndex].pvalue,
        };
        gradientIndex += 1;
      }
    }
    setKernelDensityData(newKernelDensityData);
  }, [selectedCluster, clusterInfo]);

  return (
    <Stack sx={{ width: "100%" }}>
      {Object.keys(kernelDensityData ?? {})
        .sort((a, b) =>
          kernelDensityData
            ? kernelDensityData[b].fvalue - kernelDensityData[a].fvalue
            : 0,
        )
        .map((name) => {
          if (!kernelDensityData) {
            return null;
          }
          return (
            <Stack sx={{ p: 1, width: "100%" }}>
              <Typography>{name}</Typography>
              <Typography>
                F Value: {kernelDensityData[name].fvalue.toFixed(4)}
              </Typography>
              <KernelDensityPlot
                key={name}
                name={name}
                kde={kernelDensityData[name].overall}
                clusterKde={kernelDensityData[name].cluster}
              />
            </Stack>
          );
        })}
    </Stack>
  );
}
