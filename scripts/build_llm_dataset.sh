#!/usr/bin/env bash
# Build LLM dataset from medoid trials
#
# --- Legacy positional usage (alldatasets mode) ---
#   ./scripts/build_llm_dataset.sh <dataset> <n_clusters> [run_id] [--trials 'batch:index,...']
#
# --- New payload-save mode ---
#   ./scripts/build_llm_dataset.sh \
#     --source payload-save \
#     --batch-id 1 \
#     --k 4 \
#     [--save-doc-id 46] \
#     [--dataset dataset1] \
#     [--ego-name ITRI] \
#     [--ego-zoom-radius 30] \
#     [--duration-mode full]
#
# Examples:
#   ./scripts/build_llm_dataset.sh dataset1 8
#   ./scripts/build_llm_dataset.sh dataset1 3 "" --trials "1:100,1:200,1:300"
#   ./scripts/build_llm_dataset.sh --source payload-save --batch-id 1 --k 4 --dataset dataset1

set -euo pipefail

# ---------------------------------------------------------------
# Detect mode: if first arg starts with '--' it is flag-style;
# otherwise fall back to legacy positional <dataset> <n_clusters>
# ---------------------------------------------------------------
SOURCE_MODE="alldatasets"
DATASET=""
DATASET_PROVIDED=0      # 1 only when the user explicitly passes --dataset / positional
N_CLUSTERS=""
BATCH_ID=""
RUN_ID=""
LIST_ONLY=0            # 1 when --list-clusterings is requested (no build, no summary)
EXTRA_FLAGS=()

if [[ $# -gt 0 && "${1:-}" != --* ]]; then
    # Legacy positional mode
    DATASET="${1:-}"
    DATASET_PROVIDED=1
    N_CLUSTERS="${2:-}"
    shift 2

    if [[ $# -gt 0 && "${1:-}" != --* ]]; then
        RUN_ID="$1"
        shift
    fi

    if [[ -z "$DATASET" ]] || [[ -z "$N_CLUSTERS" ]]; then
        echo "Usage:"
        echo "  $0 <dataset> <n_clusters> [run_id] [--trials 'batch:index,...']"
        echo "  $0 --source payload-save --batch-id 1 --k 4 [--dataset dataset1] [--save-doc-id 46]"
        exit 1
    fi
else
    # Flag-based mode — parse just the flags we need to determine SOURCE, DATASET,
    # N_CLUSTERS, and RUN_ID; all other flags are forwarded as-is.
    REMAINING=("$@")
    IDX=0
    while [[ $IDX -lt ${#REMAINING[@]} ]]; do
        arg="${REMAINING[$IDX]}"
        next_idx=$(( IDX + 1 ))
        case "$arg" in
            --source)
                SOURCE_MODE="${REMAINING[$next_idx]}"
                IDX=$(( IDX + 2 ))
                ;;
            --dataset)
                DATASET="${REMAINING[$next_idx]}"
                DATASET_PROVIDED=1
                IDX=$(( IDX + 2 ))
                ;;
            --n-clusters)
                N_CLUSTERS="${REMAINING[$next_idx]}"
                IDX=$(( IDX + 2 ))
                ;;
            --k)
                # --k also determines n_clusters for output path labelling
                if [[ -z "$N_CLUSTERS" ]]; then
                    N_CLUSTERS="${REMAINING[$next_idx]}"
                fi
                EXTRA_FLAGS+=("$arg" "${REMAINING[$next_idx]}")
                IDX=$(( IDX + 2 ))
                ;;
            --batch-id)
                BATCH_ID="${REMAINING[$next_idx]}"
                EXTRA_FLAGS+=("$arg" "${REMAINING[$next_idx]}")
                IDX=$(( IDX + 2 ))
                ;;
            --run-id)
                RUN_ID="${REMAINING[$next_idx]}"
                IDX=$(( IDX + 2 ))
                ;;
            --list-clusterings)
                LIST_ONLY=1
                EXTRA_FLAGS+=("$arg")
                IDX=$(( IDX + 1 ))
                ;;
            *)
                EXTRA_FLAGS+=("$arg")
                IDX=$(( IDX + 1 ))
                ;;
        esac
    done

    if [[ "$SOURCE_MODE" == "payload-save" ]]; then
        # --dataset is optional: when omitted, dataset_builder.py resolves the
        # canonical dataset (dataset1/2/3) from --batch-id. N_CLUSTERS is only
        # used for the cosmetic echo below; Python derives the real k.
        if [[ -z "$N_CLUSTERS" ]]; then
            N_CLUSTERS="0"  # placeholder; actual k resolved by Python
        fi
    else
        if [[ -z "$DATASET" ]] || [[ -z "$N_CLUSTERS" ]]; then
            echo "Usage:"
            echo "  $0 <dataset> <n_clusters> [run_id] [--trials 'batch:index,...']"
            echo "  $0 --source payload-save --batch-id 1 --k 4 [--dataset dataset1] [--save-doc-id 46]"
            exit 1
        fi
    fi
