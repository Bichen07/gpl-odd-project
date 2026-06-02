import { NextRequest, NextResponse } from "next/server";
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

function readFileSafe(filePath: string): string {
  if (!fs.existsSync(filePath)) return "";
  return fs.readFileSync(filePath, "utf-8");
}

type StageView = { files: string[]; preview: string; interpretations?: ClusterInterp[] };

type ClusterInterp = {
  clusterId: string;
  clusterLabel: string;
  behaviorDescription: string;
  confidence: string;
  rawYaml: string;
  path: string;
};

function parseYamlFields(yamlText: string): {
  clusterLabel: string;
  behaviorDescription: string;
  confidence: string;
} {
  const label =
    yamlText.match(/^cluster_label:\s*(.+)$/m)?.[1]?.trim() ||
    yamlText.match(/^cluster_label:\s*["']?([^"'\n]+)/m)?.[1]?.trim() ||
    "";
  const behavior =
    yamlText.match(/^behavior_description:\s*(.+)$/m)?.[1]?.trim() ||
    yamlText.match(/^behavior_description:\s*>?\s*\n\s+(.+)/m)?.[1]?.trim() ||
    "";
  const confidence =
    yamlText.match(/^confidence:\s*(.+)$/m)?.[1]?.trim() || "";
  return {
    clusterLabel: label.replace(/^["']|["']$/g, ""),
    behaviorDescription: behavior.replace(/^["']|["']$/g, ""),
    confidence: confidence.replace(/^["']|["']$/g, ""),
  };
}

function loadStage2bInterpretations(
  projectRoot: string,
  runId: string,
): ClusterInterp[] {
  const dirs = [
    path.join(
      projectRoot,
      "app",
      "llm_pipeline",
      "artifacts",
      "stage2b_cluster_interpretation",
      runId,
    ),
    path.join(projectRoot, "llm_artifacts", runId, "clusters"),
  ];

  const out: ClusterInterp[] = [];

  const stage2b = dirs[0];
  if (fs.existsSync(stage2b)) {
    for (const f of fs.readdirSync(stage2b)) {
      if (!f.endsWith("_interpretation.yaml")) continue;
      const full = path.join(stage2b, f);
      const text = readFileSafe(full);
      const clusterId = f.replace("cluster_", "").replace("_interpretation.yaml", "");
      const fields = parseYamlFields(text);
      out.push({
        clusterId,
        clusterLabel: fields.clusterLabel || `Cluster ${clusterId}`,
        behaviorDescription: fields.behaviorDescription,
        confidence: fields.confidence,
        rawYaml: text,
        path: full,
      });
    }
  }

  const clustersDir = dirs[1];
  if (fs.existsSync(clustersDir)) {
    for (const entry of fs.readdirSync(clustersDir, { withFileTypes: true })) {
      if (!entry.isDirectory() || !entry.name.startsWith("cluster_")) continue;
      const yml = path.join(
        clustersDir,
        entry.name,
        "cluster_interpretation.yaml",
      );
      if (!fs.existsSync(yml)) continue;
      const clusterId = entry.name.replace("cluster_", "");
      if (out.some((x) => x.clusterId === clusterId)) continue;
      const text = readFileSafe(yml);
      const fields = parseYamlFields(text);
      out.push({
        clusterId,
        clusterLabel: fields.clusterLabel || `Cluster ${clusterId}`,
        behaviorDescription: fields.behaviorDescription,
        confidence: fields.confidence,
        rawYaml: text,
        path: yml,
      });
    }
  }

  return out.sort((a, b) => a.clusterId.localeCompare(b.clusterId));
}

function isClusterDatasetRun(projectRoot: string, runId: string): boolean {
  const llmRun = path.join(projectRoot, "llm_artifacts", runId);
  if (!fs.existsSync(llmRun)) return false;
  return (
    fs.existsSync(path.join(llmRun, "manifest.json")) ||
    fs.existsSync(path.join(llmRun, "clusters"))
  );
}

function runHasBevImages(projectRoot: string, runId: string): boolean {
  const clustersDir = path.join(projectRoot, "llm_artifacts", runId, "clusters");
  if (!fs.existsSync(clustersDir)) return false;
  for (const entry of fs.readdirSync(clustersDir, { withFileTypes: true })) {
    if (!entry.isDirectory() || !entry.name.startsWith("cluster_")) continue;
    const bevDir = path.join(clustersDir, entry.name, "bev");
    if (!fs.existsSync(bevDir)) continue;
    for (const f of fs.readdirSync(bevDir)) {
      if (/\.(jpg|jpeg|png)$/i.test(f)) return true;
    }
  }
  return false;
}

function pickDefaultRunId(
  clusterRuns: string[],
  allRuns: string[],
  projectRoot: string,
): string | null {
  const withBev = clusterRuns.find((id) => runHasBevImages(projectRoot, id));
  if (withBev) return withBev;
  if (clusterRuns.length > 0) return clusterRuns[0];
  return allRuns[0] || null;
}

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const runId = url.searchParams.get("runId");
  const projectRoot = findProjectRoot(process.cwd());

  const pipelineArtifacts = path.join(
    projectRoot,
    "app",
    "llm_pipeline",
    "artifacts",
  );
  const llmArtifactsRoot = path.join(projectRoot, "llm_artifacts");

  const runSet = new Set<string>();

  if (fs.existsSync(pipelineArtifacts)) {
    for (const stage of fs.readdirSync(pipelineArtifacts, { withFileTypes: true })) {
      if (!stage.isDirectory()) continue;
      const stagePath = path.join(pipelineArtifacts, stage.name);
      for (const entry of fs.readdirSync(stagePath, { withFileTypes: true })) {
        if (entry.isDirectory()) runSet.add(entry.name);
      }
    }
  }

  if (fs.existsSync(llmArtifactsRoot)) {
    for (const entry of fs.readdirSync(llmArtifactsRoot, { withFileTypes: true })) {
      if (entry.isDirectory()) runSet.add(entry.name);
    }
  }

  const runs = Array.from(runSet).sort().reverse();
  const clusterRuns = runs
    .filter((id) => isClusterDatasetRun(projectRoot, id))
    .sort()
    .reverse();
  const captureRuns = runs.filter((id) => !clusterRuns.includes(id));
  const defaultRunId = pickDefaultRunId(clusterRuns, runs, projectRoot);
  const selectedRunId =
    runId && runSet.has(runId) ? runId : defaultRunId;
  const hasBev = selectedRunId
    ? runHasBevImages(projectRoot, selectedRunId)
    : false;

  const stages: Record<string, StageView> = {};

  if (selectedRunId && fs.existsSync(pipelineArtifacts)) {
    const stageDirs = fs
      .readdirSync(pipelineArtifacts, { withFileTypes: true })
      .filter((d) => d.isDirectory())
      .map((d) => d.name);

    for (const stage of stageDirs) {
      const dir = path.join(pipelineArtifacts, stage, selectedRunId);
      if (!fs.existsSync(dir)) continue;
      const files = fs
        .readdirSync(dir, { withFileTypes: true })
        .filter((f) => f.isFile())
        .map((f) => f.name)
        .sort();
      const previewFile =
        files.find((f) => f.endsWith(".md")) ||
        files.find((f) => f.endsWith(".txt")) ||
        files.find((f) => f.endsWith(".json")) ||
        files.find((f) => f.endsWith(".yaml"));
      const preview = previewFile
        ? readFileSafe(path.join(dir, previewFile)).slice(0, 8000)
        : "";

      const view: StageView = { files, preview };
      if (stage === "stage2b_cluster_interpretation") {
        view.interpretations = loadStage2bInterpretations(
          projectRoot,
          selectedRunId,
        );
      }
      stages[stage] = view;
    }
  }

  const llmRunDir = path.join(llmArtifactsRoot, selectedRunId || "");
  if (selectedRunId && fs.existsSync(llmRunDir)) {
    const manifest = readFileSafe(path.join(llmRunDir, "manifest.json"));
    const interpretations = loadStage2bInterpretations(projectRoot, selectedRunId);
    const hasClusters = fs.existsSync(path.join(llmRunDir, "clusters"));
    if (hasClusters || manifest || interpretations.length > 0) {
      stages.llm_artifacts = {
        files: hasClusters
          ? fs.readdirSync(path.join(llmRunDir, "clusters"))
          : [],
        preview: manifest.slice(0, 4000),
        interpretations,
      };
    }
  }

  return NextResponse.json({
    root: pipelineArtifacts,
    llmArtifactsRoot,
    runs,
    clusterRuns,
    captureRuns,
    hasBev,
    defaultRunId,
    selectedRunId,
    stages,
  });
}
