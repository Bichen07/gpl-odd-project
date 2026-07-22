import { Stack, Typography } from "@mui/material";
import { useAppSelector } from "../../../../redux/hooks";
import PerEgoSelection from "./PerEgoSelection";

export default function ClusteringSelection() {
  const batch = useAppSelector((state) => state.batch.batch);

  return (
    <Stack sx={{ height: "100%" }}>
      {batch?.egos?.map((ego, egoIndex) => {
        return (
          <Stack
            key={ego.id != null ? `ego-${ego.id}` : `ego-${ego.name}-${egoIndex}`}
            sx={{ flex: 1, height: "100%" }}
          >
            {/* <Typography>{ego.name}</Typography> */}
            <PerEgoSelection egoName={ego.name} />
          </Stack>
        );
      })}
    </Stack>
  );
}
