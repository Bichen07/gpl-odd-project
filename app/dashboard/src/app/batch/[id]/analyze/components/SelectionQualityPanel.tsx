"use client";

import {
  Alert,
  Chip,
  Divider,
  Paper,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import { fmtNum } from "../utils";

const SELECTION_COMPONENT_HELP: Record<string, string> = {
  outcome_purity:
    "Share of clusters whose collision rate sits at 0% or 100%. Mixed clusters usually hide two behaviors.",
  motive_distinctness:
    "Distinct primary_motive values divided by the number of captioned clusters. Repeats hint at over-splitting.",
  parameter_space_pair_decisiveness:
    "Share of near-identical-Parameter-space pairs whose outcome flips across the boundary. Low means the boundary rarely changes anything.",
  no_merge_candidates:
    "1.0 when no two clusters share a motive with similar collision rate and overlapping parameter ranges.",
};

export default function SelectionQualityPanel({
  selectionEval,
  crossEval,
  quality,
}: {
  selectionEval: Record<string, unknown> | null;
  crossEval: Record<string, unknown> | null;
  quality: Record<string, unknown> | null;
}) {
  const sel = (selectionEval ?? null) as Record<string, any> | null;
  const cross = (crossEval ?? null) as Record<string, any> | null;
  const qual = (quality ?? null) as Record<string, any> | null;
  const components = (sel?.components ?? {}) as Record<string, number | null>;
  const findings = (sel?.findings ?? []) as string[];
  const crossIsStub = cross?.stub === true;

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        Is this cluster selection good?
      </Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
        Two independent halves. The deterministic checks are measured from the artifacts on disk
        and need no LLM; the cross-cluster verdict is the LLM reading the medoid and Parameter-space pair cards.
        Silhouette is deliberately not the arbiter here — it scores geometry in FPC space, not
        whether the clusters describe different behaviors.
      </Typography>

      <Stack direction="row" spacing={2} flexWrap="wrap" sx={{ mb: 2 }}>
        <Chip
          label={`deterministic ${sel?.selection_score ?? "n/a"}`}
          color={sel?.selection_score != null ? "primary" : "default"}
        />
        <Chip
          label={`LLM separation ${cross?.behavioral_separation_score ?? "n/a"}/10`}
          color={cross?.behavioral_separation_score != null ? "primary" : "default"}
        />
        <Chip
          label={`LLM boundary clarity ${cross?.boundary_clarity_score ?? "n/a"}/10`}
          color={cross?.boundary_clarity_score != null ? "primary" : "default"}
        />
        <Chip
          label={`composite ${qual?.final_score ?? "n/a"}`}
          variant="outlined"
        />
      </Stack>

      {!sel && (
        <Alert severity="info" sx={{ mb: 2 }}>
          No <code>cluster_selection_eval.json</code> yet. It is written by any pipeline run, or
          standalone with <code>python -m llm_pipeline.cli selection-eval --run-dir …</code> (no
          LLM required).
        </Alert>
      )}

      {sel && (
        <>
          <Table size="small" sx={{ mb: 2 }}>
            <TableHead>
              <TableRow>
                <TableCell>deterministic component</TableCell>
                <TableCell>score</TableCell>
                <TableCell>weight</TableCell>
                <TableCell>what it measures</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {Object.entries(components).map(([key, value]) => (
                <TableRow key={key}>
                  <TableCell>{key}</TableCell>
                  <TableCell>{value == null ? "n/a" : fmtNum(value, 3)}</TableCell>
                  <TableCell>
                    {fmtNum((sel.weights as Record<string, number>)?.[key], 2)}
                  </TableCell>
                  <TableCell>
                    <Typography variant="caption" color="text.secondary">
                      {SELECTION_COMPONENT_HELP[key] ?? ""}
                    </Typography>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>

          {findings.length > 0 && (
            <Stack spacing={0.5} sx={{ mb: 2 }}>
              {findings.map((f, i) => (
                <Typography key={i} variant="body2">
                  • {f}
                </Typography>
              ))}
            </Stack>
          )}

          {(sel.merge_candidates ?? []).length > 0 && (
            <Alert severity="warning" sx={{ mb: 2 }}>
              <Typography variant="body2" fontWeight="bold">
                Merge candidates
              </Typography>
              {(sel.merge_candidates as Array<Record<string, any>>).map((m, i) => (
                <Typography key={i} variant="caption" display="block">
                  cluster{m.clusters?.[0]} + cluster{m.clusters?.[1]} — shared motive{" "}
                  {m.shared_motive}, param overlap {m.param_overlap}
                </Typography>
              ))}
            </Alert>
          )}
        </>
      )}

      <Divider sx={{ my: 2 }} />

      <Typography variant="subtitle2" gutterBottom>
        Cross-cluster verdict (LLM)
      </Typography>
      {!cross || crossIsStub ? (
        <Alert severity="info">
          {crossIsStub
            ? `Stub only — ${String(cross?.inter_notes ?? "no LLM run yet")}.`
            : "No cross_cluster_eval.json yet. Run the cluster analysis above."}
        </Alert>
      ) : (
        <Stack spacing={1}>
          {cross.selection_verdict && (
            <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
              {String(cross.selection_verdict)}
            </Typography>
          )}
          {cross.recommended_action && (
            <Typography variant="body2">
              <strong>Recommended action:</strong> {String(cross.recommended_action)}
              {cross.recommended_action_detail
                ? ` — ${String(cross.recommended_action_detail)}`
                : ""}
            </Typography>
          )}
        </Stack>
      )}
    </Paper>
  );
}
