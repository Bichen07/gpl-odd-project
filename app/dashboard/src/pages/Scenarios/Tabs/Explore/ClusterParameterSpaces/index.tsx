import {
  Box,
  Stack,
  Typography,
  IconButton,
  Menu,
  ToggleButtonGroup,
  ToggleButton,
} from "@mui/material";
import SettingsIcon from "@mui/icons-material/Settings";
import { useEffect, useMemo, useState } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import ParallelCoordinates from "./ParallelCoordinates";
import { ColorMode } from "../EmbeddingSpace/Scatter";
import { Legend } from "./ParallelCoordinates/Plot/Legend";
// import {
//   getSelectedClusterInfo,
//   getSelectedClusteringResult,
// } from "src/redux/slices/session";

export default function ClusterParameterSpaces() {
  const clusteringResult = useAppSelector(getSelectedClusteringResult);
  const clusterInfo = useAppSelector(getSelectedClusterInfo);
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );

  const [colorMode, setColorMode] = useState<ColorMode>("criticalityMetric");
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const open = Boolean(anchorEl);
  const handleSettingClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleSettingClose = () => {
    setAnchorEl(null);
  };

  const [clusterLabel, setClusterLabel] = useState<string | undefined>();

  useEffect(() => {
    if (!hoveredTrialId) {
      return;
    }
    if (!clusteringResult) {
      setClusterLabel(undefined);
      return;
    }
    setClusterLabel(clusteringResult.data[hoveredTrialId].label);
  }, [clusteringResult, hoveredTrialId]);

  const scenarioCounts = useMemo(() => {
    if (!clusterLabel || !clusteringResult) {
      return {};
    }
    const result: { [clusterLabel: string]: Set<string> } = {};
    for (const item of Object.values(clusteringResult.data)) {
      if (item.label !== clusterLabel) {
        continue;
      }
      let found = clusteringResponse?.trials[item.trialId].batchId;
      if (found) {
        if (!(found in result)) {
          result[found] = new Set<string>();
        }
        result[found].add(item.trialId);
      }
    }
    return result;
  }, [clusteringResult, clusterLabel]);

  if (!clusteringResult) {
    return (
      <Stack>
        <Typography>No Data To Display</Typography>
      </Stack>
    );
  }

  return (
    <Box component="div" sx={{ p: 2 }}>
      <Box component="div" sx={{ right: 10, top: 10, display: "flex" }}>
        <IconButton onClick={handleSettingClick} sx={{ marginLeft: "auto" }}>
          <SettingsIcon />
        </IconButton>
        <Menu
          elevation={1}
          anchorEl={anchorEl}
          open={open}
          onClose={handleSettingClose}
          MenuListProps={{
            "aria-labelledby": "basic-button",
          }}
          sx={{ ".MuiList-root": { p: 0, m: 0 } }}
        >
          <ToggleButtonGroup
            color="primary"
            exclusive
            value={colorMode}
            onChange={(
              event: React.MouseEvent<HTMLElement>,
              newColorMode: typeof colorMode,
            ) => {
              setColorMode(newColorMode);
            }}
          >
            <ToggleButton value="clustering">Clustering</ToggleButton>
            <ToggleButton value="criticalityMetric">
              Criticality Metric
            </ToggleButton>
          </ToggleButtonGroup>
        </Menu>
      </Box>
      <Stack direction="row" alignItems="center">
        <Box
          component="div"
          sx={{
            mr: 1,
            width: "20px",
            height: "20px",
            backgroundColor:
              (clusterInfo && clusterInfo[clusterLabel ?? ""]?.color) ??
              "black",
          }}
        />
        <Typography variant="h5">{`Cluster ${clusterLabel} (${Object.values(
          scenarioCounts,
        ).reduce((acc, item) => (acc += item.size), 0)})`}</Typography>
      </Stack>
      <Legend colorMode={colorMode} />
      <Stack>
        <ParallelCoordinates
          clusterLabel={clusterLabel}
          colorMode={colorMode}
        />
      </Stack>
    </Box>
  );
}
