import { Stack, Typography } from "@mui/material";
import { useAppSelector } from "../../../../redux/hooks";
import HeatmapColorscales from "./HeatmapColorscales";
import ScatterGroups from "./ScatterGroups";
import Image from "next/image";

export default function Legends() {
  const filteredAttributes = useAppSelector(
    (slice) => slice.batch.filteredAttributes
  );
  const bound = useAppSelector((slice) => slice.batch.bound);

  return (
    <Stack sx={{ padding: 1 }} rowGap={1}>
      <ScatterGroups />
      <HeatmapColorscales
        bound={bound}
        filteredAttributes={filteredAttributes}
      />
    </Stack>
  );
}
