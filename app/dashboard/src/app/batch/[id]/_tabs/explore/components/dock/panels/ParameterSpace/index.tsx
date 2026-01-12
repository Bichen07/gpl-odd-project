"use client";
import { useAppSelector } from "../../../../redux/hooks";
import { Stack, Typography } from "@mui/material";
import Plot from "./Plot";

export default function ParameterSpace() {
  const egos = useAppSelector((state) => state.batch.egos);

  return (
    <Stack sx={{ height: "100%" }}>
      {egos.map((ego) => {
        return (
          <Stack sx={{ flex: 1, height: `calc(100% / ${egos.length})` }}>
            {/* <Typography>{ego}</Typography> */}
            <Plot egoName={ego} />
          </Stack>
        );
      })}
    </Stack>
  );
}
