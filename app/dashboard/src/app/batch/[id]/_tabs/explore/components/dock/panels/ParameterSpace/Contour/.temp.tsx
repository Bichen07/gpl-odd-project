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
}: {
  setMetricImages: Dispatch<
    SetStateAction<{
      [metricName: string]: {
        [gridMode: string]: HTMLImageElement;
      };
    }>
  >;
}) {
  const backgroundDrawingCanvasRef = useRef<HTMLCanvasElement>(null);

  const boundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const gridMode = useAppSelector((state) => state.batch.gridMode);
  const metric = selectedMetric;
  const metrics = useAppSelector((state) => state.batch.metrics);
  const trajectoryAnalysisResponse = useAppSelector(
    (state) => state.batch.trajectoryAnalysis
  );
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

  const colorscale = useMemo(() => {
    const base = chroma("red");
    const sat = chroma
      .scale([
        base.set("hsl.s", 0), // Desaturated (grayish)
        base.set("hsl.s", 1), // Fully saturated
      ])
      .colors(6); // 6 steps
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      // return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
      return chroma.scale(sat).domain([0, 1]);
    }
    return chroma.scale(sat).domain([1, 0]);
  }, [metric]);

  useEffect(() => {
    if (parameters == null) {
      return;
    }

    const newMetricImages: {
      [metricName: string]: { [gridMode: string]: HTMLImageElement };
    } = {};

    const createImages = async () => {
      const promises: Promise<any>[] = [];
      for (const [metricName, metric] of Object.entries(metrics ?? {})) {
        newMetricImages[metricName] = {};
        const getcolor = (t: number) => {
          let min = metric?.min ?? 0;
          let max = metric?.max ?? 1;
          const normalized = (t - min) / (max - min);
          return colorscale(normalized).hex();
        };

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
          if (visited.has(trial.id ?? "")) {
            continue;
          }

          const trialMetric = trial.testObjectives?.criticalityMetrics.find(
            (m) => m.keyPerformanceIndicator.id === metric?.kpi?.id
          );
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
            colorString:
              trialMetric?.value == null
                ? "black"
                : getcolor(trialMetric?.value),
            id: trial.id ?? "",
          });
          visited.add(trial.id ?? "");
        }

        for (const gridMode of ["prediction", "gradient"]) {
          const data: Plotly.Data[] = [];
          let gridPreds =
            trajectoryAnalysisResponse?.metricGridPredictions[
              selectedMetric?.kpi.name ?? ""
            ];

          if (
            gridMode === "gradient" &&
            trajectoryAnalysisResponse?.metricGridGradients != null
          ) {
            gridPreds =
              trajectoryAnalysisResponse?.metricGridGradients[
                selectedMetric?.kpi.name ?? ""
              ];
          }

          const zData = gridPreds ? gridPreds.z : [];

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

          const getcolor = (t: number) => {
            let min = metric?.min ?? 0;
            let max = metric?.max ?? 1;
            const normalized = (t - min) / (max - min);
            return colorscale(normalized).hex();
            // return interpolateMagma(normalized);
          };

          const getMetricValue = (t: number) => {
            let min = metric?.min ?? 0;
            let max = metric?.max ?? 1;
            return t * (max - min) + min;
          };

          const colorLength = 25;
          const colormap = Array.from({ length: colorLength }).map((v, i) => {
            return [getMetricValue(i / colorLength), getcolor(i / colorLength)];
          });
          colormap.push([getMetricValue(1), getcolor(1)]);

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
          if (
            gridMode === "gradient" &&
            trajectoryAnalysisResponse?.metricGridGradients != null
          ) {
            scale = chroma.scale(inferno);
          }
          let tempS = scale.domain([1, 0]);
          if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
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
            ncontours: 100,
            // contours: {
            //   coloring: "lines",
            // },
          });

          // -------------------------------------------- boundary line
          const bGridPreds =
            trajectoryAnalysisResponse?.metricGridPredictions[
              boundaryMetric?.kpi.name ?? ""
            ];

          const bZData = bGridPreds ? bGridPreds.z : [];

          const bZCorrected: number[][] = [];
          for (let rowI = 0; rowI < zData.length; rowI++) {
            // for (let rowI = zData.length - 1; rowI >= 0; rowI--) {
            const row = bZData[rowI];
            const newRow: number[] = [];
            // for (let i = row.length - 1; i >= 0; i--) {
            if (row == null) {
              continue;
            }
            for (let i = 0; i < row.length; i++) {
              // newRow.push(row[i]);
              newRow.push(bZData[i][rowI]);
            }
            bZCorrected.push(newRow);
          }
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
                title: selectedMetric?.kpi.name ?? "",
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

          await Plotly.newPlot("plotly_div", data, layout).then(function (
            gd: any
          ) {
            promises.push(
              Plotly.toImage(gd, {
                format: "png",
                height: 500,
                width: 500,
              }).then(function (url: string) {
                const img = document.createElement("img");
                img.src = url;
                console.log(metricName);
                console.log(gridMode);
                console.log(url);
                newMetricImages[metricName][gridMode] = img;
              })
            );
          });

          await Promise.allSettled(promises).then((results) =>
            console.log(results)
          );
          promises.pop();
        }
      }
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
      <canvas
        ref={backgroundDrawingCanvasRef}
        width={500}
        height={500}
        style={{ display: "none" }}
      />
    </>
  );
}
