import {
  useAppDispatch,
  useAppSelector,
} from "@/app/batch/[id]/_tabs/explore/redux/hooks";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  CircularProgress,
  MenuItem,
  Select,
  Skeleton,
  Stack,
  Typography,
} from "@mui/material";
import Tooltip from "@mui/material/Tooltip";
import { useParams, useRouter } from "next/navigation";
import { useCallback, useEffect, useMemo, useState } from "react";
import {
  ClusteringResult,
  TrialClusterItem,
} from "@/app/_shared/graphql/queries/clustering";
import { batchSlice, ClusterInfo, ClusterAnalysisContext } from "../../../../../redux/slices/batch";
import _ from "lodash";
import { getClusterInfos } from "@/app/_shared/utils";
import { interactionSlice } from "../../../../../redux/slices/interaction";
import { ExpandMore, CheckCircle, Cancel } from "@mui/icons-material";
import { clusteringMatchesManifestMedoids } from "@/app/_shared/utils/clusterAnalysisMatch";

const SORT_LABELS: Record<string, string> = {
  default: "Default (task order)",
  silhouetteScore: "Silhouette",
  calinskiHarabazScore: "Calinski–Harabasz",
  relativeValidity: "Relative validity",
  compositeScore: "Composite Score ★",
};

interface CompositeScoreEntry {
  final_score: number;
  rule_score: number;
  llm_score: number | null;
  rank: number;
  has_llm_eval: boolean;
  folder: string;
}

interface AnalysisStatusEntry {
  has_analysis: boolean;
  medoids: Record<string, string>;
  interpretations: Record<string, { cluster_label?: string; ego_perspective_summary?: unknown }>;
}

function clusterCountFromInfo(info: ClusterInfo | undefined): number {
  if (!info) {
    return 0;
  }
  const keys = Object.keys(info);
  return "-1" in info ? keys.length - 1 : keys.length;
}

function formatSortTooltip(
  sortBy: string | null,
  scores: ClusteringResult["scores"] | undefined
): string {
  if (!sortBy || sortBy === "default") {
    return "Pipeline order (HDBSCAN task index)";
  }
  const value = scores?.[sortBy];
  if (value == null || Number.isNaN(Number(value))) {
    return `${SORT_LABELS[sortBy] ?? sortBy}: n/a`;
  }
  return `${SORT_LABELS[sortBy] ?? sortBy}: ${Number(value).toFixed(4)}`;
}

