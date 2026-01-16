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
  Button,
  Checkbox,
  FormControlLabel,
  Stack,
  Typography,
} from "@mui/material";
import { Theme, useTheme } from "@mui/material/styles";
import Box from "@mui/material/Box";
import OutlinedInput from "@mui/material/OutlinedInput";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select, { SelectChangeEvent } from "@mui/material/Select";
import Chip from "@mui/material/Chip";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import { batchSlice } from "../../../../../redux/slices/batch";

const ITEM_HEIGHT = 48;
const ITEM_PADDING_TOP = 8;
const MenuProps = {
  PaperProps: {
    style: {
      maxHeight: ITEM_HEIGHT * 4.5 + ITEM_PADDING_TOP,
      width: 250,
    },
  },
};

function getStyles(name: string, attributes: readonly string[], theme: Theme) {
  return {
    fontWeight: attributes.includes(name)
      ? theme.typography.fontWeightMedium
      : theme.typography.fontWeightRegular,
  };
}

type Props = {
  viewerScaleY: { [key: string]: number };
  setViewerScaleY: React.Dispatch<
    React.SetStateAction<{ [key: string]: number }>
  >;
};
export default function SortAndFilter({
  viewerScaleY,
  setViewerScaleY,
}: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const clusteringDurationMode = useAppSelector(
    (state) => state.batch.clusteringDurationMode,
  );
  const attributes = useAppSelector((state) => state.batch.attributes);
  const filteredAttributes = useAppSelector(
    (state) => state.batch.filteredAttributes,
  );

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor),
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
    <Stack>
      <Stack>
        <Stack>
          <Typography>Viewing</Typography>
          <Stack direction="row" columnGap={2} sx={{ width: "100%" }}>
            <Stack>
              <FormControlLabel
                control={
                  <Checkbox
                    checked={clusteringDurationMode}
                    onChange={(_event, value) => {
                      dispatch(
                        batchSlice.actions.setClusteringDurationMode(value),
                      );
                    }}
                  />
                }
                label="5 Seconds Only"
              />
            </Stack>
            <FormControl sx={{ flexGrow: 1, flex: 1 }}>
              <InputLabel size="small" id="attributes-chip-label">
                Attributes
              </InputLabel>
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
                MenuProps={MenuProps}
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
            </FormControl>
          </Stack>
        </Stack>
      </Stack>
      <Stack
        sx={{
          overflowY: "hidden",
        }}
      >
        <Typography sx={{ fontSize: "14px" }}>Sorting</Typography>
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
      <Stack sx={{ p: "20px 0" }}>
        <Stack flexDirection="row" columnGap={1} alignItems="center">
          <Typography>Group Individual Scales</Typography>
          <Button
            onClick={() => {
              setViewerScaleY((prev) => {
                const newScaleY = { ...prev };
                for (const key of Object.keys(newScaleY)) {
                  newScaleY[key] = 1;
                }
                return newScaleY;
              });
            }}
          >
            Reset
          </Button>
        </Stack>
        <Stack flexDirection="row" columnGap={1} sx={{ mt: 1 }}>
          {Object.entries(viewerScaleY).map(([viewerName, scales]) => {
            return (
              <Stack
                key={viewerName}
                component="div"
                justifyContent="center"
                alignItems="center"
                sx={{
                  background: "white",
                  padding: "0 10px",
                  fontSize: "14px",
                  border: "solid 1px black",
                }}
                onWheel={(event) => {
                  const baseSensitivity = 0.0005; // tune this so zoom isn’t too fast
                  setViewerScaleY((prev) => {
                    const newScaleY = { ...prev };
                    // compute a delta that shrinks as prev → 0
                    const delta =
                      baseSensitivity * event.deltaY * newScaleY[viewerName];
                    const next = newScaleY[viewerName] + delta;
                    // clamp so you never go negative (or below some minScale)
                    const value = Math.max(next, 0.0001);
                    newScaleY[viewerName] = value;
                    return newScaleY;
                  });
                }}
              >
                <Typography>
                  Scale Y: {viewerScaleY[viewerName].toFixed(2)}
                </Typography>
              </Stack>
            );
          })}
        </Stack>
      </Stack>
    </Stack>
  );
}
