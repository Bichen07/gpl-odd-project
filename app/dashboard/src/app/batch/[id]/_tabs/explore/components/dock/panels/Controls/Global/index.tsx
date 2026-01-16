import {
  FormControl,
  FormControlLabel,
  FormLabel,
  Radio,
  RadioGroup,
  Stack,
  Typography,
  Menu,
  MenuItem,
  ToggleButton,
  InputLabel,
  Select,
} from "@mui/material";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import { batchSlice, viewerModes } from "../../../../../redux/slices/batch";
import { useState } from "react";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { MouseEvent } from "react";
import { toTitleSpaceCase } from "@/app/_shared/utils";

export default function Global() {
  const dispatch = useAppDispatch();
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis
  );
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const viewerMode = useAppSelector((state) => state.batch.viewerMode);
  const metrics = useAppSelector((state) => state.batch.metrics);
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric
  );

  const [menuOpened, setMenuOpened] = useState<string | null>(null);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  const handleMenuAnchorClick = (event: MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };

  const getDurationModeRenderingName = (name: string) => {
    if (name.includes("full")) {
      return "Full";
    } else {
      return toTitleSpaceCase("5 Seconds Nearest to" + name);
    }
  };
  return (
    <Stack rowGap={1}>
      {/* <Stack> */}
      {/*   <FormControl> */}
      {/*     <Typography fontWeight="bold">Duration Mode</Typography> */}
      {/*     <RadioGroup */}
      {/*       row */}
      {/*       aria-labelledby="demo-row-radio-buttons-group-label" */}
      {/*       name="row-radio-buttons-group" */}
      {/*       value={durationMode} */}
      {/*       onChange={(_event, value) => { */}
      {/*         dispatch(batchSlice.actions.setDurationMode(value)); */}
      {/*       }} */}
      {/*     > */}
      {/*       {Object.keys(trajectoryAnalysis?.mfpca ?? {}).map((key) => { */}
      {/*         return ( */}
      {/*           <FormControlLabel */}
      {/*             value={key} */}
      {/*             control={<Radio />} */}
      {/*             label={getDurationModeRenderingName(key)} */}
      {/*           /> */}
      {/*         ); */}
      {/*       })} */}
      {/*     </RadioGroup> */}
      {/*   </FormControl> */}
      {/* </Stack> */}
      <Stack sx={{ minWidth: "200px" }} rowGap={1}>
        {/* <Typography fontWeight="bold">Metric Selection</Typography> */}
        <FormControl sx={{ m: 0, p: 0 }}>
          <Typography>Criticality Metric</Typography>
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
        <FormControl sx={{ m: 0 }}>
          <Typography>Pass/Fail Metric</Typography>
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
    </Stack>
  );
}
