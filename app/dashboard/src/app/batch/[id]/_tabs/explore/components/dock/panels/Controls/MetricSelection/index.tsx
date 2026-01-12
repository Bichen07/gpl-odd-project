"use client";

import {
  FormControl,
  InputLabel,
  Menu,
  MenuItem,
  Select,
  Stack,
  ToggleButton,
  Typography,
} from "@mui/material";
import SportsScoreIcon from "@mui/icons-material/SportsScore";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import { batchSlice } from "../../../../../redux/slices/batch";

type Props = {
  opened: boolean;
  setOpened: () => void;
  handleClose: () => void;
};
export default function MetricSelection({
  opened,
  setOpened,
  handleClose,
}: Props) {
  const dispatch = useAppDispatch();

  const metrics = useAppSelector((state) => state.batch.metrics);
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  return (
    <>
      <Menu
        id="metric-menu"
        anchorEl={anchorEl}
        open={opened}
        onClose={handleClose}
      >
        <Stack sx={{ p: 2, minWidth: "200px" }}>
          <Typography sx={{ fontSize: "14px", mb: 2 }}>
            Metric Selection
          </Typography>
          <FormControl sx={{ m: 0, p: 0 }}>
            <InputLabel size="small" id="criticality-metric-selection-label">
              Criticality Metric
            </InputLabel>
            <Select
              sx={{ p: 0 }}
              label="Criticality Metric"
              labelId="criticality-metric-selection-label"
              id="criticality-metric-selection"
              size="small"
              value={selectedMetric?.kpi.name ?? ""}
              onChange={(event) => {
                dispatch(
                  batchSlice.actions.setSelectedMetric(
                    metrics ? metrics[event.target.value] : null
                  )
                );
              }}
            >
              {Object.values(metrics ?? {}).map((doc, index) => {
                return (
                  <MenuItem
                    key={doc.kpi.name ?? index}
                    value={doc.kpi.name ?? ""}
                  >
                    {doc.kpi.name ?? "unknown"}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
          <FormControl sx={{ m: 0, mt: 2 }}>
            <InputLabel size="small" id="safety-metric-selection-label">
              Safety Boundary Metric
            </InputLabel>
            <Select
              label="Safety Boundary Metric"
              labelId="safety-metric-selection-label"
              id="safety-metric-selection"
              size="small"
              value={selectedBoundaryMetric?.kpi.name ?? ""}
              onChange={(event) => {
                if (metrics == null) {
                  return;
                }
                console.log(metrics[event.target.value]);
                dispatch(
                  batchSlice.actions.setSelectedSafetyBoundaryMetric(
                    metrics ? metrics[event.target.value] : null
                  )
                );
              }}
            >
              {Object.values(metrics ?? {}).map((doc, index) => {
                return (
                  <MenuItem
                    key={doc.kpi.name ?? index}
                    value={doc.kpi.name ?? ""}
                  >
                    {doc.kpi.name ?? "unknown"}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
        </Stack>
      </Menu>
      <ToggleButton
        value="metricSelection"
        size="small"
        onClick={(event) => {
          setAnchorEl(event.currentTarget);
          setOpened();
        }}
      >
        <SportsScoreIcon />
        <ArrowDropDownIcon />
      </ToggleButton>
    </>
  );
}
