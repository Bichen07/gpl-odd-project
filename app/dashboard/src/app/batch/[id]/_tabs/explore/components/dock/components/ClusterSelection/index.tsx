"use client";

import {
  Checkbox,
  FormControlLabel,
  FormGroup,
  Menu,
  Stack,
  ToggleButton,
  Typography,
} from "@mui/material";
import WorkspacesIcon from "@mui/icons-material/Workspaces";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { useEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import { batchSlice } from "../../../../redux/slices/batch";

type Props = {
  opened: boolean;
  setOpened: () => void;
  handleClose: () => void;
};
export default function ClusterSelection({
  opened,
  setOpened,
  handleClose,
}: Props) {
  const dispatch = useAppDispatch();

  const [checked, setChecked] = useState<Set<string>>(new Set());

  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis,
  );
  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.batch.selectedClusteringResult,
  );
  const freeformTrialIds = useAppSelector(
    (state) => state.batch.freeformTrialIds,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds,
  );
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  useEffect(() => {
    const newChecked = new Set<string>();
    for (const label of Object.keys(clusterInfo ?? {})) {
      newChecked.add(label);
    }
    setChecked(newChecked);
  }, [clusterInfo]);

  // useEffect(() => {
  //   if (clusteringResult == null || trajectoryAnalysis == null) {
  //     return;
  //   }
  //   const trialIds = Object.keys(trajectoryAnalysis?.trials ?? {});
  //   let newFilteredTrialIds = [...trialIds];
  //   newFilteredTrialIds = newFilteredTrialIds.filter((trialId) => {
  //     if (!(trialId in clusteringResult.data)) {
  //       return false;
  //     }
  //     if (!(trialId in freeformTrialIds) && freeformTrialIds.length > 0) {
  //       return false;
  //     }
  //     const label = clusteringResult?.data[trialId].label ?? "";
  //     return checked.has(label);
  //   });
  //   dispatch(batchSlice.actions.setFilteredTrialIds(newFilteredTrialIds));
  // }, [checked, trajectoryAnalysis, clusteringResult]);

  return (
    <>
      <Menu
        id="cluster-selection-menu"
        anchorEl={anchorEl}
        open={opened}
        onClose={handleClose}
      >
        <Stack sx={{ p: 2, minWidth: "200px" }}>
          <Typography sx={{ fontSize: "14px", mb: 2 }}>
            Cluster Selection
          </Typography>
          <FormGroup>
            {Object.keys(clusterInfo ?? {}).map((clusterLabel) => {
              return (
                <FormControlLabel
                  control={
                    <Checkbox
                      checked={checked.has(clusterLabel)}
                      onChange={(event) => {
                        console.log(clusterLabel);
                        if (event.target.checked) {
                          setChecked((prev) => {
                            const newChecked = new Set(prev);
                            newChecked.add(clusterLabel);
                            return newChecked;
                          });
                        } else {
                          setChecked((prev) => {
                            const newChecked = new Set(prev);
                            newChecked.delete(clusterLabel);
                            return newChecked;
                          });
                        }
                      }}
                    />
                  }
                  label={`Cluster ${clusterLabel}`}
                />
              );
            })}
          </FormGroup>
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
        <WorkspacesIcon />
        <ArrowDropDownIcon />
      </ToggleButton>
    </>
  );
}
