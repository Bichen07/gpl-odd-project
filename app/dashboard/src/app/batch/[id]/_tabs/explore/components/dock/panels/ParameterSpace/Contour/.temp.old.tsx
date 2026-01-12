"use client";

import chroma from "chroma-js";
import { select } from "d3";
import { Box } from "@mui/material";
import { SxProps } from "@mui/material/styles";
// @ts-ignore
import Plotly from "plotly.js-dist";
import { RefObject, useEffect, useMemo, useState } from "react";
import { useAppSelector } from "../../../../../redux/hooks";

window.global = window;

type Props = {
  imgRef: RefObject<HTMLImageElement | null>;
};
export default function Contour({ imgRef }: Props) {
  const boundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const gridMode = useAppSelector((state) => state.batch.gridMode);
  const metric = selectedMetric;
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
    if (parameters == null || metric == null) {
      return;
    }

    const getcolor = (t: number) => {
      let min = metric?.min ?? 0;
      let max = metric?.max ?? 1;
      const normalized = (t - min) / (max - min);
      return colorscale(normalized).hex();
    };

    try {
      setScatterPlotData([]);

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
          x: trial.parameters.find((tp) => tp.parameterId === parameters[0].id)
            ?.value!,
          y: trial.parameters.find((tp) => tp.parameterId === parameters[1].id)
            ?.value!,
          colorValue: trialMetric?.value ?? NaN,
          colorString:
            trialMetric?.value == null ? "black" : getcolor(trialMetric?.value),
          id: trial.id ?? "",
        });
        visited.add(trial.id ?? "");
      }
      setScatterPlotData(plotData);
    } catch (error) {
      console.error(error);
      setScatterPlotData([]);
    }
  }, [parameters, metric]);

  useEffect(() => {
    const data: Plotly.Data[] = [];

    if (scatterPlotData.length === 0 || metric == null || parameters == null) {
      console.log("return");
      return;
    }

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

    // const base = chroma("maroon");
    // const sat = chroma
    //   .scale([
    //     base.set("hsl.s", 0), // Desaturated (grayish)
    //     base.set("hsl.s", 1), // Fully saturated
    //   ])
    //   .colors(6); // 6 steps

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
    // const hot = chroma
    //   .scale([
    //     "#000000", // black
    //     "#ff0000", // red
    //     // "#ffff00", // yellow
    //     // "#ffffff", // white
    //   ])
    //   .mode("rgb");
    // const scale = chroma.scale(hot).mode("lab");
    // const scale = chroma.scale(["white", "pink"]).mode("lab");
    // const scale = chroma
    //   .scale([
    //     chroma.lch(75, 50, 70), // light orange (less dangerous)
    //     chroma.lch(50, 50, 30), // red (more dangerous)
    //   ])
    //   .mode("hsl");
    // const scale = chroma.scale(["black", "maroon"]).mode("hsl");

    // const baseScale = chroma.scale('OrRd').mode('lab');
    // Sample and brighten the colors
    // const lighterColors = baseScale.colors(6).map(c => chroma(c).brighten(1));

    // const lighterColors = chroma.brewer.YlOrRd.slice(0, -2).map((c) =>
    //   chroma(c).brighten(1)
    // );
    // // Create a new lighter scale using those colors
    // const scale = chroma.scale(lighterColors).mode("lab");

    // let tempS = chroma.scale(sat).domain([1, 0]);
    // let tempS = scale.domain([1, 0]);
    // const scale = chroma
    //   .scale(chroma.brewer.OrRd.map((c) => chroma(c).darken(0).hex()))
    //   .mode("lab");
    //
    let scale = chroma.scale("OrRd").padding([0.2, 0]);
    if (
      gridMode === "gradient" &&
      trajectoryAnalysisResponse?.metricGridGradients != null
    ) {
      scale = chroma.scale(inferno);
    }
    // let tempS = chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
    let tempS = scale.domain([1, 0]);
    // let tempS = chroma.scale(["#f8f8f8", "#bcbcbc", "#666666"]).domain([1, 0]);
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      // tempS = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
      // tempS = chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
      // tempS = chroma.scale(["#f8f8f8", "#bcbcbc", "#666666"]).domain([0, 1]);
      // tempS = chroma.scale(sat).domain([0, 1]);
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
      // height: "100%",
      // width: "100%",
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

    const img_jpg = select("#contour-img");
    Plotly.newPlot("plotly_div", data, layout).then(function (gd: any) {
      Plotly.toImage(gd, { format: "png", height: 500, width: 500 }).then(
        function (url: string) {
          img_jpg.attr("src", url);
          if (imgRef.current) {
            imgRef.current.src = url;
          }
        }
      );
    });

    return;
  }, [boundaryMetric, selectedMetric, gridMode]);

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
      <img
        ref={imgRef}
        id="contour-img"
        style={{
          objectFit: "fill",
          width: "100%",
          height: "100%",
          display: "none",
        }}
      />
    </>
  );
}
