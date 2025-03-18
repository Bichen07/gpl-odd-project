import chroma from "chroma-js";
import { SxProps, useTheme } from "@mui/material/styles";
import React from "react";
import { symbol, symbolsStroke, symbolCircle } from "d3-shape";
import { Box, Stack, Typography } from "@mui/material";
import _ from "lodash";
import {
  GlyphCircle,
  GlyphStar,
  GlyphTriangle,
  GlyphSquare,
  GlyphWye,
  GlyphDiamond,
  GlyphCross,
} from "@visx/glyph";
import { ReactNode, useMemo } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { scaleLinear, scaleOrdinal, scaleThreshold } from "@visx/scale";
import { LegendThreshold, LegendItem, LegendLabel, Legend } from "@visx/legend";

type Props = {
  sx: SxProps;
};
export function Legends({ sx }: Props) {
  const theme = useTheme();

  const clusteringResult = useAppSelector(
    (state) => state.session.clusteringResult,
  );
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const shapeStrings = useAppSelector((state) => state.session.shapeStrings);

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
        clusterInfo
          ? Object.values(clusterInfo).map((v) => v.color)
          : ["black"],
      )
      .domain(
        clusterInfo ? Object.keys(clusterInfo).map((k) => Number(k)) : [0, 1],
      );
  }, [clusterInfo]);

  const nColorSegments = 100; // Number of segments
  const metricScale = useMemo(
    () =>
      scaleThreshold({
        domain: Array.from(
          { length: nColorSegments },
          (_, i) => i / nColorSegments,
        ),
        range: Array.from({ length: nColorSegments }, (_, i) =>
          metricColorscale(i / nColorSegments).hex(),
        ),
      }),
    [selectedMetric, metricColorscale],
  );

  const passFailScale = useMemo(
    () =>
      scaleThreshold({
        domain: [0, 1],
        range: [theme.palette.error.light, theme.palette.success.light],
      }),
    [passFailColorscale],
  );

  const clusterLegendScale = useMemo(
    () =>
      scaleOrdinal<string, React.FC | React.ReactNode>({
        domain: Object.keys(clusterInfo ?? {}),
        range: Object.keys(clusterInfo ?? {}).map((label) => {
          const shapeProps = {
            fill: clusterInfo ? clusterInfo[label].color : "black",
            key: `legend-cluster-${label}`,
            left: 7,
            top: 8,
            size: 70,
          };

          // console.log(shapeProps.size);
          // console.log(zoom.transformMatrix.scaleY);

          let labelNumber = Number(label);
          // if (clusteringResult?.task.method === "hierarchy") {
          //   labelNumber -= 1;
          // }
          const shapeIndex =
            labelNumber - 1 < 0 ? labelNumber : labelNumber - 1;
          const shapeString = shapeStrings[shapeIndex];

          let shape: ReactNode | null = null;
          if (shapeString === "circle") {
            shape = <GlyphCircle {...shapeProps} />;
          } else if (shapeString === "square") {
            shape = <GlyphSquare {...shapeProps} />;
          } else if (shapeString === "wye") {
            shape = <GlyphWye {...shapeProps} />;
          } else if (shapeString === "triangle") {
            shape = <GlyphTriangle {...shapeProps} transform="scale(1, -1)" />;
          } else if (shapeString === "diamond") {
            shape = <GlyphDiamond {...shapeProps} />;
          } else if (shapeString === "cross") {
            shape = <GlyphCross {...shapeProps} />;
          } else if (shapeString === "star") {
            shape = <GlyphStar {...shapeProps} />;
          }

          return shape;
        }),
      }),
    [clusterInfo],
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
        background: `${chroma(theme.palette.background.paper).alpha(0.9).hex()}`,
        backdropFilter: "blur(4px)",
        // height: "100%",
        // marginTop: margin.top,
        // marginBottom: margin.bottom,
        ...sx,
      }}
      rowGap={"5px"}
    >
      <Stack>
        <Typography fontSize={14}>
          {`${selectedMetric?.kpi.name} [${selectedMetric?.kpi.unit}]`}
        </Typography>
        <Stack direction="row" justifyContent="center" alignItems="center">
          <Typography fontSize={14} sx={{ mr: "3px" }}>
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
          <Typography fontSize={14} sx={{ ml: "3px" }}>
            {selectedMetric?.max?.toFixed(2)}
          </Typography>
        </Stack>
      </Stack>
      <Stack>
        <Typography fontSize={14} sx={{ marginRight: "3px" }}>
          {`${selectedSafetyBoundaryMetric?.kpi.name ?? "Pass / Fail"} ${selectedSafetyBoundaryMetric?.kpi.unit ? `[${selectedSafetyBoundaryMetric?.kpi.unit}]` : ""}`}
        </Typography>
        <Stack direction="row" alignItems="center" rowGap={1} columnGap={1}>
          <LegendThreshold scale={passFailScale}>
            {(labels) =>
              labels.map((label, i) => {
                let text = "";
                let unit = selectedSafetyBoundaryMetric?.kpi.unit ?? "";

                if (i === 0) {
                  if (unit === "boolean") {
                    text = `Fail (${selectedSafetyBoundaryMetric?.kpi.rule === "lessThan" ? "Yes" : "No"})`;
                  } else {
                    text = `Fail ${
                      selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                        ? ">="
                        : "<="
                    } ${selectedSafetyBoundaryMetric?.threshold}`;
                  }
                } else {
                  if (unit === "boolean") {
                    text = `Pass (${selectedSafetyBoundaryMetric?.kpi.rule === "lessThan" ? "No" : "Yes"})`;
                  } else {
                    text = `Pass ${
                      selectedSafetyBoundaryMetric?.kpi.rule === "lessThan"
                        ? "<"
                        : ">"
                    } ${selectedSafetyBoundaryMetric?.threshold}`;
                  }
                }
                const st = i === 0 ? symbolsStroke[2] : symbolsStroke[0];
                const s = symbol(st);
                return (
                  <Stack
                    direction="row"
                    justifyContent="center"
                    alignItems="center"
                    rowGap={0.5}
                    columnGap={0.5}
                    key={`legend-pass-fail-${i}`}
                  >
                    {/* <Box */}
                    {/*   key={`legend-pass-fail-${i}`} */}
                    {/*   sx={{ */}
                    {/*     flex: 1, */}
                    {/*     width: "10px", */}
                    {/*     height: "10px", */}
                    {/*     background: label.value, */}
                    {/*   }} */}
                    {/* /> */}
                    <svg
                      width={20}
                      height={20}
                      style={{
                        position: "relative",
                      }}
                    >
                      <path
                        stroke={label.value}
                        strokeWidth={3}
                        fill="none"
                        d={`${s()}`}
                        transform="translate(10, 10)"
                        // transform={`scale(${0.75})`}
                        // width={20}
                        // height={20}
                        // style={{
                        //   left: "5px",
                        // }}
                      />
                    </svg>
                    <Typography sx={{ fontSize: "14px", mt: "3px" }}>
                      {text}
                    </Typography>
                  </Stack>
                );
              })
            }
          </LegendThreshold>
        </Stack>
      </Stack>
      <Stack>
        <Typography fontSize={14} sx={{ marginRight: "3px" }}>
          Interaction Cluster
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
                if (clusteringResult?.task.method !== "hierarchy") {
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
                    <svg width={"14px"} height={"14px"}>
                      {React.cloneElement(shape as React.ReactElement)}
                    </svg>
                    <LegendLabel
                      align="left"
                      margin={0}
                      style={{ fontSize: "14px" }}
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