fi

# Activate conda environment
CONDA_BASE=$(conda info --base 2>/dev/null || echo "$HOME/miniconda3")
# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"
conda activate analyzer 2>/dev/null || {
    echo "❌ ERROR: Failed to activate 'analyzer' conda environment"
    echo "   Please run: conda env create -f app/analyzer/environment.yml"
    exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

export PYTHONPATH="${PROJECT_ROOT}/app/llm_pipeline/python:${PROJECT_ROOT}/app/analyzer/src:${PYTHONPATH:-}"

# Build Python command
CMD=(
    "python3" "app/analyzer/src/dataset_builder.py"
    "--source" "$SOURCE_MODE"
)

# Only forward --dataset when the user explicitly provided it; otherwise let
# dataset_builder.py resolve it from --batch-id (payload-save mode).
if [[ "$DATASET_PROVIDED" == "1" ]]; then
    CMD+=("--dataset" "$DATASET")
fi

# Only pass --n-clusters when it's a real value (not the placeholder "0")
if [[ -n "$N_CLUSTERS" && "$N_CLUSTERS" != "0" ]]; then
    CMD+=("--n-clusters" "$N_CLUSTERS")
fi

if [[ -n "$RUN_ID" ]]; then
    CMD+=("--run-id" "$RUN_ID")
fi

# Append any remaining flags (--trials, --batch-id, --k, --save-doc-id, etc.)
if [[ ${#EXTRA_FLAGS[@]} -gt 0 ]]; then
    CMD+=("${EXTRA_FLAGS[@]}")
fi

# In legacy positional mode, also pass through remaining "$@"
if [[ "$SOURCE_MODE" == "alldatasets" && ${#EXTRA_FLAGS[@]} -eq 0 ]]; then
    CMD+=("$@")
fi

"${CMD[@]}"

# --- List-only mode: nothing was built, skip the output summary ---
if [[ "$LIST_ONLY" == "1" ]]; then
    exit 0
fi

# --- Cosmetic summary ---
# Output layout: results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/...
echo ""
echo "🎉 Done! See the 'Output dir:' path printed above:"
echo "   results/batch<id>/<k>_cluster_s=<silhouette>/cluster<i>/"
echo "   Each cluster dir has: context.md, cluster.json, action.yaml,"
echo "   description.txt, trajectory.csv, map_overview.jpg, snapshots/"
echo "   snapshots/*.jpg are dual-panel: whole scene (left) + ego zoom (right)"
echo "   Shared map assets: results/map/"
echo ""
echo "One-time map assets (if results/map/ is empty):"
echo "  python3 scripts/generate_map_tracks.py --dataset <dataset>"
echo "  python3 scripts/map_preprocess.py     --dataset <dataset>"
