import chroma from "chroma-js";
import {
  Stack,
  Typography,
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  IconButton,
  Menu,
  ToggleButtonGroup,
  ToggleButton,
} from "@mui/material";
import { useTheme } from "@mui/material/styles";
import SettingsIcon from "@mui/icons-material/Settings";
import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import { ExpandMore } from "@mui/icons-material";
import { ParallelCoordinate } from "./ParallelCoordinate";
import { ColorMode } from "../EmbeddingSpace/Scatter";

export function ScenarioCategoryClustering() {
  const theme = useTheme();
  const batches = useAppSelector((state) => state.session.batchMappings);
  const trials = useAppSelector((state) => state.session.trialMappings);
  const batchTrialMappings = useAppSelector(
    (state) => state.session.batchTrialMappings,
  );
  const hoveredTrialId = useAppSelector(
    (state) => state.session.hoveredTrialId,
  );
  const clusterResult = useAppSelector(
    (state) => state.session.selectedClusterResult,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );
  const selectedBoundarySafeCluster = useAppSelector(
    (state) => state.session.selectedBoundarySafeCluster,
  );
  const selectedBoundarySafeClusterTrialIds = useAppSelector(
    (state) => state.session.selectedBoundarySafeClusterTrialIds,
  );
  const passedFailedPair = useAppSelector(
    (state) => state.session.passedFailedPair,
  );
  const embeddingPoints = useAppSelector((state) => state.session.points);
  const trialClusterMappings = useAppSelector(
    (state) => state.session.trialClusterMappings,
  );

  const [colorMode, setColorMode] = useState<ColorMode>("clustering");
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const open = Boolean(anchorEl);
  const handleSettingClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleSettingClose = () => {
    setAnchorEl(null);
  };

  const [expanded, setExpanded] = useState(new Set<string>());
  const [hoveredBatchId, setHoveredBatchId] = useState("");
  const [mouseInSection, setMouseInSection] = useState(false);

  const batchClusterCounts = useMemo(() => {
    const result: {
      [batchId: string]: {
        passed: { [clusterLabel: string]: Set<string> };
        failed: { [clusterLabel: string]: Set<string> };
      };
    } = {};
    clusterResult?.data?.forEach((item) => {
      for (const [batchId, trialSet] of Object.entries(batchTrialMappings)) {
        if (trialSet.has(item.trialId) && item.trialId in embeddingPoints) {
          if (batchId && !(batchId in result)) {
            result[batchId] = {
              passed: {},
              failed: {},
            };
          }
          const passed = item.trialId in passedFailedPair;
          if (!passed) {
            if (!result[batchId].failed[item.label]) {
              result[batchId].failed[item.label] = new Set();
            }
            result[batchId].failed[item.label].add(item.trialId);
          } else {
            if (
              item.label in selectedBoundarySafeClusterTrialIds &&
              selectedBoundarySafeClusterTrialIds[item.label].has(item.trialId)
            ) {
              if (!result[batchId].passed[item.label]) {
                result[batchId].passed[item.label] = new Set();
              }
              result[batchId].passed[item.label].add(item.trialId);
            }
          }
          break;
        }
      }
    });
    return result;
  }, [
    batches,
    clusterResult,
    batchTrialMappings,
    embeddingPoints,
    passedFailedPair,
    selectedBoundarySafeClusterTrialIds,
  ]);

  const data = useMemo(() => {
    if (!clusterResult || !trials || !batches) {
      return {};
    }
    const result: {
      [batchId: string]: {
        bounds: { [key: string]: { min: number; max: number } };
        data: {
          [trialId: string]: {
            trialId: string;
            group: string;
            color: string;
            originalColor: string;
            parameters: { [parameterName: string]: number };
          };
        };
      };
    } = {};

    for (const batchId of Object.keys(batchClusterCounts)) {
      result[batchId] = { bounds: {}, data: {} };
      for (const item of clusterResult.data) {
        if (!batchTrialMappings[batchId].has(item.trialId)) {
          continue;
        }

        const clusterCounts =
          item.trialId in passedFailedPair
            ? batchClusterCounts[batchId].passed
            : batchClusterCounts[batchId].failed;

        let foundCountSet = false;
        for (const countSet of Object.values(clusterCounts)) {
          if (countSet.has(item.trialId)) {
            foundCountSet = true;
            break;
          }
        }
        if (!foundCountSet) {
          continue;
        }

        // if (!selectedBoundarySafeCluster && item.trialId in passedFailedPair) {
        //   continue;
        // }

        const trial = trials[item.trialId];
        const batch = batches[`${trial?.batch}`];

        const parameters: { [parameterName: string]: number } = {};
        for (const parameter of trial.parameters) {
          const parameterName =
            batch.scenario.parameters.find(
              (p) => p.id === parameter.parameterId,
            )?.name ?? "";
          parameters[parameterName] = parameter.value ?? NaN;

          if (batch.id && !(batch.id in result[batch.id])) {
            const parameterConfig = batch.scenario.parameters.find(
              (p) => p.id === parameter.parameterId,
            );
            if (parameterConfig && parameterConfig.min && parameterConfig.max) {
              result[batch.id ?? ""].bounds[parameterName] = {
                min: parameterConfig.min,
                max: parameterConfig.max,
              };
            }
          }
          // row["group"] = item.label;
          // row["trialId"] = item.trialId;
          // row["color"] = chroma(
          //   embeddingPoints[item.trialId].originalColor,
          // ).hex();
          // 66ba7923a806981f88ac3dbb
          const embeddingPoint = embeddingPoints[item.trialId];
          result[batchId].data[item.trialId] = {
            trialId: item.trialId,
            group: item.label,
            color: embeddingPoint.disable
              ? chroma(theme.palette.text.primary).alpha(0.005).hex()
              : chroma(embeddingPoint.originalColor).alpha(0.2).hex(),
            originalColor: embeddingPoint.originalColor,
            // color: chroma(clusterResult.clusterMemberData[item.label].color)
            //   .alpha(0.1)
            //   .hex(),
            parameters,
          };
        }
      }
    }
    return result;
  }, [
    clusterResult,
    batchTrialMappings,
    batchClusterCounts,
    batches,
    trials,
    embeddingPoints,
    selectedCluster,
    passedFailedPair,
    trialClusterMappings,
  ]);

  useEffect(() => {
    if (hoveredTrialId && hoveredTrialId in trials) {
      setHoveredBatchId(`${trials[hoveredTrialId].batch}`);
    }
  }, [hoveredTrialId, trials]);

  useEffect(() => {
    if (hoveredBatchId !== "") {
      setExpanded(new Set<string>([hoveredBatchId]));
    }
  }, [hoveredBatchId]);

  return (
    <Stack
      component="div"
      onMouseEnter={() => setMouseInSection(true)}
      onMouseLeave={() => setMouseInSection(false)}
    >
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
      {Object.keys(batchClusterCounts)
        .sort(
          (a, b) =>
            // Number(hoveredBatchId === b) - Number(hoveredBatchId === a) ||
            Object.keys(batchClusterCounts[b].failed).length -
            Object.keys(batchClusterCounts[a].failed).length,
        )
        .map((batchId) => (
          <Accordion
            disableGutters
            elevation={0}
            sx={{ backgroundColor: "background.default", p: 0 }}
            expanded={expanded.has(batchId)}
            onChange={() =>
              setExpanded((prev) => {
                const newSet = new Set(prev);
                const expandedId = batchId;
                if (newSet.has(expandedId)) {
                  newSet.delete(expandedId);
                } else {
                  newSet.add(expandedId);
                }
                return newSet;
              })
            }
          >
            <AccordionSummary sx={{ pl: 2 }} expandIcon={<ExpandMore />}>
              <Stack direction="row">
                <Typography>{batches[batchId].scenario.name}</Typography>
                <Typography sx={{ ml: 1 }}>
                  {`(${
                    Object.keys(batchClusterCounts[batchId].failed).length
                  })`}
                </Typography>
              </Stack>
            </AccordionSummary>
            <AccordionDetails
              sx={{
                margin: 0,
                display: "flex",
                rowGap: 1,
                columnGap: 1,
                flexWrap: "wrap",
                padding: 0,
                width: "100%",
              }}
            >
              {expanded.has(batchId) ? (
                <ParallelCoordinate
                  batchId={batchId}
                  data={data[batchId]}
                  variables={Object.keys(data[batchId].bounds)}
                  clusterCounts={batchClusterCounts[batchId]}
                  clusterResult={clusterResult}
                  colorMode={colorMode}
                />
              ) : null}
            </AccordionDetails>
          </Accordion>
        ))}
    </Stack>
  );
}
