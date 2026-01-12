import chroma from "chroma-js";
import { SxProps, useTheme } from "@mui/material/styles";
import React from "react";
import { Box, Stack, Typography } from "@mui/material";
import _ from "lodash";

// @ts-ignore
import { symbol, symbolsStroke } from "d3-shape";

import { toTitleSpaceCase } from "@/app/_shared/utils";
import { GlyphCircle, GlyphSquare, GlyphTriangle } from "@visx/glyph";
import { useMemo } from "react";
import { useAppSelector } from "../../../../../redux/hooks";
import { scaleOrdinal, scaleThreshold } from "@visx/scale";
import { LegendThreshold, LegendItem, LegendLabel, Legend } from "@visx/legend";
import { ClusterInfo } from "../../../../../redux/slices/batch";

type Props = {
  sx?: SxProps;
};
export default function ScatterGroups({ sx }: Props) {
  const theme = useTheme();

  const clusteringResults = useAppSelector(
    (state) => state.batch.selectedClusteringResults
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedSafetyBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis
  );
  const clusterInfos = useAppSelector(
    (state) => state.batch.selectedClusterInfos
  );

  const metricColorscale = useMemo(() => {
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return chroma.scale("OrRd").padding([0.2, 0]).domain([0, 1]);
    }
    return chroma.scale("OrRd").padding([0.2, 0]).domain([1, 0]);
  }, [selectedMetric, trajectoryAnalysis]);

  const metricGradMagColorscale = useMemo(() => {
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
    // inferno.reverse();
    const scale = chroma.scale(inferno);
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return scale.domain([0, 1]);
    }
    return scale;
  }, [selectedMetric, trajectoryAnalysis]);

  const passFailColorscale = useMemo(() => {
    return chroma
      .scale([theme.palette.error.light, theme.palette.success.light])
      .domain([0, 1.0]);
  }, [selectedSafetyBoundaryMetric]);

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
    [metricColorscale]
  );
  const metricGradMagScale = useMemo(
    () =>
      scaleThreshold({
        domain: Array.from(
          { length: nColorSegments },
          (_, i) => i / nColorSegments
        ),
        range: Array.from({ length: nColorSegments }, (_, i) =>
          metricGradMagColorscale(i / nColorSegments).hex()
        ),
      }),
    [metricGradMagColorscale]
  );

  const clusterScales = useMemo(() => {
    if (clusterInfos == null) {
      return null;
    }
    console.log(clusterInfos);
    const result: { [egoName: string]: any } = {};
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      result[egoName] = scaleOrdinal({
        domain: Object.keys(clusterInfos[egoName] ?? {}),
        range: Object.keys(clusterInfos[egoName] ?? {}).map((label) => {
          return clusterInfos[egoName]
            ? clusterInfos[egoName][label].color
            : "black";
        }),
      });
    }
    return result;
  }, [clusterInfos]);

  const passFailScale = useMemo(() => {
    return scaleOrdinal<string, React.FC | React.ReactNode>({
      domain:
        selectedSafetyBoundaryMetric?.kpi.name === "collision"
          ? ["1", "0", "2"]
          : ["0", "1"],
      range: (selectedSafetyBoundaryMetric?.kpi.name === "collision"
        ? ["1", "0", "2"]
        : ["0", "1"]
      ).map((v) => {
        const shapeProps = {
          // fill:
          //   v === "1" ? theme.palette.success.light : theme.palette.error.light,
          fill: "black",
          left: 8,
          top: 10,
          size: 150,
        };
        let shape = <GlyphCircle key={`legend-passed-${v}`} {...shapeProps} />;
        if (v === "2") {
          shape = <GlyphTriangle key={`legend-passed-${v}`} {...shapeProps} />;
        }

        if (v === "0") {
          const st = v === "0" ? symbolsStroke[2] : symbolsStroke[0];
          // @ts-ignore
          const s = symbol(st);
          shape = (
            <path
              // stroke={theme.palette.error.light}
              stroke="black"
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
  }, [selectedSafetyBoundaryMetric]);

  const passFailColorLegendScale = useMemo(() => {
    return scaleOrdinal({
      domain:
        selectedSafetyBoundaryMetric?.kpi.name === "collision"
          ? ["0", "1", "2"]
          : ["0", "1"],
      range: (selectedSafetyBoundaryMetric?.kpi.name === "collision"
        ? ["0", "1", "2"]
        : ["0", "1"]
      ).map((v) => {
        return v === "1"
          ? theme.palette.success.light
          : v === "2"
            ? theme.palette.warning.light
            : theme.palette.error.light;
      }),
    });
  }, [selectedSafetyBoundaryMetric]);

  return (
    <Stack
      id="vector-field-legends"
      sx={{
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
          {`${toTitleSpaceCase(selectedMetric?.kpi.name ?? "")} [${selectedMetric?.kpi.unit
            }]`}
        </Typography>
        <Stack direction="row" justifyContent="center" alignItems="center">
          <LegendThreshold scale={metricScale}>
            {(labels) =>
              labels.map((label, i) => (
                <Box
                  key={`legend-quantile-${i}`}
                  sx={{
                    flex: 1,
                    width: "10px",
                    height: "20px",
                    background: label.value,
                  }}
                />
              ))
            }
          </LegendThreshold>
        </Stack>
        <Stack direction="row" justifyContent="space-between">
          <Typography fontSize={16} sx={{ mr: "3px" }}>
            {selectedMetric?.min?.toFixed(2)}
          </Typography>
          <Typography fontSize={16} sx={{ ml: "3px" }}>
            ≥{selectedMetric?.max?.toFixed(2)}
          </Typography>
        </Stack>
      </Stack>
      <Stack>
        <Typography fontSize={18}>
          {`${toTitleSpaceCase(selectedMetric?.kpi.name ?? "")} Change`}
        </Typography>
        <Stack direction="row" justifyContent="center" alignItems="center">
          <LegendThreshold scale={metricGradMagScale}>
            {(labels) =>
              labels.map((label, i) => (
                <Box
                  key={`legend-quantile-${i}`}
                  sx={{
                    flex: 1,
                    width: "10px",
                    height: "20px",
                    background: label.value,
                  }}
                />
              ))
            }
          </LegendThreshold>
        </Stack>
        <Stack direction="row" justifyContent="space-between">
          <Typography fontSize={16} sx={{ mr: "3px" }}>
            {selectedMetric?.gradMin?.toFixed(2)}
          </Typography>
          <Typography fontSize={16} sx={{ ml: "3px" }}>
            {selectedMetric?.gradMax?.toFixed(2)}
          </Typography>
        </Stack>
      </Stack>
      <Stack flexDirection="row" columnGap={3} flexWrap="wrap">
        <Stack>
          {Object.keys(trajectoryAnalysis ?? {}).map((egoName) => {
            if (clusteringResults == null) {
              return null;
            }
            // @ts-ignore
            const clusterScale = clusterScales[egoName] ?? null;
            const clusteringResult = clusteringResults[egoName] ?? null;
            if (clusteringResults == null || clusterScale == null) {
              return null;
            }
            console.log(clusterScales);
            return (
              <Stack key={egoName}>
                <Typography
                  fontSize={18}
                  sx={{ marginRight: "3px", paddingTop: "10px" }}
                >
                  {`Clusters`}
                </Typography>
                <Legend scale={clusterScale}>
                  {(labels) => (
                    <Stack
                      style={{
                        display: "flex",
                        flexDirection: "row",
                        columnGap: "10px",
                        alignItems: "center",
                        flexWrap: "wrap",
                      }}
                    >
                      {labels.map((label, i) => {
                        let labelNumber = Number(label.text);
                        if (
                          clusteringResult?.task.method.includes("hierarchy")
                        ) {
                          labelNumber += 1;
                        }
                        return (
                          <Stack
                            key={`legend-quantile-${i}`}
                            flexDirection="row"
                            columnGap={"5px"}
                            justifyContent="center"
                          // alignItems="center"
                          >
                            <Box
                              sx={{
                                width: "18px",
                                height: "18px",
                                background: label.value,
                              }}
                            />
                            <LegendLabel
                              align="left"
                              margin={0}
                              style={{ fontSize: "18px" }}
                            >
                              {label.text}
                            </LegendLabel>
                          </Stack>
                        );
                      })}
                    </Stack>
                  )}
                </Legend>
              </Stack>
            );
          })}
        </Stack>
      </Stack>

      <Stack flexDirection="row" columnGap={3} flexWrap="wrap">
        {selectedSafetyBoundaryMetric?.kpi.name === "collision" ? (
          <Stack>
            <Typography
              fontSize={18}
              sx={{ marginRight: "3px", paddingTop: "10px" }}
            >
              Collision
            </Typography>
            {/* <Stack direction="row" alignItems="center" rowGap={1} columnGap={1}> */}
            {/*   <Legend scale={passFailColorLegendScale}> */}
            {/*     {(labels) => ( */}
            {/*       <Stack */}
            {/*         sx={{ */}
            {/*           flexDirection: "row", */}
            {/*           columnGap: "10px", */}
            {/*           alignItems: "center", */}
            {/*         }} */}
            {/*       > */}
            {/*         {labels.map((label, i) => { */}
            {/*           let text = ""; */}
            {/**/}
            {/*           if (i === 0) { */}
            {/*             // text = "AV Cause"; */}
            {/*             text = "Yes"; */}
            {/*           } else if (i === 1) { */}
            {/*             // text = "No Collision"; */}
            {/*             text = "No"; */}
            {/*           } else { */}
            {/*             text = "Other Cause"; */}
            {/*             return null; */}
            {/*           } */}
            {/**/}
            {/*           return ( */}
            {/*             <Stack */}
            {/*               key={`legend-passfail-quantile-${i}`} */}
            {/*               flexDirection="row" */}
            {/*               columnGap={"5px"} */}
            {/*               justifyContent="center" */}
            {/*             > */}
            {/*               <Box */}
            {/*                 sx={{ */}
            {/*                   width: "18px", */}
            {/*                   height: "18px", */}
            {/*                   background: label.value, */}
            {/*                 }} */}
            {/*               /> */}
            {/*               <LegendLabel */}
            {/*                 align="left" */}
            {/*                 margin={0} */}
            {/*                 style={{ fontSize: "18px" }} */}
            {/*               > */}
            {/*                 {text} */}
            {/*               </LegendLabel> */}
            {/*             </Stack> */}
            {/*           ); */}
            {/*         })} */}
            {/*       </Stack> */}
            {/*     )} */}
            {/*   </Legend> */}
            {/* </Stack> */}
            <Stack
              direction="row"
              alignItems="center"
              rowGap={1}
              columnGap={1}
              sx={{ mt: 1 }}
            >
              <Legend scale={passFailScale}>
                {(labels) => (
                  <div
                    style={{
                      display: "flex",
                      flexDirection: "row",
                      columnGap: "10px",
                      alignItems: "center",
                    }}
                  >
                    {labels.map((label, i) => {
                      let text = "";

                      if (label.datum === "0") {
                        text = "Yes";
                        // text = "AV Cause";
                      } else if (label.datum === "1") {
                        // text = "No Collision";
                        text = "No";
                      } else {
                        text = "Other Cause";
                        return null;
                      }

                      const shape = passFailScale(label.datum);
                      return (
                        <LegendItem
                          key={`legend-passfail-quantile-${i}`}
                          style={{
                            display: "flex",
                            justifyContent: "center",
                            alignItems: "center",
                            minWidth: "65px",
                          }}
                        >
                          <svg width={"28px"} height={"18px"}>
                            {shape
                              ? React.cloneElement(shape as React.ReactElement)
                              : null}
                          </svg>
                          <LegendLabel
                            align="left"
                            margin={0}
                            style={{ fontSize: "18px", marginLeft: "3px" }}
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
        ) : (
          <Stack>
            <Typography
              fontSize={18}
              sx={{ marginRight: "3px", paddingTop: "10px" }}
            >
              {`${toTitleSpaceCase(
                selectedSafetyBoundaryMetric?.kpi.name ?? ""
              ) ?? "Pass / Fail"
                } ${selectedSafetyBoundaryMetric?.kpi.unit
                  ? `[${selectedSafetyBoundaryMetric?.kpi.unit}]`
                  : ""
                }`}
            </Typography>
            <Stack direction="row" alignItems="center" rowGap={1} columnGap={1}>
              <Legend scale={passFailColorLegendScale}>
                {(labels) => (
                  <Stack
                    sx={{
                      flexDirection: "row",
                      columnGap: "10px",
                      alignItems: "center",
                    }}
                  >
                    {labels.map((label, i) => {
                      let text = "";
                      let unit = selectedSafetyBoundaryMetric?.kpi.unit ?? "";

                      if (i === 0) {
                        if (unit === "boolean") {
                          text = `Fail (${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? "Yes"
                              : "No"
                            })`;
                        } else {
                          text = `Fail ${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? ">="
                              : "<="
                            } ${selectedSafetyBoundaryMetric?.threshold}`;
                        }
                      } else {
                        if (unit === "boolean") {
                          text = `Pass (${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? "No"
                              : "Yes"
                            })`;
                        } else {
                          text = `Pass ${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? "<"
                              : ">"
                            } ${selectedSafetyBoundaryMetric?.threshold}`;
                        }
                      }

                      return (
                        <Stack
                          key={`legend-passfail-quantile-${i}`}
                          flexDirection="row"
                          columnGap={"5px"}
                          justifyContent="center"
                        >
                          <Box
                            sx={{
                              width: "18px",
                              height: "18px",
                              background: label.value,
                            }}
                          />
                          <LegendLabel
                            align="left"
                            margin={0}
                            style={{ fontSize: "18px", textWrap: "nowrap" }}
                          >
                            {text}
                          </LegendLabel>
                        </Stack>
                      );
                    })}
                  </Stack>
                )}
              </Legend>
            </Stack>
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
                          text = `Fail (${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? "Yes"
                              : "No"
                            })`;
                        } else {
                          text = `Fail ${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? ">="
                              : "<="
                            } ${selectedSafetyBoundaryMetric?.threshold}`;
                        }
                      } else {
                        if (unit === "boolean") {
                          text = `Pass (${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
                              ? "No"
                              : "Yes"
                            })`;
                        } else {
                          text = `Pass ${selectedSafetyBoundaryMetric?.kpi.rule ===
                              "lessThan"
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
                          <svg width={"24px"} height={"18px"}>
                            {shape
                              ? React.cloneElement(shape as React.ReactElement)
                              : null}
                          </svg>
                          <LegendLabel
                            align="left"
                            margin={0}
                            style={{ fontSize: "18px", textWrap: "nowrap" }}
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
        )}
      </Stack>
    </Stack>
  );
}
