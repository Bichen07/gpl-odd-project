"use client";

import { Stack, Typography } from "@mui/material";
import { useAppSelector } from "../../../../redux/hooks";
import PerEgoSelection from "./PerEgoSelection";

/**
 * Renders Clustering Selection for egos selected in Controls → Filtering
 * (“Showing AVs” → Redux `state.batch.egos`). No separate ego toggle here.
 */
export default function ClusteringSelection() {
  const egos = useAppSelector((state) => state.batch.egos);

  if (egos.length === 0) {
    return (
      <Typography sx={{ p: 2 }} color="text.secondary">
        No AVs selected — use Controls → Filtering → Showing AVs.
      </Typography>
    );
  }

  return (
    <Stack sx={{ height: "100%" }}>
      {egos.map((egoName, egoIndex) => (
        <Stack
          key={`ego-${egoName}-${egoIndex}`}
          sx={{ flex: 1, height: "100%", minHeight: 0 }}
        >
          {egos.length > 1 && (
            <Typography fontSize={12} color="text.secondary" sx={{ px: 1, pt: 0.5 }}>
              {egoName === "ITRI" ? "System A (ITRI)" : egoName}
            </Typography>
          )}
          <PerEgoSelection egoName={egoName} />
        </Stack>
      ))}
    </Stack>
  );
}
