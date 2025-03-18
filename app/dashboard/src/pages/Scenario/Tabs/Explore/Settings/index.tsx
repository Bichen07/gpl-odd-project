import { MenuItem, Select, Stack, Switch } from "@mui/material";
import Labeler from "src/components/Labeler";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { batchSlice } from "src/redux/slices/batch";

export default function Settings() {
  const dispatch = useAppDispatch();

  const viewBoundary = useAppSelector((state) => state.batch.viewBoundary);
  const criticalityMetrics = useAppSelector(
    (state) => state.batch.criticalityMetrics,
  );
  const selectedCritialityMetric = useAppSelector(
    (state) => state.batch.selectedCriticalityMetric,
  );

  return (
    <Stack
      direction="row"
      flexWrap="wrap"
      rowGap={2}
      columnGap={2}
      sx={{ p: 2 }}
    >
      <Labeler label="criticality metric">
        <Select
          value={selectedCritialityMetric?.id ?? ""}
          renderValue={(id: string) => {
            if (!criticalityMetrics) {
              return;
            }
            return criticalityMetrics[id].name;
          }}
          size="small"
          onChange={(event) => {
            if (!criticalityMetrics) {
              return;
            }
            dispatch(
              batchSlice.actions.setSelectedCriticalityMetric(
                criticalityMetrics[event.target.value],
              ),
            );
          }}
        >
          {Object.values(criticalityMetrics ?? {}).map((item, index) => {
            return (
              <MenuItem key={index} value={item.id}>
                {item.name}
              </MenuItem>
            );
          })}
        </Select>
      </Labeler>
      {/* <Labeler label="boundary"> */}
      {/*   <Switch */}
      {/*     value={viewBoundary} */}
      {/*     onChange={(_event, checked) => { */}
      {/*       dispatch(batchSlice.actions.setViewBoundary(checked)); */}
      {/*     }} */}
      {/*   /> */}
      {/* </Labeler> */}
    </Stack>
  );
}
