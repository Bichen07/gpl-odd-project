"use client";
import dynamic from "next/dynamic";
import { useAppSelector } from "../../../../redux/hooks";
import { Stack } from "@mui/material";

const Plot = dynamic(() => import("./Plot"), { ssr: false });

export default function ProjectionSpace() {
  const egos = useAppSelector((state) => state.batch.egos);

  return (
    <Stack sx={{ height: "100%" }}>
      {egos.map((ego) => {
        return (
          <Stack key={ego} sx={{ flex: 1, height: `calc(100% / ${egos.length})` }}>
            {/* <Typography>{ego}</Typography> */}
            <Plot egoName={ego} />
          </Stack>
        );
      })}
    </Stack>
  );
}
