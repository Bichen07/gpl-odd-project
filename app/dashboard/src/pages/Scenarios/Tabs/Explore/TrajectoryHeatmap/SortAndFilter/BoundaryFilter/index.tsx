import { LoadingButton } from "@mui/lab";
import {
  Button,
  Checkbox,
  FormControlLabel,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { useEffect, useState } from "react";
import { useKpis } from "src/api/services/KeyPerformanceIndicators";
import KpiSelector from "src/components/KpiSelector";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";

export function BoundaryFilter() {
  const dispatch = useAppDispatch();
  const selectedKpi = useAppSelector((state) => state.session.boundaryKpi);
  const enabled = useAppSelector(
    (state) => state.session.boundaryFilteringEnabled,
  );
  const KNeighbors = useAppSelector(
    (state) => state.session.boundaryKNeighbors,
  );
  const kpiResponse = useKpis();

  useEffect(() => {
    if (kpiResponse.data == null) {
      return;
    }
    const collision = kpiResponse.data.docs?.find(
      (doc) => doc?.name === "collision",
    );
    if (collision) {
      dispatch(sessionSlice.actions.setBoundaryKpi(collision));
    }
  }, [kpiResponse.data]);

  return (
    <Stack>
      <Stack direction="row" sx={{ padding: "5px 0" }} columnGap={1}>
        <FormControlLabel
          sx={{ mr: 0 }}
          control={
            <Checkbox
              checked={enabled}
              onChange={(_event, value) => {
                dispatch(
                  sessionSlice.actions.setBoundaryFilteringEnabled(value),
                );
              }}
            />
          }
          label="Boundary Only"
        />
        <KpiSelector
          disabled={!enabled}
          selectedKpi={selectedKpi}
          setSelectedKpi={(value) => {
            dispatch(sessionSlice.actions.setBoundaryKpi(value));
          }}
        />
        <TextField
          disabled={!enabled}
          label="KNeighbors"
          type="number"
          size="small"
          sx={{ p: 0, m: 0, maxWidth: "120px" }}
          value={KNeighbors}
          onChange={(event) => {
            dispatch(
              sessionSlice.actions.setBoundaryKNeighbors(
                Number(event.target.value),
              ),
            );
          }}
        />
      </Stack>
    </Stack>
  );
}
