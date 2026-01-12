import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { Stack, Typography } from "@mui/material";

export const SortableItem = ({ id }: { id: string }) => {
  const { attributes, listeners, setNodeRef, transform, transition } =
    useSortable({ id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
    padding: "10px",
    backgroundColor: "#e0e0e0",
    border: "1px solid #ccc",
    borderRadius: "4px",
    cursor: "grab",
  };

  return (
    <Stack ref={setNodeRef} style={style} {...attributes} {...listeners}>
      <Typography
        noWrap
        sx={{ width: "150px", fontSize: "12px" }}
        textAlign="center"
      >
        {id}
      </Typography>
    </Stack>
  );
};
