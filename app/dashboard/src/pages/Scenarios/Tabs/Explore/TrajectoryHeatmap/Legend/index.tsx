import { scaleOrdinal } from "@visx/scale";
import { LegendOrdinal, LegendItem } from "@visx/legend";
import { Box, SxProps, Typography } from "@mui/material";
import { Stack } from "@mui/system";
import { useTheme } from "@mui/material/styles";
import { useEffect, useState } from "react";
import chroma from "chroma-js";
import { RAD2DEG } from "three/src/math/MathUtils.js";

type Props = {
  sx?: SxProps;
  bound: {
    [attribute: string]: { range: [number, number]; colorscale: chroma.Scale };
  } | null;
  filteredAttributes: string[] | null;
};
export default function Legend({ sx, bound, filteredAttributes }: Props) {
  const theme = useTheme();

  const [scales, setScales] = useState<{ [attribute: string]: any }>({});

  const scaleFactorSize = 50;
  const scaleFactors = Array.from(
    { length: scaleFactorSize + 1 },
    (_, i) => i / scaleFactorSize,
  );
  useEffect(() => {
    if (bound == null || filteredAttributes == null) {
      return;
    }
    const updatedScales: typeof scales = {};
    for (const attribute of filteredAttributes) {
      const thresholdScale = scaleOrdinal({
        domain: scaleFactors,
        range: scaleFactors.map((factor) =>
          bound[attribute].colorscale(factor).hex(),
        ),
      });
      updatedScales[attribute] = thresholdScale;
    }
    setScales(updatedScales);
  }, [bound, filteredAttributes]);

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
      return "mps2";
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
    } else if (attribute === "yawRate" || attribute.includes("Yaw")) {
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
        : Object.entries(scales).map(([attribute, scale]) => {
            return (
              <Box component="div" key={attribute}>
                <Typography sx={{ fontSize: 14, mt: 0.5 }}>
                  {`${attribute} [${getUnit(attribute)}]`}
                </Typography>
                <LegendOrdinal scale={scale}>
                  {(labels) => (
                    <Stack direction="row" sx={{ maxWidth: "500px" }}>
                      {bound[attribute].range[0] >= 0 ? (
                        <Box component="div" sx={{ flex: 1 }} />
                      ) : null}
                      <Stack sx={{ flex: 1 }}>
                        <Stack direction="row" sx={{ width: "100%" }}>
                          {labels.map((label, i) => (
                            <LegendItem
                              key={`legend-quantile-${i}`}
                              margin="0px -0.1px"
                              style={{ flex: 1 }}
                            >
                              <svg width={"100%"} height={14}>
                                <rect
                                  fill={label.value}
                                  width={"100%"}
                                  height={14}
                                />
                              </svg>
                            </LegendItem>
                          ))}
                        </Stack>
                        <Stack direction="row" justifyContent="space-between">
                          <Typography sx={{ fontSize: 12, mr: 1 }}>
                            {displayValue(
                              bound[attribute].range[0],
                              attribute,
                            ).toFixed(2)}
                          </Typography>
                          <Typography sx={{ fontSize: 12, ml: 1 }}>
                            {displayValue(
                              bound[attribute].range[1],
                              attribute,
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
    </Stack>
  );
}
