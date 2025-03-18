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
import { BoundaryFilter } from "./BoundaryFilter";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";
import { GradientFilter } from "./GradientFilter";

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
  attributes: string[];
  filteredAttributes: string[];
  setFilteredAttributes: React.Dispatch<React.SetStateAction<string[]>>;
};
export default function SortAndFilter({
  attributes,
  filteredAttributes,
  setFilteredAttributes,
}: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const clusteringDurationMode = useAppSelector(
    (state) => state.session.clusteringDurationMode,
  );

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor),
  );

  const handleDragEnd = (event: any) => {
    const { active, over } = event;
    if (active.id !== over.id) {
      setFilteredAttributes((prevItems) => {
        const oldIndex = prevItems.indexOf(active.id);
        const newIndex = prevItems.indexOf(over.id);
        return arrayMove(prevItems, oldIndex, newIndex);
      });
    }
  };

  return (
    <Stack>
      <Stack>
        {/* <Stack> */}
        {/*   <Typography variant="subtitle1">Filtering</Typography> */}
        {/*   <Stack direction="row" columnGap={5}> */}
        {/*     <BoundaryFilter /> */}
        {/*     <GradientFilter /> */}
        {/*   </Stack> */}
        {/*   <Button */}
        {/*     sx={{ width: "100%" }} */}
        {/*     variant="contained" */}
        {/*     onClick={() => { */}
        {/*       dispatch(sessionSlice.actions.filterTrials()); */}
        {/*     }} */}
        {/*   > */}
        {/*     Filter */}
        {/*   </Button> */}
        {/* </Stack> */}
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
                        sessionSlice.actions.setClusteringDurationMode(value),
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
              <Select
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
                  setFilteredAttributes(
                    // On autofill we get a stringified value.
                    typeof value === "string" ? value.split(",") : value,
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
    </Stack>
  );
}
