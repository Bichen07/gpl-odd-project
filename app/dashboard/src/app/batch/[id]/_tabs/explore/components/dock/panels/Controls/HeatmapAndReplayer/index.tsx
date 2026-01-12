import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
} from "@dnd-kit/core";
import {
  arrayMove,
  SortableContext,
  horizontalListSortingStrategy,
} from "@dnd-kit/sortable";
import { SortableItem } from "./SortableItem";
import {
  Box,
  Menu,
  Stack,
  ToggleButton,
  Typography,
  MenuItem,
  Select,
  OutlinedInput,
  SelectChangeEvent,
  Chip,
  Checkbox,
  useTheme,
  Theme,
  Button,
  FormControl,
  InputLabel,
} from "@mui/material";
import { MouseEvent } from "react";
import ColorLensIcon from "@mui/icons-material/ColorLens";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import {
  batchSlice,
  ViewerMode,
  viewerModes,
} from "../../../../../redux/slices/batch";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import Input from "@/app/_shared/utils/Input";

type Props = {
  anchorEl: HTMLElement | null;
  menuOpened: string | null;
  handleMenuClose: () => void;
  handleMenuAnchorClick: (event: MouseEvent<HTMLElement>) => void;
  setMenuOpened: (v: string) => void;
};
export default function HeatmapAndReplayer({
  anchorEl,
  menuOpened,
  handleMenuClose,
  handleMenuAnchorClick,
  setMenuOpened,
}: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor),
  );

  const viewerMode = useAppSelector((state) => state.batch.viewerMode);
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const attributes = useAppSelector((state) => state.batch.attributes);
  const showFullTimeline = useAppSelector(
    (state) => state.batch.showFullHeatmap,
  );
  const filteredAttributes = useAppSelector(
    (state) => state.batch.filteredAttributes,
  );
  const timeOrS = useAppSelector((state) => state.batch.timeOrS);
  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfo,
  );
  const heatmapGlobalScaleX = useAppSelector(
    (state) => state.batch.heatmapGlobalScaleX,
  );
  const heatmapGlobalScaleY = useAppSelector(
    (state) => state.batch.heatmapGlobalScaleY,
  );
  const heatmapLocalScaleY = useAppSelector(
    (state) => state.batch.heatmapLocalScaleY,
  );

  const handleDragEnd = (event: any) => {
    const { active, over } = event;
    if (active.id !== over.id) {
      const oldIndex = filteredAttributes.indexOf(active.id);
      const newIndex = filteredAttributes.indexOf(over.id);
      const newFilteredAttributes = arrayMove(
        filteredAttributes,
        oldIndex,
        newIndex,
      );
      dispatch(batchSlice.actions.setFilteredAttributes(newFilteredAttributes));
    }
  };

  return (
    <Stack rowGap={1}>
      <Menu
        id="color-menu"
        anchorEl={anchorEl}
        open={menuOpened === "color"}
        onClose={handleMenuClose}
        slotProps={{
          paper: {
            style: {
              width: "20ch",
            },
          },
        }}
      >
        {viewerModes.map((option) => {
          return (
            <MenuItem
              key={option}
              selected={option === viewerMode}
              onClick={(event) => {
                handleMenuClose();
                dispatch(batchSlice.actions.setViewerMode(option));
              }}
            >
              {option}
            </MenuItem>
          );
        })}
      </Menu>
      <Stack>
        <Typography fontWeight="bold">Time Or S</Typography>
        <Select
          sx={{ p: 0 }}
          label="Time Or S"
          labelId="timeors-label"
          id="timeors-selection"
          size="small"
          value={timeOrS}
          onChange={(event) => {
            dispatch(
              batchSlice.actions.setTimeOrS(event.target.value as "time" | "s"),
            );
          }}
        >
          {["time", "s"].map((v, index) => {
            return (
              <MenuItem key={v} value={v}>
                {v}
              </MenuItem>
            );
          })}
        </Select>
      </Stack>
      <Stack>
        <Typography fontWeight="bold">Heatmap Showing Attributes</Typography>
        <Select<string[]>
          sx={{ width: "auto" }}
          size="small"
          label="Attributes"
          labelId="attributes-chip-label"
          multiple
          value={filteredAttributes}
          onChange={(event: SelectChangeEvent<typeof attributes>) => {
            const {
              target: { value },
            } = event;
            dispatch(
              batchSlice.actions.setFilteredAttributes(
                // On autofill we get a stringified value.
                typeof value === "string" ? value.split(",") : value,
              ),
            );
          }}
          input={<OutlinedInput id="select-multiple-chip" label="Chip" />}
          renderValue={(selected) => (
            <Box
              component="div"
              sx={{ display: "flex", flexWrap: "wrap", gap: 0.5 }}
            >
              {selected.map((value) => (
                <Chip key={value} label={value} />
              ))}
            </Box>
          )}
          MenuProps={{
            PaperProps: {
              style: {
                maxHeight: 48 * 4.5 + 8,
                width: 250,
              },
            },
          }}
        >
          {attributes.map((name) => (
            <MenuItem
              key={name}
              value={name}
              style={getStyles(name, attributes, theme)}
            >
              {name}
            </MenuItem>
          ))}
        </Select>
      </Stack>
      <Stack
        sx={{
          overflowY: "hidden",
        }}
      >
        <Typography fontWeight="bold">Heatmap Attributes Sorting</Typography>
        <DndContext
          sensors={sensors}
          collisionDetection={closestCenter}
          onDragEnd={handleDragEnd}
        >
          <SortableContext
            items={filteredAttributes}
            strategy={horizontalListSortingStrategy}
          >
            <Stack direction="row" columnGap="10px">
              {filteredAttributes.map((item) => (
                <SortableItem key={item} id={item} />
              ))}
            </Stack>
          </SortableContext>
        </DndContext>
      </Stack>
      <Stack>
        <Stack>
          <Typography fontWeight="bold">Global Heatmap Scale</Typography>
          <Typography>(Hold Shift & Scroll)</Typography>
        </Stack>
        <Stack flexDirection="row" columnGap={1} sx={{ mt: 1 }}>
          <Stack
            component="div"
            justifyContent="center"
            alignItems="center"
            sx={{
              background: "white",
              padding: "0 10px",
              fontSize: "18px",
              border: "solid 1px black",
              overscrollBehavior: "contain",
            }}
            onWheelCapture={(event) => {
              // event.preventDefault(); // Prevent browser default scroll behavior
              // event.stopPropagation(); // Stop the event from bubbling up to parent elements
              if (!Input.isKeyPressed("ShiftLeft")) {
                return;
              }
              const baseSensitivity = 0.0005; // tune this so zoom isn’t too fast
              const delta =
                baseSensitivity * event.deltaY * heatmapGlobalScaleX;
              const next = heatmapGlobalScaleX + delta;
              dispatch(
                batchSlice.actions.setHeatmapGlobalScaleX(
                  Math.max(next, 0.0001),
                ),
              );
            }}
          >
            <Typography fontSize={18}>
              X: {heatmapGlobalScaleX.toFixed(2)}
            </Typography>
          </Stack>
          <Stack
            component="div"
            justifyContent="center"
            alignItems="center"
            sx={{
              background: "white",
              padding: "0 10px",
              fontSize: "18px",
              border: "solid 1px black",
              overscrollBehavior: "contain",
            }}
            onWheelCapture={(event) => {
              // event.preventDefault(); // Prevent browser default scroll behavior
              // event.stopPropagation(); // Stop the event from bubbling up to parent elements
              if (!Input.isKeyPressed("ShiftLeft")) {
                return;
              }
              const baseSensitivity = 0.0005; // tune this so zoom isn’t too fast
              const delta =
                baseSensitivity * event.deltaY * heatmapGlobalScaleY;
              const next = heatmapGlobalScaleY + delta;
              dispatch(
                batchSlice.actions.setHeatmapGlobalScaleY(
                  Math.max(next, 0.0001),
                ),
              );
            }}
          >
            <Typography fontSize={18}>
              Y: {heatmapGlobalScaleY.toFixed(2)}
            </Typography>
          </Stack>
        </Stack>
      </Stack>
      <Stack>
        <Stack flexDirection="row" columnGap={1} alignItems="center">
          <Stack>
            <Typography fontWeight="bold">
              Individual Heatmap Y Scales
            </Typography>
            <Typography>(Hold Shift & Scroll)</Typography>
          </Stack>
          <Button
            onClick={() => {
              const newScaleY = { ...heatmapLocalScaleY };
              for (const key of Object.keys(newScaleY)) {
                newScaleY[key] = 1;
              }
              dispatch(batchSlice.actions.setHeatmapLocalScaleY(newScaleY));
            }}
          >
            Reset
          </Button>
        </Stack>
        <Stack flexDirection="row" columnGap={1} flexWrap="wrap">
          {Object.entries(heatmapLocalScaleY).map(([groupName, scales]) => {
            return (
              <Stack
                key={groupName}
                component="div"
                justifyContent="center"
                alignItems="center"
                sx={{
                  background: "white",
                  padding: "0 10px",
                  fontSize: "18px",
                  border: "solid 1px black",
                  overscrollBehavior: "contain",
                }}
                onWheelCapture={(event) => {
                  // event.preventDefault(); // Prevent browser default scroll behavior
                  // event.stopPropagation(); // Stop the event from bubbling up to parent elements
                  if (!Input.isKeyPressed("ShiftLeft")) {
                    return;
                  }
                  const baseSensitivity = 0.0005; // tune this so zoom isn’t too fast
                  const newScaleY = { ...heatmapLocalScaleY };
                  const delta =
                    baseSensitivity * event.deltaY * newScaleY[groupName];
                  const next = newScaleY[groupName] + delta;
                  // clamp so you never go negative (or below some minScale)
                  const value = Math.max(next, 0.0001);
                  newScaleY[groupName] = value;
                  dispatch(batchSlice.actions.setHeatmapLocalScaleY(newScaleY));
                }}
              >
                <Stack columnGap={1} direction="row" alignItems="center">
                  <Box
                    component="div"
                    sx={{
                      width: "18px",
                      height: "18px",
                      background:
                        clusterInfo && groupName in clusterInfo
                          ? clusterInfo[groupName].color
                          : "black",
                    }}
                  />
                  <Typography fontSize={18} noWrap>
                    {groupName}: {heatmapLocalScaleY[groupName].toFixed(2)}
                  </Typography>
                </Stack>
              </Stack>
            );
          })}
        </Stack>
      </Stack>
    </Stack>
  );
}

function getStyles(name: string, attributes: readonly string[], theme: Theme) {
  return {
    fontWeight: attributes.includes(name)
      ? theme.typography.fontWeightMedium
      : theme.typography.fontWeightRegular,
  };
}
