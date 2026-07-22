"use client";

import chroma from "chroma-js";
import { select } from "d3";
import { Box } from "@mui/material";
import { SxProps } from "@mui/material/styles";
// @ts-ignore
import Plotly from "plotly.js-dist";
import {
  Dispatch,
  RefObject,
  SetStateAction,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { useAppSelector } from "../../../../../redux/hooks";

window.global = window;

export default function Contour({
  setMetricImages,
  egoName,
}: {
  egoName: string;
  setMetricImages: Dispatch<
    SetStateAction<{
      [metricName: string]: {
        [gridMode: string]: HTMLImageElement;
      };
    }>
  >;
}) {
  const imgRef = useRef<HTMLImageElement>(null);
  const imgRef2 = useRef<HTMLImageElement>(null);
  const backgroundDrawingCanvasRef = useRef<HTMLCanvasElement>(null);
  const backgroundDrawingCanvasRef2 = useRef<HTMLCanvasElement>(null);

  const boundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const gridMode = useAppSelector((state) => state.batch.gridMode);
  // const metric = selectedMetric;
  const metrics = useAppSelector((state) => state.batch.metrics);
  const trajectoryAnalysisResponse = useAppSelector((state) => {
    if (state.batch.trajectoryAnalysis == null) {
      return;
    }
    return state.batch.trajectoryAnalysis[egoName];
  });
  const parameters = trajectoryAnalysisResponse?.parameters;

  const [scatterPlotData, setScatterPlotData] = useState<
    {
      x: number;
      y: number;
      colorValue: number;
      colorString: string;
      id: string;
      parameters: { [parameterId: string]: number };
    }[]
  >([]);

  useEffect(() => {
    if (parameters == null) {
      return;
    }

    console.log(metrics);
    const newMetricImages: {
      [metricName: string]: { [gridMode: string]: HTMLImageElement };
    } = {};

    const createImages = async () => {
      const promises: Promise<any>[] = [];
      for (const [metricName, metric] of Object.entries(metrics ?? {})) {
        newMetricImages[metricName] = {};

        const plotData: {
          x: number;
          y: number;
          colorValue: number;
          colorString: string;
          id: string;
          parameters: { [parameterId: string]: number };
        }[] = [];

        const visited = new Set<string>();
        for (const trial of Object.values(
          trajectoryAnalysisResponse?.trials ?? {}
        )) {
          if (visited.has(String(trial.id) ?? "")) {
            continue;
          }

          let trialMetric = trial.testObjectives?.criticalityMetrics.find(
            (m) => m.keyPerformanceIndicator.id === metric?.kpi?.id
          );
          let value = trialMetric?.value ?? metric?.max ?? 0;
          if (metric.max != null) {
            value = Math.min(value, metric.max);
          }
          if (metric.min != null) {
            value = Math.max(value, metric.min);
          }
          const trialParameters: { [parameterId: string]: number } = {};
          for (const p of trial.parameters) {
            trialParameters[p.parameterId ?? ""] = p.value ?? NaN;
          }
          plotData.push({
            parameters: trialParameters,
            x: trial.parameters.find(
              (tp) => tp.parameterId === parameters[0].id
            )?.value!,
            y: trial.parameters.find(
              (tp) => tp.parameterId === parameters[1].id
            )?.value!,
            colorValue: trialMetric?.value ?? NaN,
            colorString: "black",
            id: String(trial.id) ?? "",
          });
          visited.add(String(trial.id) ?? "");
        }

        for (const gridMode of ["prediction", "gradient"]) {
          const data: Plotly.Data[] = [];
          let gridPreds =
            trajectoryAnalysisResponse?.metricGridPredictions[
              metric?.kpi.name ?? ""
            ];

          if (
            gridMode === "gradient" &&
            trajectoryAnalysisResponse?.metricGridGradients != null
          ) {
            gridPreds =
              trajectoryAnalysisResponse?.metricGridGradients[
                metric?.kpi.name ?? ""
              ];
          }

          const zData = gridPreds ? gridPreds.z : [];
          if (!zData.length) {
            continue;
          }

          const zFlattened: number[] = [];
          const zCorrected: number[][] = [];

          for (let rowI = 0; rowI < zData.length; rowI++) {
            // for (let rowI = zData.length - 1; rowI >= 0; rowI--) {
            const row = zData[rowI];
            const newRow: number[] = [];
            // for (let i = row.length - 1; i >= 0; i--) {
            for (let i = 0; i < row.length; i++) {
              // newRow.push(row[i]);
              newRow.push(zData[i][rowI]);
              zFlattened.push(row[i]);
            }
            zCorrected.push(newRow);
          }
          const zMin = Math.min(...zFlattened);
          const zMax = Math.max(...zFlattened);
          // Flat / near-flat GP surfaces (e.g. spret_min capped at 9 for CS2)
          // make Plotly contour emit speckled noise. Skip those backgrounds.
          if (!(zMax > zMin + 1e-9)) {
            continue;
          }

          const getMetricValue = (t: number) => {
            let min = metric?.min ?? 0;
            let max = metric?.max ?? 1;
            return t * (max - min) + min;
          };

          const colorLength = 25;

          const inferno = [
            "#000004",
            "#1b0c41",
            "#4a0c6b",
            "#781c6d",
            "#a52c60",
            "#cf4446",
            "#ed6925",
            "#fb9b06",
            "#f7d13d",
            "#fcffa4",
          ];
          inferno.reverse();

          let scale = chroma.scale("OrRd").padding([0.2, 0]);
          if (gridMode === "gradient") {
            scale = chroma.scale(inferno);
          }
          let tempS = scale.domain([1, 0]);
          if (metric && metric.kpi.rule === "lessThan") {
            tempS = scale.domain([0, 1]);
          }
          let temp = Array.from({ length: colorLength }).map((v, i) => {
            return [i / colorLength, tempS(i / colorLength).hex()];
          });
          temp.push([1, tempS(1).hex()]);

          data.push({
            type: "contour",
            z: zCorrected,
            colorscale: temp as any,
            showscale: false,
            line: {
              width: 0,
            },
            ncontours: 50,
            // contours: {
            //   coloring: "lines",
            // },
          });

          // -------------------------------------------- boundary line
          // const bGridPreds =
          //   trajectoryAnalysisResponse?.metricGridPredictions[
          //     boundaryMetric?.kpi.name ?? ""
          //   ];
          //
          // const bZData = bGridPreds ? bGridPreds.z : [];
          //
          // const bZCorrected: number[][] = [];
          // for (let rowI = 0; rowI < zData.length; rowI++) {
          //   // for (let rowI = zData.length - 1; rowI >= 0; rowI--) {
          //   const row = bZData[rowI];
          //   const newRow: number[] = [];
          //   // for (let i = row.length - 1; i >= 0; i--) {
          //   if (row == null) {
          //     continue;
          //   }
          //   for (let i = 0; i < row.length; i++) {
          //     // newRow.push(row[i]);
          //     newRow.push(bZData[i][rowI]);
          //   }
          //   bZCorrected.push(newRow);
          // }
          // -------------------------------------------- boundary line

          const tickVals = Array.from({ length: zData.length })
            .map((_v, i) => i)
            .filter((i) => i % 2 == 0);
          const layout: Partial<Plotly.Layout> = {
            title: "3D Surface Plot",
            autosize: true,
            margin: { l: 0, r: 0, t: 0, b: 0, pad: 0 },
            scene: {
              aspectmode: "cube",
              zaxis: {
                title: metric?.kpi.name ?? "",
                tickmode: "linear",
                tick0: 10,
                dtick: 1,
              },
              xaxis: {
                title: `${parameters[1].name} [${parameters[1].unit}]`,
                tickvals: tickVals,
                ticktext: tickVals.map((v) =>
                  (
                    (v / zData.length) *
                      ((parameters[1].max ?? 1) - (parameters[1].min ?? 0)) +
                    (parameters[1].min ?? 0)
                  ).toFixed(2)
                ),
              },
              yaxis: {
                title: `${parameters[0].name} [${parameters[0].unit}]`,
                tickvals: tickVals,
                ticktext: tickVals
                  .map((v) =>
                    (
                      (v / zData.length) *
                        ((parameters[0].max ?? 1) - (parameters[0].min ?? 0)) +
                      (parameters[0].min ?? 0)
                    ).toFixed(2)
                  )
                  .reverse(),
              },
            },
          };

          await Plotly.newPlot(
            egoName === "ITRI" ? "plotly_div" : "plotly_div2",
            data,
            layout
          ).then(function (gd: any) {
            promises.push(
              Plotly.toImage(gd, {
                format: "png",
                height: 500,
                width: 500,
              }).then(function (url: string) {
                const img = document.createElement("img");
                img.src = url;
                newMetricImages[metricName][gridMode] = img;
              })
            );
          });

          await Promise.allSettled(promises);
          promises.pop();
        }
      }
      console.log(egoName);
      console.log(newMetricImages);
      setMetricImages(newMetricImages);
    };

    createImages();
  }, [parameters, metrics]);

  const resizeObserver = useMemo(() => {
    return new ResizeObserver((entries) => {
      for (let entry of entries) {
        entry.target.dispatchEvent(new Event("resize"));
        console.log("RESIZE");
      }
    });
  }, []);

  useEffect(() => {
    const element = document.getElementById("height-map-root");
    if (element) {
      resizeObserver.observe(element);
    }
    return () => {
      if (element) {
        resizeObserver.unobserve(element);
      }
    };
  }, []);

  return (
    <>
      <Box component="div" id="plotly_div" sx={{ display: "none" }}></Box>
      <Box component="div" id="plotly_div2" sx={{ display: "none" }}></Box>
    </>
  );
}
