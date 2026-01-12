import { scaleOrdinal, scaleLog } from "@visx/scale";
import { LegendOrdinal, LegendItem } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useTheme } from "@mui/material/styles";
import { useEffect, useState } from "react";
import chroma from "chroma-js";
import { toTitleSpaceCase } from "@/app/_shared/utils";
import { useAppSelector } from "../../../../../redux/hooks";

const RAD2DEG = 180 / 3.14159265;

type Props = {
  sx?: SxProps;
  bound: {
    [attribute: string]: { range: [number, number]; colorscale: chroma.Scale };
  } | null;
  filteredAttributes: string[] | null;
};
export default function HeatmapColorscales({
  sx,
  bound,
  filteredAttributes,
}: Props) {
  const theme = useTheme();

  const [scales, setScales] = useState<{ [attribute: string]: any }>({});
  const attributes = useAppSelector((state) => state.batch.attributes);

  const scaleFactorSize = 500;
  const scaleFactors = Array.from(
    { length: scaleFactorSize + 1 },
    (_, i) => i / scaleFactorSize
  );
  const halfScaleFactorSize = scaleFactorSize / 2;
  const halfScaleFactors = Array.from(
    { length: halfScaleFactorSize + 1 },
    (_, i) => i / halfScaleFactorSize
  );
  useEffect(() => {
    if (bound == null || attributes == null) {
      return;
    }
    const updatedScales: typeof scales = {};
    for (let attribute of attributes) {
      if (attribute.includes("Theta")) {
        continue;
      }
      if (
        attribute.includes("RelativeDistance") &&
        Object.keys(updatedScales).find((v) => v.includes("RelativeDistance"))
      ) {
        continue;
      }
      if (
        attribute.includes("Ttc") &&
        Object.keys(updatedScales).find((v) => v.includes("Ttc"))
      ) {
        continue;
      }
      if (
        attribute.includes("Spret") &&
        Object.keys(updatedScales).find((v) => v.includes("Spret"))
      ) {
        continue;
      }
      let thresholdScale: any = scaleOrdinal({
        domain: scaleFactors,
        range: scaleFactors.map((factor) =>
          bound[attribute].colorscale(factor).hex()
        ),
      });
      if (
        attribute.includes("Distance") ||
        attribute.includes("EgoSpeed") ||
        attribute.includes("Ttc") ||
        attribute.includes("Spret")
      ) {
        thresholdScale = scaleOrdinal({
          domain: halfScaleFactors,
          range: halfScaleFactors.map((factor) =>
            bound[attribute].colorscale(factor).hex()
          ),
        });
      }
      if (attribute.includes("RelativeDistance")) {
        thresholdScale = scaleLog({
          domain: [0, 1],
          range: scaleFactors.map((factor) =>
            bound[attribute].colorscale(factor).hex()
          ),
          base: 10,
        });
      }
      updatedScales[attribute] = thresholdScale;
    }
    setScales(updatedScales);
  }, [bound, attributes]);

  const getUnit = (attribute: string) => {
    if (
      attribute === "speed" ||
      attribute.includes("Speed") ||
      attribute.includes("Velocity")
    ) {
      return "kph";
    } else if (attribute.includes("awRate")) {
      return "deg/s";
    } else if (attribute.includes("Yaw")) {
      return "deg";
    } else if (attribute.includes("Acceleration")) {
      return "m/s^2";
    } else if (attribute.includes("Theta")) {
      return "deg";
    } else if (attribute.includes("Ttc")) {
      return "sec";
    } else if (attribute.includes("Spret")) {
      return "sec^2";
    } else {
      return "m";
    }
  };
  const displayValue = (value: number, attribute: string) => {
    if (
      attribute === "speed" ||
      attribute.includes("Speed") ||
      attribute.includes("Velocity")
    ) {
      return value * 3.6;
    } else if (
      attribute === "yawRate" ||
      attribute.includes("Yaw") ||
      attribute.includes("Theta")
    ) {
      return value * RAD2DEG;
    } else if (attribute.includes("EgoAcc")) {
      if (value < -10) {
        value = -10;
      }
      return value;
    } else {
      return value;
    }
  };

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
  ].reverse();
  const distanceColorscale = chroma
    .scale(inferno)
    .mode("lch")
    .domain([0, 1])
    .classes([0, 0.1, 0.3, 1, 3, 10, 30, 30.1].map((v) => v / 30.1));

  return (
    <Stack
      sx={{
        backgroundColor: theme.palette.background.paper + "bb",
        borderRadius: "5px",
        borderStyle: "solid",
        borderColor: "divider",
        borderWidth: "1px",
        p: 1,
        ...sx,
      }}
    >
      {bound == null
        ? null
        : Object.entries(scales)
          .sort((a, b) => {
            let aValue = 0;
            let bValue = 0;
            if (a[0].includes("RelativeDistance")) {
              aValue = 2;
            }
            if (b[0].includes("RelativeDistance")) {
              bValue = 2;
            }
            if (a[0].includes("Ttc") || a[0].includes("Spret")) {
              aValue = 1;
            }
            if (b[0].includes("Ttc") || b[0].includes("Spret")) {
              bValue = 1;
            }
            return aValue - bValue;
          })
          .map(([attribute, scale]) => {
            if (attribute.includes("Distance")) {
              return null;
            }
            return (
              <Box component="div" key={attribute}>
                <Typography sx={{ fontSize: 18, mt: 0.5 }}>
                  {`${attribute.includes("RelativeDistance")
                      ? "Relative Distance"
                      : attribute.includes("Ttc")
                        ? "TTC"
                        : toTitleSpaceCase(attribute)
                    } [${getUnit(attribute)}]`}
                </Typography>
                <LegendOrdinal scale={scale}>
                  {(labels) => (
                    <Stack direction="row">
                      {bound[attribute].range[0] >= 0 ? (
                        <Box component="div" sx={{ flex: 1 }} />
                      ) : null}
                      <Stack sx={{ flex: 1 }}>
                        <Stack
                          direction="row"
                          sx={{
                            width: "100%",

                            position: "relative",
                            "&::after": {
                              display: attribute.includes("RelativeDistance")
                                ? "flex"
                                : "none",
                              content: "'collide'",
                              height: "100%",
                              width: "7ch",
                              background: "#e08214",
                              position: "absolute",
                              left: 0,
                              transform: "translateX(-100%)",
                              justifyContent: "center",
                              alignItems: "center",
                            },
                          }}
                          columnGap={"-1px"}
                        >
                          {labels.map((label, i) => (
                            <Box
                              key={`legend-quantile-${i}`}
                              sx={{
                                flex: 1,
                                width: "100%",
                                height: "20px",
                                background: label.value,
                              }}
                            />
                          ))}
                        </Stack>
                        <Stack direction="row" justifyContent="space-between">
                          <Typography sx={{ fontSize: 16, mr: 1 }}>
                            {attribute.includes("Acceleration") ? "≤ " : ""}
                            {displayValue(
                              bound[attribute].range[0],
                              attribute
                            ).toFixed(2)}
                          </Typography>
                          <Typography sx={{ fontSize: 16, ml: 1 }}>
                            {attribute.includes("Distance") ||
                              attribute.includes("Acceleration") ||
                              attribute.includes("Ttc") ||
                              attribute.includes("Spret")
                              ? "≥ "
                              : ""}
                            {attribute.includes("Ttc")
                              ? 5
                              : attribute.includes("Spret")
                                ? 5
                                : displayValue(
                                  bound[attribute].range[1],
                                  attribute
                                ).toFixed(2)}
                          </Typography>
                        </Stack>
                      </Stack>
                    </Stack>
                  )}
                </LegendOrdinal>
              </Box>
            );
          })}
      <Stack>
        <Typography sx={{ fontSize: 18 }}>Relative Distance [m]</Typography>
        <Stack
          direction="row"
          sx={{ width: "100%", height: "40px", flexWrap: "nowrap" }}
        >
          {[0, 1, 2, 3, 4, 5, 6, 7].map((i) => {
            const factors = [0, 0.1, 0.3, 1, 3, 10, 30, 30.1].map(
              (v) => v / 30.1
            );
            const labels = [0, 0.1, 0.3, 1, 3, 10, 30, ">30"];
            let color = distanceColorscale(factors[i]).hex();
            return (
              <Box
                component="div"
                sx={{
                  flex: i !== 7 ? 1 : 0,
                  background: color,
                  height: "20px",
                  position: "relative",
                }}
              >
                <Typography
                  sx={{
                    fontSize: 16,
                    position: "absolute",
                    bottom: "-23px",
                    transform: "translateX(-50%)",
                  }}
                >
                  {labels[i]}
                </Typography>
              </Box>
            );
          })}
        </Stack>
      </Stack>
      <Stack sx={{ width: "100%" }} rowGap={1}>
        <Typography sx={{ fontSize: 18 }}>Relative Theta [deg]</Typography>
        <Stack sx={{ width: "100%" }}>
          <img
            src="/theta.png"
            style={{
              width: "100%",
              height: "auto",
              display: "block",
              maxWidth: "200px",
            }}
          />
        </Stack>
      </Stack>
    </Stack>
  );
}
