"use client";

import {
  Box,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import { fmtNum } from "../utils";

export default function DigestTable({
  title,
  digest,
}: {
  title: string;
  digest: Record<string, unknown> | null | undefined;
}) {
  if (!digest) return null;
  const keys = ["n", "mean", "std", "min", "p10", "p50", "p90"] as const;
  return (
    <Box sx={{ mb: 2 }}>
      <Typography variant="subtitle2" gutterBottom>
        {title}
      </Typography>
      <Table size="small">
        <TableHead>
          <TableRow>
            {keys.map((k) => (
              <TableCell key={k}>{k}</TableCell>
            ))}
          </TableRow>
        </TableHead>
        <TableBody>
          <TableRow>
            {keys.map((k) => (
              <TableCell key={k}>
                {k === "n" ? String(digest[k] ?? "—") : fmtNum(digest[k])}
              </TableCell>
            ))}
          </TableRow>
        </TableBody>
      </Table>
    </Box>
  );
}
