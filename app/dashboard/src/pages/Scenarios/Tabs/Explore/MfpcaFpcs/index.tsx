import {
  Box,
  Stack,
  Typography,
  CircularProgress,
  IconButton,
  Menu,
  ToggleButtonGroup,
  ToggleButton,
  Select,
  MenuItem,
  FormControlLabel,
  Checkbox,
} from "@mui/material";
import { useTheme } from "@mui/material/styles";
import { Legend } from "./Legend";
import SettingsIcon from "@mui/icons-material/Settings";
import { useEffect, useMemo, useRef, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import { Plot } from "./Plot";
import distinctColors from "distinct-colors";

const plotModes = ["fpcs", "mean"] as const;
type PlotMode = (typeof plotModes)[number];

type Props = {
  isBoundaryDiffMode: boolean;
};
export function MfpcaFpcs({ isBoundaryDiffMode }: Props) {
  const theme = useTheme();

  const menuAnchorRef = useRef<HTMLDivElement>(null);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [openMenu, setOpenMenu] = useState(false);
  useEffect(() => {
    setAnchorEl(menuAnchorRef.current);
  }, [menuAnchorRef.current]);

  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );

  const [plotMode, setPlotMode] = useState<PlotMode>("fpcs");
  const [viewFpcs, setViewFpcs] = useState<Set<number>>(new Set());
  const [fpcColor, setFpcColor] = useState<string[] | null>(null);
  const [failurePlotData, setFailurePlotData] = useState<{
    [featureName: string]: {
      [name: string]: {
        color?: string;
        line?: number[];
      };
    };
  }>();

  const clustering = useMemo(() => {
    return isBoundaryDiffMode
      ? clusteringResponse?.boundaryDiffClustering
      : clusteringResponse?.failureClustering;
  }, [isBoundaryDiffMode, clusteringResponse]);

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
    console.log(mean);
    let colors = distinctColors({
      count: isBoundaryDiffMode ? fpcs[0].length : fpcs[0].length,
      chromaMin: 30,
      chromaMax: 134,
      lightMin: 35,
      lightMax: 90,
    });
    setFpcColor(colors.map((c) => c.hex()));
    const newPlotData: typeof failurePlotData = {};
    for (const [index, attribute] of attributes.entries()) {
      newPlotData[attribute] = {};
      if (plotMode === "fpcs") {
        for (let i = 0; i < fpcs[index].length; i++) {
          // const [min, max] = attribute.range;
          if (!viewFpcs.has(i)) {
            continue;
          }
          newPlotData[attribute][`FPC${i}`] = {
            color: colors[i].hex(),
            line: fpcs[index][i],
          };
        }
      } else {
        newPlotData[attribute]["mean"] = {
          color: "black",
          line: mean[index].map((value) =>
            attribute.includes("speed")
              ? value * 3.6
              : attribute.includes("yaw")
                ? (value * 180) / 3.14
                : value,
          ),
        };
      }
    }
    setFailurePlotData(newPlotData);
  }, [clustering, viewFpcs]);

  return (
    <Stack
      sx={{
        position: "relative",
        width: "100%",
        height: "100%",
      }}
    >
      <Box component="div" sx={{ marginLeft: "auto" }}>
        <Stack direction="row" columnGap={1}>
          <Legend fpcColors={fpcColor} />
          <IconButton
            component="div"
            ref={menuAnchorRef}
            onClick={() => setOpenMenu(true)}
          >
            <SettingsIcon sx={{ color: "text.disabled" }} />
          </IconButton>
        </Stack>
        <Menu
          anchorEl={anchorEl}
          open={openMenu}
          onClose={() => setOpenMenu(false)}
        >
          <Stack sx={{ p: 1, maxWidth: "500px" }}>
            <ToggleButtonGroup
              sx={{ mr: 2 }}
              size="small"
              color="primary"
              value={plotMode}
              defaultValue={plotMode}
              exclusive
              onChange={(_event, value) => {
                setPlotMode(value as PlotMode);
              }}
            >
              {plotModes.map((mode) => (
                <ToggleButton value={mode}>{mode}</ToggleButton>
              ))}
            </ToggleButtonGroup>
            <Stack direction="row" flexWrap="wrap" rowGap={2} columnGap={2}>
              {clustering?.fpcs[0].map((_item, i) => {
                return (
                  <Stack
                    direction="row"
                    justifyContent="center"
                    alignItems="center"
                  >
                    <FormControlLabel
                      key={i}
                      sx={{ m: 0 }}
                      control={
                        <Checkbox
                          checked={viewFpcs.has(i)}
                          sx={{ p: 0 }}
                          onChange={(_event, checked) => {
                            setViewFpcs((prev) => {
                              const newSet = new Set(prev);
                              if (checked) {
                                newSet.add(i);
                              } else {
                                newSet.delete(i);
                              }
                              return newSet;
                            });
                          }}
                        />
                      }
                      label={`FPC${i} (${(
                        (clustering?.explainedVarianceRatio[i] ?? 0) * 100
                      ).toFixed(2)}%)`}
                    />
                    <Box
                      component="div"
                      sx={{
                        ml: 1,
                        width: "15px",
                        height: "15px",
                        backgroundColor:
                          fpcColor && fpcColor[i] != null
                            ? fpcColor[i]
                            : "black",
                      }}
                    />
                  </Stack>
                );
              })}
            </Stack>
          </Stack>
        </Menu>
      </Box>
      <Stack
        sx={{
          filter: false ? "blur(2px)" : "none",
        }}
      >
        {Object.entries(failurePlotData ?? {}).map(
          ([featureName, featurePlotData]) => {
            return (
              <Stack sx={{ p: 1 }}>
                <Typography>{`${featureName}`}</Typography>
                <Plot
                  key={featureName}
                  data={featurePlotData}
                  feature={featureName}
                  isBoundaryDiffMode={isBoundaryDiffMode}
                />
              </Stack>
            );
          },
        )}
      </Stack>
      {false ? (
        <Stack
          justifyContent="center"
          alignItems="center"
          spacing={2}
          sx={{
            position: "absolute",
            zIndex: 100,
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            // backgroundColor: "divider",
          }}
        >
          <CircularProgress />
          <Typography color="primary.main" fontWeight={700}>
            Loading...
          </Typography>
        </Stack>
      ) : null}
    </Stack>
  );
}
