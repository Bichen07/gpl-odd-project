import { NextRequest, NextResponse } from "next/server";
import { spawn } from "child_process";
import fs from "fs";
import path from "path";

function findProjectRoot(start: string): string {
  let current = start;
  for (let i = 0; i < 8; i += 1) {
    if (path.basename(current) === "gpl-odd-project") return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  return path.resolve(start, "..", "..");
}

const STATUS_DIR = "/tmp/gpl-odd-bev-status";

function statusFile(runId: string) {
  return path.join(STATUS_DIR, `${runId}.json`);
}

function writeStatus(runId: string, data: Record<string, unknown>) {
  fs.mkdirSync(STATUS_DIR, { recursive: true });
  fs.writeFileSync(statusFile(runId), JSON.stringify(data));
}

function readStatus(runId: string): Record<string, unknown> | null {
  const p = statusFile(runId);
  if (!fs.existsSync(p)) return null;
  try {
    return JSON.parse(fs.readFileSync(p, "utf-8"));
  } catch {
    return null;
  }
}

/**
 * POST — Start BEV generation for selected clustering
 * Body: { dataset, nClusters, batchId, clusteringData: { trialId: label }, nSnapshots? }
 */
export async function POST(req: NextRequest) {
  const body = await req.json();
  const {
    dataset,
    nClusters,
    batchId,
    clusteringData,
    nSnapshots = 12,
  } = body as {
    dataset: string;
    nClusters: number;
    batchId: string;
    clusteringData: Record<string, string>;
    nSnapshots?: number;
  };

  if (!dataset || !nClusters || !clusteringData) {
    return NextResponse.json(
      { error: "dataset, nClusters and clusteringData are required" },
      { status: 400 },
    );
  }

  const projectRoot = findProjectRoot(process.cwd());
  const runId = `dashboard_${dataset}_${nClusters}c_${Date.now()}`;

  const totalImages = nClusters * nSnapshots;
  writeStatus(runId, {
    runId,
    state: "starting",
    progress: 0,
    total: totalImages,
    message: "Starting BEV generation...",
    clusters: {},
  });

  const analyzerSrc = path.join(projectRoot, "app", "analyzer", "src");
  const env: Record<string, string> = {
    ...(process.env as Record<string, string>),
    PYTHONPATH: `${analyzerSrc}:${process.env.PYTHONPATH || ""}`,
  };

  const clusterDataFile = path.join(STATUS_DIR, `${runId}_clusters.json`);
  fs.writeFileSync(clusterDataFile, JSON.stringify({ dataset, nClusters, nSnapshots, batchId, clusteringData, runId }));

  const scriptContent = `
import sys, json, os
sys.path.insert(0, "${analyzerSrc}")

from data.dataset_config import trial_id_to_csv_indices, xodr_path_for_dataset, get_dataset_config
from data.csv_roadid_loader import csv_exists
import numpy as np

with open("${clusterDataFile}") as _f:
    _cfg = json.load(_f)
clustering_data = _cfg["clusteringData"]
dataset = _cfg["dataset"]
n_clusters = _cfg["nClusters"]
n_snapshots = _cfg["nSnapshots"]
batch_id = _cfg["batchId"]
run_id = _cfg["runId"]
project_root = "${projectRoot}"
status_file = "${statusFile(runId)}"

def update_status(state, progress, total, message, clusters=None):
    data = {"runId": run_id, "state": state, "progress": progress, "total": total, "message": message}
    if clusters:
        data["clusters"] = clusters
    with open(status_file, "w") as f:
        json.dump(data, f)
    print(f"STATUS: {state} {progress}/{total} {message}", flush=True)

# group trials by label
from collections import defaultdict
label_trials = defaultdict(list)
for tid, label in clustering_data.items():
    label_trials[str(label)].append(tid)

unique_labels = sorted([l for l in label_trials.keys() if l != "-1"])
total = len(unique_labels) * n_snapshots
update_status("computing_medoids", 0, total, f"Computing medoids for {len(unique_labels)} clusters...")

# load embeddings to compute medoids
embeddings_path = os.path.join(project_root, "alldatasets", dataset, "clustering.json")
if os.path.isfile(embeddings_path):
    with open(embeddings_path) as f:
        embeddings_data = json.load(f)
    embeddings_dict = embeddings_data.get("embeddings", {})
else:
    embeddings_dict = {}

# compute medoid per cluster
from sklearn.metrics import pairwise_distances_argmin
medoids = {}
for label in unique_labels:
    tids = label_trials[label]
    vecs = []
    valid_tids = []
    for tid in tids:
        if tid in embeddings_dict:
            vecs.append(embeddings_dict[tid])
            valid_tids.append(tid)
    if not vecs:
        continue
    X = np.array(vecs, dtype=np.float64)
    centroid = X.mean(axis=0, keepdims=True)
    idx = pairwise_distances_argmin(centroid, X, metric="euclidean")[0]
    medoids[label] = valid_tids[idx]

update_status("generating_bev", 0, total, f"Found {len(medoids)} medoids, generating BEV...")

# generate BEV
from pathlib import Path
output_root = Path(project_root) / "llm_artifacts" / run_id
(output_root / "clusters").mkdir(parents=True, exist_ok=True)

from bev.tier2_renderer import Tier2BevRenderer, resolve_tier2_paths
xodr_resolved, map_tracks, location = resolve_tier2_paths(dataset)
xodr_path = xodr_path_for_dataset(dataset)

tier2 = None
if map_tracks.is_file():
    tier2 = Tier2BevRenderer(
        str(map_tracks),
        str(xodr_path if xodr_path.is_file() else xodr_resolved),
        location=location,
        dataset_name=dataset,
    )

progress = 0
cluster_results = {}
for label, medoid_tid in medoids.items():
    cluster_dir = output_root / "clusters" / f"cluster_{label}"
    bev_dir = cluster_dir / "bev"
    bev_dir.mkdir(parents=True, exist_ok=True)

    try:
        batch_id_int, trial_index = trial_id_to_csv_indices(dataset, medoid_tid)
    except Exception as e:
        update_status("generating_bev", progress, total, f"Skip cluster {label}: {e}")
        progress += n_snapshots
        continue

    if not csv_exists(batch_id_int, trial_index):
        update_status("generating_bev", progress, total, f"Skip cluster {label}: CSV not found")
        progress += n_snapshots
        continue

    if tier2 is None:
        update_status("generating_bev", progress, total, f"Skip BEV: map_tracks not found")
        progress += n_snapshots
        continue

    snaps = tier2.render_trial_from_esmini_csv(
        batch_id_int,
        trial_index,
        str(bev_dir),
        n_snapshots=n_snapshots,
        file_prefix=f"trial_{medoid_tid}",
    )
    cluster_results[label] = {
        "medoidTrialId": medoid_tid,
        "clusterSize": len(label_trials[label]),
        "bevFiles": [os.path.basename(s) for s in snaps],
    }
    progress += n_snapshots
    update_status("generating_bev", progress, total,
        f"Cluster {label} done ({len(snaps)} images). {progress}/{total}",
        cluster_results)

    # save medoid + stats
    stats = {
        "cluster_label": label,
        "cluster_size": len(label_trials[label]),
        "medoid_trial_id": medoid_tid,
        "batch_id": batch_id_int,
        "trial_index": trial_index,
    }
    (cluster_dir / "stats.json").write_text(json.dumps(stats, indent=2))

# write manifest
manifest = {
    "run_id": run_id,
    "dataset": dataset,
    "n_clusters": n_clusters,
    "medoids": medoids,
    "clusters": cluster_results,
}
(output_root / "manifest.json").write_text(json.dumps(manifest, indent=2))

update_status("done", total, total, f"BEV generation complete! {len(cluster_results)} clusters.", cluster_results)
`;

  const tmpScript = path.join(STATUS_DIR, `${runId}.py`);
  fs.mkdirSync(STATUS_DIR, { recursive: true });
  fs.writeFileSync(tmpScript, scriptContent);

  const child = spawn("python3", [tmpScript], {
    cwd: projectRoot,
    env: env as NodeJS.ProcessEnv,
    detached: true,
    stdio: "ignore",
  });
  child.unref();

  return NextResponse.json({ runId, total: totalImages });
}

/**
 * GET — Poll status of BEV generation
 */
export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const runId = url.searchParams.get("runId");
  if (!runId) {
    return NextResponse.json({ error: "runId required" }, { status: 400 });
  }
  const status = readStatus(runId);
  if (!status) {
    return NextResponse.json({ state: "unknown", message: "No status found" });
  }
  return NextResponse.json(status);
}
