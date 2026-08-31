#!/usr/bin/env bash
# Rebuild and analyze the three paper-case-study result folders in order.
#
# The script intentionally runs each stage sequentially and uses `set -e`.
# A failed rebuild or LLM product stops the whole run so the next stage cannot
# consume an incomplete result.
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v conda >/dev/null 2>&1; then
  echo "ERROR: conda is required; activate/install the analyzer environment first." >&2
  exit 2
fi

if [[ -z "${GOOGLE_API_KEY:-}" ]]; then
  echo "ERROR: GOOGLE_API_KEY is required for the default Gemini cross-analysis." >&2
  exit 2
fi

if [[ -f app/analyzer/.env ]]; then
  set -a
  # shellcheck disable=SC1091
  source app/analyzer/.env
  set +a
fi
export PAYLOAD_API_URL="${PAYLOAD_API_URL:-${PAYLOAD_API:-http://localhost:3020}}"
export PYTHONPATH="${REPO_ROOT}/app/analyzer/src:${REPO_ROOT}/app/llm_pipeline/python:${PYTHONPATH:-}"

ANALYZER=(conda run --no-capture-output -n analyzer python3)
MODEL="${LLM_MODEL:-gemini-2.5-flash}"

run_stage() {
  local label="$1"
  shift
  printf '\n===== %s =====\n' "$label"
  "$@"
}

materialize() {
  local label="$1"
  local analysis_zip="$2"
  local trajectories_zip="$3"
  run_stage "$label: materialize trajectory CSVs" \
    "${ANALYZER[@]}" scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py \
    --analysis-zip "$analysis_zip" \
    --trajectories-zip "$trajectories_zip" \
    --ego-name ITRI
}

rebuild() {
  local label="$1"
  local batch_id="$2"
  local k="$3"
  local silhouette="$4"
  local dataset="$5"
  local analysis_zip="$6"
  local run_dir="$7"

  run_stage "$label: rebuild medoid and parameter-pair dataset" \
    "${ANALYZER[@]}" app/analyzer/src/dataset_builder.py \
    --source payload-save \
    --batch-id "$batch_id" \
    --k "$k" \
    --silhouette "$silhouette" \
    --dataset "$dataset" \
    --ego-name ITRI \
    --analysis-zip "$analysis_zip" \
    --from-run "$run_dir" \
    --xodr results/map/hct_6_no_930.xodr \
    --medoids all \
    --param-boundaries all \
    --emb-boundaries none \
    --outliers none
}

analyze() {
  local label="$1"
  local batch_id="$2"
  local run_dir="$3"

  run_stage "$label: medoid LLM analysis" \
    "${ANALYZER[@]}" -m llm_pipeline.cli cluster-interpret \
    --results-dir "$run_dir" \
    --batch-id "$batch_id" \
    --model "$MODEL" \
    --products medoid

  run_stage "$label: parameter-space pair LLM analysis" \
    "${ANALYZER[@]}" -m llm_pipeline.cli cluster-interpret \
    --results-dir "$run_dir" \
    --batch-id "$batch_id" \
    --model "$MODEL" \
    --products parameter-space-pairs

  run_stage "$label: cluster summary LLM analysis" \
    "${ANALYZER[@]}" -m llm_pipeline.cli cluster-interpret \
    --results-dir "$run_dir" \
    --batch-id "$batch_id" \
    --model "$MODEL" \
    --products summary

  run_stage "$label: whole-partition cross-cluster LLM analysis" \
    "${ANALYZER[@]}" -m llm_pipeline.cli cross-cluster-eval \
    --run-dir "$run_dir" \
    --model "$MODEL"
}

CASE3_ZIP="data/paper_casestudies/case3/casestudy3.zip"
CASE3_TRAJ="data/paper_casestudies/case3/trajectories-249.zip"
CASE2_ZIP="data/paper_casestudies/case2/casestudy2.zip"
CASE2_TRAJ="data/paper_casestudies/case2/trajectories-259.zip"

materialize "Case Study 3 / batch 8" "$CASE3_ZIP" "$CASE3_TRAJ"
materialize "Case Study 2 / batch 9" "$CASE2_ZIP" "$CASE2_TRAJ"

rebuild "batch8 k=6 s=0.6113" 8 6 0.6113 dataset3 "$CASE3_ZIP" \
  results/batch8/6_cluster_s=0.6113
analyze "batch8 k=6 s=0.6113" 8 results/batch8/6_cluster_s=0.6113

rebuild "batch8 k=3 s=0.8032" 8 3 0.8032 dataset3 "$CASE3_ZIP" \
  results/batch8/3_cluster_s=0.8032
analyze "batch8 k=3 s=0.8032" 8 results/batch8/3_cluster_s=0.8032

rebuild "batch9 k=4 s=0.7482" 9 4 0.7482 dataset2 "$CASE2_ZIP" \
  results/batch9/4_cluster_s=0.7482
analyze "batch9 k=4 s=0.7482" 9 results/batch9/4_cluster_s=0.7482

printf '\n===== ALL REQUESTED RUNS COMPLETED =====\n'