export default function PerEgoSelection({
  egoName = "ITRI",
}: {
  egoName?: string;
}) {
  const dispatch = useAppDispatch();
  const router = useRouter();
  const routeParams = useParams();

  const [editing, setEditing] = useState<{
    [label: string]: Set<string>;
  } | null>(null);
  const [loading, setLoading] = useState(false);

  const [results, setResults] = useState<ClusteringResult[]>([]);
  const [infos, setInfos] = useState<ClusterInfo[]>([]);

  const trajectoryAnalysis = useAppSelector((state) => {
    if (state.batch.trajectoryAnalysis == null) {
      return null;
    }
    return state.batch.trajectoryAnalysis[egoName];
  });
  const durationMode = useAppSelector((state) => state.batch.durationMode);
  const mfpca = useMemo(() => {
    return trajectoryAnalysis?.mfpca[durationMode];
  }, [trajectoryAnalysis, durationMode]);
  const clusteringResult = useAppSelector((state) =>
    state.batch.selectedClusteringResults != null &&
    egoName in state.batch.selectedClusteringResults
      ? state.batch.selectedClusteringResults[egoName]
      : null
  );

  const selectedClusteringResults = useAppSelector((state) => {
    return state.batch.selectedClusteringResults;
  });
  const selectedClusterInfos = useAppSelector((state) => {
    return state.batch.selectedClusterInfos;
  });
  const clusterAnalysisByEgo = useAppSelector(
    (state) => state.batch.clusterAnalysisByEgo,
  );

  const clusterInfos = useAppSelector((state) => {
    return state.batch.clusterInfos;
  });
  const selectedTrialIds = useAppSelector((state) => {
    return state.batch.selectedTrialIds;
  });
  const [duplicatedFilterRatio, setDuplicatedFilterRatio] =
    useState<number>(0.005);
  const [noiseFilterRatio, setNoiseFilterRatio] = useState<number>(0.05);
  const [sortBy, setSortBy] = useState<string | null>("silhouetteScore");
  const [uniqueResultIndices, setUniqueResultIndices] = useState(
    new Set<number>()
  );
  const [noiseRatioMapping, setNoiseRatioMapping] = useState<{
    [index: number]: number;
  }>({});
  const [clusterCounts, setClusterCounts] = useState(-1);

  // Composite quality scores from /api/cluster-evaluate
  const [compositeScores, setCompositeScores] = useState<
    Record<string, CompositeScoreEntry>
  >({});

  // LLM analysis availability + medoids from /api/cluster-analysis-status
  const [analysisStatus, setAnalysisStatus] = useState<
    Record<string, AnalysisStatusEntry>
  >({});

  const batchId = Array.isArray(routeParams?.id)
    ? routeParams?.id[0]
    : routeParams?.id;

  useEffect(() => {
    if (!batchId) return;
    fetch(`/api/cluster-evaluate?batchId=${batchId}`)
      .then((r) => r.json())
      .then((data) => {
        const map: Record<string, CompositeScoreEntry> = {};
        for (const c of data.configs ?? []) {
          map[c.folder] = c as CompositeScoreEntry;
        }
        setCompositeScores(map);
      })
      .catch(() => {/* best-effort */});
    fetch(`/api/cluster-analysis-status?batchId=${batchId}`)
      .then((r) => r.json())
      .then((data) => {
        setAnalysisStatus((data.folders ?? {}) as Record<string, AnalysisStatusEntry>);
      })
      .catch(() => {/* best-effort */});
  }, [batchId]);

  // Build folder key for a clustering result: "<k>_cluster_s=<sil>"
  const resultFolderKey = useCallback(
    (result: ClusteringResult, resultIndex: number): string => {
      const sil = (result.scores as Record<string, number> | undefined)
        ?.silhouetteScore;
      const k =
        infos[resultIndex] != null
          ? clusterCountFromInfo(infos[resultIndex])
          : 0;
      if (k < 1 || sil == null) return "";
      return `${k}_cluster_s=${sil.toFixed(4)}`;
    },
    [infos]
  );

  const buildAnalysisContext = useCallback(
    (result: ClusteringResult, index: number): ClusterAnalysisContext | null => {
      const key = resultFolderKey(result, index);
      if (!key || !analysisStatus[key]) return null;
      const st = analysisStatus[key];
      if (!st.has_analysis) return null;
      if (!clusteringMatchesManifestMedoids(result, st.medoids)) return null;
      return {
        folder: key,
        hasAnalysis: true,
        medoids: st.medoids,
        interpretations: st.interpretations,
      };
    },
    [analysisStatus, resultFolderKey],
  );

  const resultHasVerifiedAnalysis = useCallback(
    (result: ClusteringResult, index: number): boolean => {
      const key = resultFolderKey(result, index);
      if (!key || !analysisStatus[key]?.has_analysis) return false;
      return clusteringMatchesManifestMedoids(result, analysisStatus[key].medoids);
    },
    [analysisStatus, resultFolderKey],
  );

  const currentAnalysis = useMemo(() => {
    if (clusteringResult == null || results == null) return null;
    const index = results.findIndex((v) => v === clusteringResult);
    if (index < 0) return null;
    return buildAnalysisContext(clusteringResult, index);
  }, [clusteringResult, results, buildAnalysisContext]);

  const selectMedoidTrial = useCallback(
    (trialId: string, clusterLabel: string) => {
      const current = new Set(selectedTrialIds.value);
      if (current.has(trialId)) {
        current.delete(trialId);
      } else {
        current.add(trialId);
      }
      const next = [...current];
      dispatch(batchSlice.actions.setSelectedTrialId(next[0] ?? null));
      dispatch(
        batchSlice.actions.setSelectedTrialIds({
          by: next.length > 0 ? "medoid" : "",
          value: next,
        }),
      );
      dispatch(
        interactionSlice.actions.record("clustering_result_list.select_medoid"),
      );
    },
    [dispatch, selectedTrialIds],
  );

  const selectAllMedoids = useCallback(() => {
    if (!currentAnalysis?.medoids) return;
    const ids = Object.values(currentAnalysis.medoids);
    dispatch(batchSlice.actions.setSelectedTrialId(ids[0] ?? null));
    dispatch(
      batchSlice.actions.setSelectedTrialIds({
        by: "medoid_all",
        value: ids,
      }),
    );
    dispatch(
      interactionSlice.actions.record("clustering_result_list.select_all_medoids"),
    );
  }, [currentAnalysis, dispatch]);

  const selectedMedoidSet = useMemo(
    () => new Set(selectedTrialIds.value),
    [selectedTrialIds],
  );

  const scoreKeys = useMemo(() => {
    const fromScores = Object.keys(
      trajectoryAnalysis?.mfpca["full"]?.clustering[0]?.scores ?? {}
    ).filter((v) => !v.includes("davies"));
    const base = ["default", ...fromScores];
    if (Object.keys(compositeScores).length > 0 && !base.includes("compositeScore")) {
      base.push("compositeScore");
    }
    return base;
  }, [trajectoryAnalysis, compositeScores]);

  const availableClusterCounts = useMemo(() => {
    const fromApi = mfpca?.availableClusterCounts;
    if (fromApi != null && fromApi.length > 0) {
      return [-1, ...fromApi];
    }
    const counts = new Set<number>();
    for (let index = 0; index < (results?.length ?? 0); index++) {
      const k = clusterCountFromInfo(infos[index]);
      if (k >= 1) {
        counts.add(k);
      }
    }
    return [-1, ...Array.from(counts).sort((a, b) => a - b)];
  }, [mfpca?.availableClusterCounts, results, infos]);

  useEffect(() => {
    if (!availableClusterCounts.includes(clusterCounts)) {
      setClusterCounts(availableClusterCounts[0] ?? -1);
    }
  }, [availableClusterCounts, clusterCounts]);

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    setResults(
      trajectoryAnalysis.mfpca[durationMode].clustering.filter((v) => v != null)
    );
  }, [trajectoryAnalysis, durationMode]);

  useEffect(() => {
    if (trajectoryAnalysis == null) {
      return;
    }
    setLoading(true);

    const newNoiseRatioMapping: { [index: number]: number } = {};
    const uniqueMappings: {
      [index: number]: { [label: string]: Set<string> };
    } = {};
    for (const [i, result] of results.entries()) {
      if (result == null) {
        continue;
      }

      newNoiseRatioMapping[i] = 1;

      const mapping: { [label: string]: Set<string> } = {};
      for (const [trialId, item] of Object.entries(result.data)) {
        if (!(item.label in mapping)) {
          mapping[item.label] = new Set<string>();
        }
        mapping[item.label].add(trialId);
      }

      newNoiseRatioMapping[i] =
        "-1" in mapping
          ? mapping["-1"].size /
            trajectoryAnalysis.mfpca[durationMode].trialOrder.length
          : 0;

      let foundDuplicated = false;
      let duplicateOf: number | null = null;
      for (const [uniqueIndex, unique] of Object.entries(uniqueMappings)) {
        let differentCounts = 0;
        const visited = new Set<string>();
        for (const [label, set] of Object.entries(unique)) {
          let minSetDifferenceCounts = Infinity;
          let minSetDifferenceLabel = null;
          for (const [label2, set2] of Object.entries(mapping)) {
            if (visited.has(label2)) {
              continue;
            }
            let setDifferenceCounts = set.difference(set2).size;
            if (setDifferenceCounts < minSetDifferenceCounts) {
              minSetDifferenceCounts = setDifferenceCounts;
              minSetDifferenceLabel = label2;
            }
          }
          if (minSetDifferenceLabel) {
            visited.add(minSetDifferenceLabel);
          }
          differentCounts += minSetDifferenceCounts;
        }
        const differentRatio =
          differentCounts /
          trajectoryAnalysis.mfpca[durationMode].trialOrder.length;
        if (differentRatio < duplicatedFilterRatio) {
          foundDuplicated = true;
          duplicateOf = Number(uniqueIndex);
        }
        if (foundDuplicated) {
          break;
        }
      }
      if (foundDuplicated && duplicateOf != null) {
        const curKey = resultFolderKey(result, i);
        const dupKey = resultFolderKey(results[duplicateOf], duplicateOf);
        const curHas = curKey
          ? resultHasVerifiedAnalysis(result, i)
          : false;
        const dupHas = dupKey
          ? resultHasVerifiedAnalysis(results[duplicateOf], duplicateOf)
          : false;
        if (curHas && !dupHas) {
          delete uniqueMappings[duplicateOf];
          uniqueMappings[i] = mapping;
        }
        continue;
      }
      if (foundDuplicated) {
        continue;
      }

      uniqueMappings[i] = mapping;
    }
    setNoiseRatioMapping(newNoiseRatioMapping);
    setUniqueResultIndices(
      new Set(Object.keys(uniqueMappings).map((k) => Number(k)))
    );

    setLoading(false);
  }, [results, duplicatedFilterRatio, analysisStatus, resultFolderKey, resultHasVerifiedAnalysis, trajectoryAnalysis, durationMode]);

  useEffect(() => {
    if (!Object.keys(clusterInfos).includes(egoName)) {
      return;
    }
    console.log(clusterInfos);
    setInfos(clusterInfos[egoName][durationMode]);
  }, [clusterInfos, durationMode]);

  const sortedResults = useMemo(() => {
    if (clusterCounts === 1) {
      return [];
    }
    const temp = [...(results ?? [])]
      .filter((result) => {
        const index = results?.findIndex((v) => v === result);

        const noiseRatio = noiseRatioMapping[index];
        if (
          index == null ||
          result == null ||
          results == null ||
          !uniqueResultIndices.has(index) ||
          noiseRatio > noiseFilterRatio ||
          (clusterCounts !== -1 &&
            clusterCounts !== 1 &&
            Object.keys(infos[index]).length !==
              ("-1" in infos[index] ? clusterCounts + 1 : clusterCounts))
        ) {
          return false;
        }
        return true;
      })
      .sort((a, b) => {
        const idxA = results?.findIndex((v) => v === a) ?? -1;
        const idxB = results?.findIndex((v) => v === b) ?? -1;
        const keyA = idxA >= 0 ? resultFolderKey(a, idxA) : "";
        const keyB = idxB >= 0 ? resultFolderKey(b, idxB) : "";
        const analA = idxA >= 0 && resultHasVerifiedAnalysis(a, idxA) ? 1 : 0;
        const analB = idxB >= 0 && resultHasVerifiedAnalysis(b, idxB) ? 1 : 0;
        if (analB !== analA) return analB - analA;

        if (sortBy == null || a == null || b == null) {
          return -Infinity;
        }
        if (sortBy === "default") {
          return 0;
        }
        if (sortBy === "compositeScore") {
          const scoreA = compositeScores[keyA]?.final_score ?? -Infinity;
          const scoreB = compositeScores[keyB]?.final_score ?? -Infinity;
          return scoreB - scoreA;
        }
        let aV =
          a.scores == null || a.scores[sortBy] == null
            ? -Infinity
            : a.scores[sortBy];
        let bV =
          b.scores == null || b.scores[sortBy] == null
            ? -Infinity
            : b.scores[sortBy];
        return bV - aV;
      });

    return temp;
  }, [
    sortBy,
    results,
    uniqueResultIndices,
    noiseRatioMapping,
    clusterCounts,
    duplicatedFilterRatio,
    noiseFilterRatio,
    infos,
    compositeScores,
    resultFolderKey,
    analysisStatus,
    resultHasVerifiedAnalysis,
  ]);

  useEffect(() => {
    if (sortedResults.length > 0 && trajectoryAnalysis != null) {
      dispatch(
        batchSlice.actions.setSelectedClusteringResults({
          ...selectedClusteringResults,
          [egoName]: sortedResults[0],
        })
      );
      const index = results?.findIndex((v) => v === sortedResults[0]);
      const info = infos != null && index != null && index < infos.length ? infos[index] : null;
      dispatch(
        batchSlice.actions.setSelectedClusterInfos({
          ...selectedClusterInfos,
          [egoName]: info,
        })
      );
      const analysisCtx =
        index != null && index >= 0 && sortedResults[0]
          ? buildAnalysisContext(sortedResults[0], index)
          : null;
      dispatch(
        batchSlice.actions.setClusterAnalysisByEgo({
          ...(clusterAnalysisByEgo ?? {}),
          [egoName]: analysisCtx,
        }),
      );
      dispatch(
        interactionSlice.actions.record(
          "clustering_result_list" + ".select_clustering_result"
        )
      );
    } else {
      dispatch(
        batchSlice.actions.setSelectedClusteringResults({
          ...selectedClusteringResults,
          [egoName]: null,
        })
      );
      dispatch(
        batchSlice.actions.setSelectedClusterInfos({
          ...selectedClusterInfos,
          [egoName]: null,
        })
      );
      dispatch(
        batchSlice.actions.setClusterAnalysisByEgo({
          ...(clusterAnalysisByEgo ?? {}),
          [egoName]: null,
        }),
      );
    }
  }, [sortedResults]);

  useEffect(() => {
    const newEditing: typeof editing = {};
    for (const [trialId, item] of Object.entries(
      clusteringResult?.data ?? {}
    )) {
      if (!(item.label in newEditing)) {
        newEditing[item.label] = new Set<string>();
      }
      newEditing[item.label].add(trialId);
    }
    setEditing(newEditing);
  }, [clusteringResult]);

  const handleSelectAndAnalyze = useCallback(() => {
    if (clusteringResult == null) return;
    const sil = (clusteringResult.scores as { silhouetteScore?: number })
      ?.silhouetteScore;
    const k = Object.keys(clusteringResult.trialOrder ?? {}).filter(
      (label) => Number(label) >= 0
    ).length;
    const batchId = Array.isArray(routeParams?.id)
      ? routeParams?.id[0]
      : routeParams?.id;
    const sParam = sil != null ? sil.toFixed(4) : "";
    router.push(
      `/batch/${batchId}/analyze?ego=${encodeURIComponent(
        egoName
      )}&k=${k}&s=${sParam}`
    );
  }, [clusteringResult, routeParams, router, egoName]);

  if (trajectoryAnalysis == null) {
    return <Typography></Typography>;
  }
  if (trajectoryAnalysis.mfpca[durationMode].clustering.length === 0) {
    return <Typography>Empty</Typography>;
  }

  return (
    <Stack
      sx={{
        width: "100%",
        height: "100%",
        overflowY: "scroll",
        scrollbarWidth: 1,
        p: 1,
      }}
    >
      <Tooltip
        title={
          clusteringResult == null
            ? "Select a clustering result below first"
            : "Open the LLM analysis page for the selected clustering result"
        }
      >
        <span>
          <Button
            variant="contained"
            size="small"
            fullWidth
            disabled={clusteringResult == null}
            onClick={handleSelectAndAnalyze}
            sx={{ mb: 1 }}
          >
            Select and analyze
          </Button>
        </span>
      </Tooltip>
      {currentAnalysis?.hasAnalysis && (
        <Stack gap={0.5} sx={{ mb: 1 }}>
          <Stack direction="row" alignItems="center" justifyContent="space-between">
            <Typography fontSize={12} color="text.secondary">
              Medoid trials (toggle to replay — multi-select)
            </Typography>
            <Button size="small" onClick={selectAllMedoids} sx={{ fontSize: "11px" }}>
              All
            </Button>
          </Stack>
          <Stack direction="row" flexWrap="wrap" gap={0.5}>
            {Object.entries(currentAnalysis.medoids)
              .sort(([a], [b]) => Number(a) - Number(b))
              .map(([label, trialId]) => {
                const interp = currentAnalysis.interpretations[label];
                const chipLabel = interp?.cluster_label
                  ? `C${label}: ${interp.cluster_label}`
                  : `C${label} medoid`;
                const isSelected = selectedMedoidSet.has(trialId);
                return (
                  <Button
                    key={label}
                    size="small"
                    variant={isSelected ? "contained" : "outlined"}
                    onClick={() => selectMedoidTrial(trialId, label)}
                    sx={{ fontSize: "11px", py: 0.25 }}
                  >
                    {chipLabel}
                  </Button>
                );
              })}
          </Stack>
        </Stack>
      )}
      <Accordion elevation={0} disableGutters square defaultExpanded>
        <AccordionSummary expandIcon={<ExpandMore />}>
          <Typography component="span" fontSize="14px">
            {/* Filtering */}
            Controls
          </Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Stack direction="row" columnGap={1} flexWrap="wrap">
            <Stack
              alignItems="center"
              columnGap={1}
              direction="row"
              sx={{ p: 1 }}
            >
              <Typography fontSize={14}>Sort By:</Typography>
              <Select
                sx={{ p: 0 }}
                size="small"
                value={sortBy ?? "silhouetteScore"}
                onChange={(event) => {
                  setSortBy(event.target.value);
                }}
              >
                {scoreKeys.map((key) => (
                  <MenuItem key={key} value={key}>
                    {SORT_LABELS[key] ?? key}
                  </MenuItem>
                ))}
              </Select>
            </Stack>
            <Stack
              alignItems="center"
              columnGap={1}
              direction="row"
              sx={{ p: 1 }}
            >
              <Typography fontSize={14}>Noise Under:</Typography>
              <Select
                sx={{ p: 0 }}
                size="small"
                value={noiseFilterRatio}
                onChange={(event) => {
                  setNoiseFilterRatio(Number(event.target.value ?? 0));
                }}
              >
                {[
                  0, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05, 0.1, 0.15, 0.2, 0.25,
                  0.3,
                ].map((key, index) => {
                  return (
                    <MenuItem key={index} value={key}>
                      {`${
                        key == 0.005
                          ? (key * 100).toFixed(1)
                          : (key * 100).toFixed(0)
                      }%`}
                    </MenuItem>
                  );
                })}
              </Select>
            </Stack>
            <Stack
              alignItems="center"
              columnGap={1}
              direction="row"
              sx={{ p: 1 }}
            >
              <Typography fontSize={14}>Unique Over:</Typography>
              <Select
                sx={{ p: 0 }}
                size="small"
                value={duplicatedFilterRatio}
                onChange={(event) => {
                  setDuplicatedFilterRatio(Number(event.target.value ?? 0));
                }}
              >
                {[
                  0, 0.005, 0.01, 0.02, 0.03, 0.04, 0.05, 0.1, 0.15, 0.2, 0.25,
                  0.3,
                ].map((key, index) => {
                  return (
                    <MenuItem key={index} value={key}>
                      {`${
                        key == 0.005
                          ? (key * 100).toFixed(1)
                          : (key * 100).toFixed(0)
                      }%`}
                    </MenuItem>
                  );
                })}
              </Select>
            </Stack>
            <Stack
              alignItems="center"
              columnGap={1}
              direction="row"
              sx={{ p: 1 }}
            >
              <Typography fontSize={14}>Cluster Counts:</Typography>
              <Select
                sx={{ p: 0 }}
                size="small"
                value={clusterCounts}
                onChange={(event) => {
                  setClusterCounts(Number(event.target.value ?? -1));
                }}
              >
                {availableClusterCounts.map((key) => (
                  <MenuItem key={key} value={key}>
                    {key === -1 ? "all" : key}
                  </MenuItem>
                ))}
              </Select>
            </Stack>
          </Stack>
        </AccordionDetails>
      </Accordion>

      <Stack>
        <Accordion defaultExpanded={false} sx={{ p: 0 }}>
          <AccordionSummary>Manual Edit</AccordionSummary>
          <AccordionDetails>
            <Stack>
              <Stack>
                {Object.keys(editing ?? {})
                  .sort((a, b) => Number(a) - Number(b))
                  .map((key) => {
                    if (editing == null) {
                      return;
                    }
                    return (
                      <Stack direction="row">
                        <Typography>{key}</Typography>
                        <Typography>{`: ${editing[key].size}`}</Typography>
                        <Button
                          onClick={() => {
                            console.log(selectedTrialIds.value.length);
                            setEditing((prev) => {
                              const newEditing = { ...prev };
                              if (!("-1" in newEditing)) {
                                newEditing["-1"] = new Set<string>();
                              }
                              newEditing[key] = new Set<string>(
                                selectedTrialIds.value ?? []
                              );
                              for (const otherKey of Object.keys(prev ?? {})) {
                                if (key === otherKey) {
                                  continue;
                                }
                                for (const trialId of newEditing[key]) {
                                  newEditing[otherKey].delete(trialId);
                                }
                              }
                              const trials = [];
                              for (const value of Object.values(prev ?? {})) {
                                trials.push(...value);
                              }
                              for (const trialId of trials) {
                                let found = false;
                                // console.log(trialId);
                                for (const [key, value] of Object.entries(
                                  newEditing
                                )) {
                                  if (key === "-1") {
                                    continue;
                                  }
                                  // console.log(value);
                                  found = value.has(String(trialId));
                                  if (found) {
                                    break;
                                  }
                                }
                                if (!found) {
                                  newEditing["-1"].add(trialId);
                                }
                              }
                              console.log(newEditing);
                              return newEditing;
                            });
                          }}
                        >
                          Use Selection
                        </Button>
                      </Stack>
                    );
                  })}
              </Stack>
              <Button
                onClick={() => {
                  if (clusteringResult == null) {
                    return;
                  }
                  const newClusteringResult = _.cloneDeep(clusteringResult);
                  newClusteringResult.data = {};
                  for (const [label, item] of Object.entries(editing ?? {})) {
                    for (const trialId of item) {
                      newClusteringResult.data[trialId] = {
                        trialId,
                        label,
                      };
                    }
                  }
                  setResults((prev) => {
                    const updated = [newClusteringResult, ...prev];
                    console.log(updated);
                    return updated;
                  });
                  setInfos((prev) => {
                    const index = results?.findIndex(
                      (v) => v === clusteringResult
                    );
                    const updated = [infos[index], ...prev];
                    console.log(updated);
                    return updated;
                  });
                  // newClusteringResult.data =
                  dispatch(
                    batchSlice.actions.setSelectedClusteringResult(
                      newClusteringResult
                    )
                  );
                }}
              >
                Add
              </Button>
            </Stack>
          </AccordionDetails>
        </Accordion>
      </Stack>
      {loading ? (
        <Stack sx={{ width: "100%", height: "100%", position: "relative" }}>
          <Skeleton
            variant="rectangular"
            sx={{ width: "100%", height: "100%" }}
            animation="wave"
          />
          <CircularProgress
            sx={{
              position: "absolute",
              top: "50%",
              left: "50%",
              color: "text.disabled",
            }}
          />
        </Stack>
      ) : (
        <Stack rowGap={0.5} sx={{ height: "100%", mb: 2 }}>
          {sortedResults.map((result, i) => {
            const index = results?.findIndex((v) => v === result);

            // const noiseRatio = noiseRatioMapping[index];

            if (
              index == null ||
              result == null ||
              results == null ||
              // !uniqueResultIndices.has(index) ||
              // noiseRatio > noiseFilterRatio ||
              (clusterCounts !== -1 &&
                Object.keys(infos[index]).length !==
                  ("-1" in infos[index] ? clusterCounts + 1 : clusterCounts))
            ) {
              return null;
            }

            const folderKey = resultFolderKey(result, index);
            const hasAnalysis = resultHasVerifiedAnalysis(result, index);

            return (
              <Stack
                key={i}
                onClick={() => {
                  console.log(result);
                  dispatch(
                    batchSlice.actions.setSelectedClusteringResults({
                      ...selectedClusteringResults,
                      [egoName]: result ?? null,
                    })
                  );
                  dispatch(
                    batchSlice.actions.setSelectedClusterInfos({
                      ...selectedClusterInfos,
                      [egoName]:
                        infos != null && index < infos.length
                          ? infos[index]
                          : null,
                    })
                  );
                  dispatch(
                    batchSlice.actions.setClusterAnalysisByEgo({
                      ...(clusterAnalysisByEgo ?? {}),
                      [egoName]: buildAnalysisContext(result, index),
                    }),
                  );
                  dispatch(
                    interactionSlice.actions.record(
                      "clustering_result_list" + ".select_clustering_result"
                    )
                  );
                }}
                direction="row"
                flexWrap="wrap"
                sx={{
                  padding: "10px",
                  transition: "all 0.3s",
                  borderStyle: "solid",
                  borderWidth: "1px",
                  borderRadius: "7px",
                  borderColor:
                    index != null && results[index] === clusteringResult
                      ? "text.disabled"
                      : "transparent",
                  ":hover": {
                    cursor: "pointer",
                    backgroundColor: "background.paper",
                    boxShadow: "inset 0 0 0 10em rgba(255, 255, 255, 0.1)",
                    borderRadius: "7px",
                    transition: "all 0.3s",
                  },
                }}
              >
                <Tooltip
                  key={index}
                  sx={{
                    height: "100%",
                    ".MuiTooltip-tooltip": {
                      width: "100%",
                      maxWidth: "none",
                      background: "red",
                    },
                  }}
                  followCursor
                  title={
                    <Box component="div">
                      <Stack direction="row" alignItems="center" spacing={0.5} sx={{ mb: 0.5 }}>
                        {hasAnalysis ? (
                          <CheckCircle sx={{ fontSize: 16, color: "success.light" }} />
                        ) : (
                          <Cancel sx={{ fontSize: 16, color: "text.disabled" }} />
                        )}
                        <Typography fontWeight="bold">
                          {`Analysis: ${hasAnalysis ? "yes" : "no"}`}
                        </Typography>
                      </Stack>
                      <Typography fontWeight="bold">
                        {`${trajectoryAnalysis.request.tasks[index].method}`}
                      </Typography>
                      {(trajectoryAnalysis.request.tasks[index].nClusters ??
                        0) < 2 ? null : (
                        <Typography>
                          {`nClusters: ${trajectoryAnalysis.request.tasks[index].nClusters}`}
                        </Typography>
                      )}
                      {(trajectoryAnalysis.request.tasks[index]
                        .minClusterSize ?? -2) < -1 ? null : (
                        <Typography>
                          {`minClusterSize: ${trajectoryAnalysis.request.tasks[index].minClusterSize}`}
                        </Typography>
                      )}
                      {(trajectoryAnalysis.request.tasks[index].minSamples ??
                        -2) < -1 ? null : (
                        <Typography>
                          {`minSamples: ${trajectoryAnalysis.request.tasks[index].minSamples}`}
                        </Typography>
                      )}
                      {(trajectoryAnalysis.request.tasks[index]
                        .clusterSelectionEpsilon ?? -2) < -1 ? null : (
                        <Typography>
                          {`clusterSelectionEpsilon: ${trajectoryAnalysis.request.tasks[index].clusterSelectionEpsilon}`}
                        </Typography>
                      )}
                      {
                        <Stack sx={{ marginTop: "10px" }}>
                          <Typography>
                            {formatSortTooltip(
                              sortBy,
                              sortedResults[i]?.scores
                            )}
                          </Typography>
                        </Stack>
                      }
                    </Box>
                  }
                >
                  <Stack
                    direction="row"
                    flexWrap="wrap"
                    sx={{ flex: 1, height: "30px", position: "relative" }}
                  >
                    {hasAnalysis && (
                      <Box
                        component="div"
                        sx={{
                          position: "absolute",
                          right: 2,
                          top: -3,
                          zIndex: 2,
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                          width: 16,
                          height: 16,
                          borderRadius: "50%",
                          backgroundColor: "#fff",
                          border: "1.5px solid",
                          borderColor: "success.dark",
                          boxShadow: "0 0 2px rgba(0,0,0,0.6)",
                        }}
                      >
                        <CheckCircle
                          sx={{
                            fontSize: 12,
                            color: "success.main",
                            display: "block",
                          }}
                        />
                      </Box>
                    )}
                    {Object.entries(
                      infos != null && index < infos.length ? infos[index] : {}
                      // clusterInfos && durationMode in clusterInfos
                      //   ? clusterInfos[durationMode][index] ?? {}
                      //   : {}
                    ).map(([label, item]) => (
                      <Box
                        key={label}
                        sx={{
                          height: "100%",
                          flex: item.count,
                          backgroundColor: item.color,
                        }}
                      />
                      // <Tooltip
                      //   key={item.color}
                      //   sx={{
                      //     height: "100%",
                      //     flex: item.count,
                      //   }}
                      //   followCursor
                      //   title={
                      //     <>
                      //       <Typography fontWeight="bold">{`Cluster ${label}`}</Typography>
                      //       <Typography>
                      //         {`counts: ${item.count}`}
                      //         <br />
                      //       </Typography>
                      //     </>
                      //   }
                      // >
                      //   <div
                      //     key={index}
                      //     style={{
                      //       flex: item.count,
                      //       height: "100%",
                      //       backgroundColor: item.color,
                      //     }}
                      //   />
                      // </Tooltip>
                    ))}
                  </Stack>
                </Tooltip>
                {/* Composite score chip + rank badge */}
                {(() => {
                  const key = resultFolderKey(result, index);
                  const cs = compositeScores[key];
                  if (!cs) return null;
                  const tooltip = cs.has_llm_eval
                    ? `Rule: ${cs.rule_score?.toFixed(1)} | LLM: ${cs.llm_score?.toFixed(1)} | Final: ${cs.final_score?.toFixed(1)}`
                    : `Rule-based score: ${cs.rule_score?.toFixed(1)} (LLM eval pending)`;
                  return (
                    <Tooltip title={tooltip}>
                      <Stack direction="row" alignItems="center" gap={0.5} sx={{ ml: 0.5 }}>
                        <Chip
                          label={`${cs.final_score?.toFixed(1)} ★`}
                          size="small"
                          color={cs.has_llm_eval ? "primary" : "default"}
                          sx={{ fontSize: "11px", height: "20px" }}
                        />
                        <Chip
                          label={`#${cs.rank}`}
                          size="small"
                          variant="outlined"
                          sx={{ fontSize: "11px", height: "20px" }}
                        />
                      </Stack>
                    </Tooltip>
                  );
                })()}
                {/* <Tooltip */}
                {/*   followCursor */}
                {/*   title={ */}
                {/*     <> */}
                {/*       {scoreNames.map((scoreName) => ( */}
                {/*         <Box component="div" key={scoreName}> */}
                {/*           <Typography fontWeight="bold">{scoreName}</Typography> */}
                {/*           <Typography> */}
                {/*             {`normalized: ${normalizedClusterScores[index][ */}
                {/*               scoreName */}
                {/*             ].toFixed(2)}`} */}
                {/*           </Typography> */}
                {/*           <Typography> */}
                {/*             {`original: ${result.scores[scoreName]}`} */}
                {/*           </Typography> */}
                {/*           <Typography fontSize={12}> */}
                {/*             {lowerTheBetterScores.has(scoreName) */}
                {/*               ? "the lower the better" */}
                {/*               : "the higher the better"} */}
                {/*             <br /> */}
                {/*             <br /> */}
                {/*           </Typography> */}
                {/*         </Box> */}
                {/*       ))} */}
                {/*     </> */}
                {/*   } */}
                {/* > */}
                {/*   <div> */}
                {/*     <Radar */}
                {/*       data={scoreNames.map( */}
                {/*         (scoreName) => */}
                {/*           normalizedClusterScores[index][scoreName], */}
                {/*       )} */}
                {/*     /> */}
                {/*   </div> */}
                {/* </Tooltip> */}
              </Stack>
            );
          })}
        </Stack>
      )}
    </Stack>
  );
}
