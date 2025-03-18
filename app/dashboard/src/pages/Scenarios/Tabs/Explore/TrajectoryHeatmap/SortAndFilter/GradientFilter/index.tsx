import { Checkbox, FormControlLabel, Stack, TextField } from "@mui/material";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";

export function GradientFilter() {
  const dispatch = useAppDispatch();
  const fpcEnabled = useAppSelector(
    (state) => state.session.fpcGradientFilterEnabled,
  );
  const metricEnabled = useAppSelector(
    (state) => state.session.metricGradientFilterEnabled,
  );
  const fpcThreshold = useAppSelector(
    (state) => state.session.fpcGradientFilterThreshold,
  );
  const metricThreshold = useAppSelector(
    (state) => state.session.metricGradientFilterThreshold,
  );

  return (
    <Stack>
      <Stack direction="row" sx={{ padding: "5px 0" }} columnGap={1}>
        <FormControlLabel
          sx={{ mr: 0 }}
          control={
            <Checkbox
              checked={fpcEnabled}
              onChange={(_event, value) => {
                dispatch(
                  sessionSlice.actions.setFpcGradientFilterEnabled(value),
                );
              }}
            />
          }
          label="FPC Gradient"
        />
        <TextField
          disabled={!fpcEnabled}
          label="threshold"
          type="number"
          size="small"
          sx={{ p: 0, m: 0, maxWidth: "120px" }}
          value={fpcThreshold}
          onChange={(event) => {
            dispatch(
              sessionSlice.actions.setFpcGradientFilterThreshold(
                Number(event.target.value),
              ),
            );
          }}
        />
      </Stack>
      <Stack direction="row" sx={{ padding: "5px 0" }} columnGap={1}>
        <FormControlLabel
          sx={{ mr: 0 }}
          control={
            <Checkbox
              checked={metricEnabled}
              onChange={(_event, value) => {
                dispatch(
                  sessionSlice.actions.setMetricGradientFilterEnabled(value),
                );
              }}
            />
          }
          label="Metric Gradient"
        />
        <TextField
          disabled={!metricEnabled}
          label="threshold"
          type="number"
          size="small"
          sx={{ p: 0, m: 0, maxWidth: "120px" }}
          value={metricThreshold}
          onChange={(event) => {
            dispatch(
              sessionSlice.actions.setMetricGradientFilterThreshold(
                Number(event.target.value),
              ),
            );
          }}
        />
      </Stack>
    </Stack>
  );
}
