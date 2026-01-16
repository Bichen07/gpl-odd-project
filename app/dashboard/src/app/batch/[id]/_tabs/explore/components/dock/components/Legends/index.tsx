import chroma from "chroma-js";
import { SxProps, useTheme } from "@mui/material/styles";
import React from "react";
import { Box, Stack, Typography } from "@mui/material";
import _ from "lodash";

// @ts-ignore
import { symbol, symbolsStroke } from "d3-shape";

import { GlyphCircle, GlyphSquare, GlyphCross } from "@visx/glyph";
import { ReactNode, useMemo } from "react";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import { scaleLinear, scaleOrdinal, scaleThreshold } from "@visx/scale";
import { LegendThreshold, LegendItem, LegendLabel, Legend } from "@visx/legend";

type Props = {
  sx: SxProps;
};
export function Legends({ sx }: Props) {
  const theme = useTheme();

  const clusteringResult = useAppSelector(
    (state) => state.batch.selectedClusteringResult
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis
  );
  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfo
  );
  const shapeStrings = useAppSelector((state) => state.batch.shapeStrings);

  const metricColorscale = useMemo(() => {
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    }
    return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
  }, [selectedMetric, trajectoryAnalysis]);

  const passFailColorscale = useMemo(() => {
    return chroma
      .scale([theme.palette.error.light, theme.palette.success.light])
      .domain([0, 1.0]);
  }, [selectedSafetyBoundaryMetric]);

  const clusterColorscale = useMemo(() => {
    return chroma
      .scale(
        clusterInfo ? Object.values(clusterInfo).map((v) => v.color) : ["black"]
      )
      .domain(
        clusterInfo ? Object.keys(clusterInfo).map((k) => Number(k)) : [0, 1]
      );
  }, [clusterInfo]);

  const nColorSegments = 100; // Number of segments
  const metricScale = useMemo(
    () =>
      scaleThreshold({
        domain: Array.from(
          { length: nColorSegments },
          (_, i) => i / nColorSegments
        ),
        range: Array.from({ length: nColorSegments }, (_, i) =>
          metricColorscale(i / nColorSegments).hex()
        ),
      }),
    [selectedMetric, metricColorscale]
  );

  const passFailScale = useMemo(() => {
    return scaleOrdinal<string, React.FC | React.ReactNode>({
      domain: ["0", "1"],
      range: ["0", "1"].map((v) => {
        const shapeProps = {
          fill:
            v === "1" ? theme.palette.success.light : theme.palette.error.light,
          left: 8,
          top: 10,
          size: 150,
        };
        let shape = <GlyphCircle key={`legend-passed-${v}`} {...shapeProps} />;

        if (v === "0") {
          const st = v === "0" ? symbolsStroke[2] : symbolsStroke[0];
          // @ts-ignore
          const s = symbol(st);
          shape = (
            <path
              stroke={theme.palette.error.light}
              strokeWidth={3}
              fill="none"
              d={`${s()}`}
              transform="translate(7.5, 10) scale(1.3)"
            />
          );
        }
        return shape;
      }),
    });
  }, [passFailColorscale]);

  const clusterLegendScale = useMemo(
    () =>
      scaleOrdinal<string, React.FC | React.ReactNode>({
        domain: Object.keys(clusterInfo ?? {}),
        range: Object.keys(clusterInfo ?? {}).map((label) => {
          const shapeProps = {
            fill: clusterInfo ? clusterInfo[label].color : "black",
            left: 8,
            top: 10,
            size: 150,
          };
          const shape = (
            <GlyphSquare key={`legend-cluster${label}`} {...shapeProps} />
          );
          return shape;
        }),
      }),
    [clusterInfo]
  );

  return (
    <Stack
      id="vector-field-legends"
      sx={{
        position: "absolute",
        top: "5px",
        right: "5px",
        width: "30%",
        border: `solid 1px ${theme.palette.divider}`,
        padding: 1,
        background: `${chroma(theme.palette.background.paper)
          .alpha(1.0)
          .hex()}`,
        backdropFilter: "blur(4px)",
        ...sx,
      }}
    >
      <Stack>
        <Typography fontSize={18}>
          {`${selectedMetric?.kpi.name} [${selectedMetric?.kpi.unit}]`}
        </Typography>
        <Stack direction="row" justifyContent="center" alignItems="center">
          <Typography fontSize={18} sx={{ mr: "3px" }}>
            {selectedMetric?.min?.toFixed(2)}
          </Typography>
          <LegendThreshold scale={metricScale}>
            {(labels) =>
              labels.map((label, i) => (
                <Box
                  key={`legend-quantile-${i}`}
                  sx={{
                    flex: 1,
                    width: "10px",
                    height: "10px",
                    background: label.value,
                  }}
                />
              ))
            }
          </LegendThreshold>
          <Typography fontSize={18} sx={{ ml: "3px" }}>
            {selectedMetric?.max?.toFixed(2)}
          </Typography>
        </Stack>
      </Stack>
      <Stack>
        <Typography
          fontSize={18}
          sx={{ marginRight: "3px", paddingTop: "10px" }}
        >
          {`${selectedSafetyBoundaryMetric?.kpi.name ?? "Pass / Fail"} ${
            selectedSafetyBoundaryMetric?.kpi.unit
              ? `[${selectedSafetyBoundaryMetric?.kpi.unit}]`
              : ""
          }`}
        </Typography>
        <Stack direction="row" alignItems="center" rowGap={1} columnGap={1}>
          <Legend scale={passFailScale}>
            {(labels) => (
              <div
                style={{
                  display: "flex",
                  flexDirection: "row",
                  columnGap: "5px",
                  alignItems: "center",
                }}
              >
                {labels.map((label, i) => {
                  let text = "";
                  let unit = selectedSafetyBoundaryMetric?.kpi.unit ?? "";

                  if (i === 0) {
                    if (unit === "boolean") {
                      text = `Fail (${
                        selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                          ? "Yes"
                          : "No"
                      })`;
                    } else {
                      text = `Fail ${
                        selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                          ? ">="
                          : "<="
                      } ${selectedSafetyBoundaryMetric?.threshold}`;
                    }
                  } else {
                    if (unit === "boolean") {
                      text = `Pass (${
                        selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                          ? "No"
                          : "Yes"
                      })`;
                    } else {
                      text = `Pass ${
                        selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                          ? "<"
                          : ">"
                      } ${selectedSafetyBoundaryMetric?.threshold}`;
                    }
                  }

                  const shape = passFailScale(label.datum);
                  return (
                    <LegendItem
                      key={`legend-passfail-quantile-${i}`}
                      style={{
                        display: "flex",
                        justifyContent: "center",
                      }}
                    >
                      <svg width={"18px"} height={"18px"}>
                        {shape
                          ? React.cloneElement(shape as React.ReactElement)
                          : null}
                      </svg>
                      <LegendLabel
                        align="left"
                        margin={0}
                        style={{ fontSize: "18px" }}
                      >
                        {text}
                      </LegendLabel>
                    </LegendItem>
                  );
                })}
              </div>
            )}
          </Legend>
        </Stack>
      </Stack>
      <Stack>
        <Typography
          fontSize={18}
          sx={{ marginRight: "3px", paddingTop: "10px" }}
        >
          Cluster
        </Typography>
        <Legend scale={clusterLegendScale}>
          {(labels) => (
            <div
              style={{
                display: "flex",
                flexDirection: "row",
                columnGap: "5px",
                alignItems: "center",
              }}
            >
              {labels.map((label, i) => {
                const shape = clusterLegendScale(label.datum);
                let labelNumber = Number(label.text);
                if (clusteringResult?.task.method.includes("hierarchy")) {
                  labelNumber += 1;
                }
                return (
                  <LegendItem
                    key={`legend-quantile-${i}`}
                    style={{
                      display: "flex",
                      justifyContent: "center",
                    }}
                  >
                    <svg width={"18px"} height={"18px"}>
                      {shape
                        ? React.cloneElement(shape as React.ReactElement)
                        : null}
                    </svg>
                    <LegendLabel
                      align="left"
                      margin={0}
                      style={{ fontSize: "18px" }}
                    >
                      {label.text}
                    </LegendLabel>
                  </LegendItem>
                );
              })}
            </div>
          )}
        </Legend>
      </Stack>
    </Stack>
  );
}
