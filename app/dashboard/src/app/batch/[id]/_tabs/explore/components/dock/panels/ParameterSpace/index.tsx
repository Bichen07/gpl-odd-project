"use client";
import dynamic from "next/dynamic";
import { Button, Stack } from "@mui/material";
import { useAppSelector } from "../../../../redux/hooks";
import { TRIAL_DRAG_TYPE, useChatUi } from "../../chatContext";

const Plot = dynamic(() => import("./Plot"), { ssr: false });

export default function ParameterSpace() {
  const egos = useAppSelector((state) => state.batch.egos);
  const selected = useAppSelector((state) => state.batch.selectedTrialIds);
  const filtered = useAppSelector((state) => state.batch.filteredTrialIds);
  const chat = useChatUi();
  const filterIds = (filtered ?? []).map(String);
  const lassoIds = selected.value.map(String);
  const visibleLasso =
    filterIds.length > 0 ? lassoIds.filter((id) => filterIds.includes(id)) : lassoIds;
  const ids = visibleLasso.length > 0 ? visibleLasso : filterIds;
  const attachment = {
    trialIds: ids,
    source: (visibleLasso.length > 0 ? "lasso" : "filter") as "lasso" | "filter",
    total: ids.length,
  };

  return (
    <Stack sx={{ height: "100%", minHeight: 0 }}>
      {ids.length > 0 && (
        <Button
          size="small"
          draggable
          onDragStart={(event) => {
            event.dataTransfer.setData(TRIAL_DRAG_TYPE, JSON.stringify(attachment));
            event.dataTransfer.effectAllowed = "copy";
          }}
          onClick={() => {
            chat.setAttachment(attachment);
            chat.setOpen(true);
          }}
          sx={{ alignSelf: "flex-start", mx: 0.5, my: 0.25, flexShrink: 0 }}
        >
          Ask about {ids.length} trials
        </Button>
      )}
      {egos.map((ego) => {
        return (
          <Stack key={ego} sx={{ flex: 1, minHeight: 0 }}>
            {/* <Typography>{ego}</Typography> */}
            <Plot egoName={ego} />
          </Stack>
        );
      })}
    </Stack>
  );
}
