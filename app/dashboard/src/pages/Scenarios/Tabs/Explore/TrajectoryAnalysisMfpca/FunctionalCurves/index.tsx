import chroma from "chroma-js";
import { FpcPlot } from "./Plot";
import { Stack, Typography } from "@mui/material";
import { useEffect, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import { MeanPlot } from "./MeanPlot";

export default function FunctionalCurves() {
  const [plotData, setPlotData] = useState<{
    [name: string]: {
      attribute: string;
      color?: string;
      line?: number[];
      sortValue?: number;
    }[];
  }>();

  const clustering = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse?.clustering,
  );

  useEffect(() => {
    if (!clustering) {
      return;
    }
    const attributes = clustering.attributes;
    if (attributes == null || attributes.length === 0) {
      return;
    }
    let fpcs = clustering.fpcs;
    let mean = clustering.means;
    const newPlotData: typeof plotData = {};
    for (let fpcNumber = 0; fpcNumber < fpcs.length - 1; fpcNumber++) {
      newPlotData[`FPC${fpcNumber}`] = [];
      for (const [index, attribute] of attributes.entries()) {
        // if (index > 3) {
        //   continue;
        // }
        const maxMag = Math.max(
          ...fpcs[index][fpcNumber].map((v) => Math.abs(v)),
        );
        newPlotData[`FPC${fpcNumber}`].push({
          attribute,
          color: chroma("black").hex(),
          line: fpcs[index][fpcNumber],
          sortValue: maxMag,
        });
      }
    }
    for (const item of Object.values(newPlotData)) {
      item.sort((a, b) => (b.sortValue ?? 0) - (a.sortValue ?? 0));
    }
    newPlotData["mean"] = [];
    for (const [index, attribute] of attributes.entries()) {
      newPlotData["mean"].push({
        attribute,
        color: "black",
        // line: mean[index].map((value) =>
        //   attribute.includes("Speed")
        //     ? value * 3.6
        //     : attribute.includes("Yaw")
        //       ? (value * 180) / 3.14
        //       : value,
        // ),
        line: [],
      });
    }
    setPlotData(newPlotData);
  }, [clustering]);

  return (
    <Stack>
      <Typography variant="subtitle1">Functional Curves</Typography>
      <Stack direction="row">
        {Object.entries(plotData ?? {}).map(([name, plotDataItem]) => {
          if (name === "mean") {
            return (
              <Stack>
                <Typography variant="subtitle2">Mean</Typography>
                <Stack direction="row">
                  {Object.entries(plotDataItem).map(
                    ([attribute, attributePlotData]) => {
                      return (
                        <Stack key={`${name}-${attribute}`} sx={{ p: 1 }}>
                          <Typography variant="caption">
                            {attributePlotData.attribute}
                          </Typography>
                          <MeanPlot data={{ main: attributePlotData }} />
                        </Stack>
                      );
                    },
                  )}
                </Stack>
              </Stack>
            );
          }
        })}
      </Stack>
      <Stack direction="row">
        {Object.entries(plotData ?? {}).map(([name, plotDataItem]) => {
          if (name === "mean") {
            return null;
          }
          return (
            <Stack key={name}>
              <Typography variant="subtitle2">{name}</Typography>
              <FpcPlot data={plotDataItem} />
            </Stack>
          );
        })}
      </Stack>
    </Stack>
  );
}
