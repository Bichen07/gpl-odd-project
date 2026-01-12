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
  CircularProgress,
  MenuItem,
  Select,
  Skeleton,
  Stack,
  Typography,
} from "@mui/material";
import Tooltip from "@mui/material/Tooltip";
import { useCallback, useEffect, useMemo, useState } from "react";
import {
  ClusteringResult,
  TrialClusterItem,
} from "@/app/_shared/graphql/queries/clustering";
import { batchSlice, ClusterInfo } from "../../../../../redux/slices/batch";
import _ from "lodash";
import { getClusterInfos } from "@/app/_shared/utils";
import { interactionSlice } from "../../../../../redux/slices/interaction";
import { ExpandMore } from "@mui/icons-material";

export default function PerEgoSelection({
  egoName = "ITRI",
}: {
  egoName?: string;
}) {
  const dispatch = useAppDispatch();

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
  const [clusterCounts, setClusterCounts] = useState(1);

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
        }
        if (foundDuplicated) {
          break;
        }
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
  }, [results, duplicatedFilterRatio]);

  useEffect(() => {
    if (!Object.keys(clusterInfos).includes(egoName)) {
      return;
    }
    console.log(clusterInfos);
    setInfos(clusterInfos[egoName][durationMode]);
  }, [clusterInfos, durationMode]);

  const sortedResults = useMemo(() => {
    if (clusterCounts == 1) {
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
        if (sortBy == null || a == null || b == null) {
          return -Infinity;
        }
        if (sortBy === "default") {
          return 0;
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
  ]);

  useEffect(() => {
    if (sortedResults.length > 0 && trajectoryAnalysis != null) {
      dispatch(
        batchSlice.actions.setSelectedClusteringResults({
          ...selectedClusteringResults,
          [egoName]: sortedResults[0],
        })
      );
      // dispatch(
      //   egoName === "ITRI"
      //     ? batchSlice.actions.setSelectedClusteringResult(sortedResults[0])
      //     : batchSlice.actions.setSelectedClusteringResult2(sortedResults[0]),
      // );
      const index = results?.findIndex((v) => v === sortedResults[0]);
      const info = infos != null && index < infos.length ? infos[index] : null;
      dispatch(
        batchSlice.actions.setSelectedClusterInfos({
          ...selectedClusterInfos,
          [egoName]: info,
        })
      );
      dispatch(
        interactionSlice.actions.record(
          "clustering_result_list" + ".select_clustering_result"
        )
      );
      // dispatch(
      //   batchSlice.actions.setFilteredTrialIds(
      //     trajectoryAnalysis.mfpca["full"].trialOrder,
      //   ),
      // );
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
                value={sortBy}
                onChange={(event) => {
                  setSortBy(event.target.value);
                }}
              >
                {[
                  "default",
                  ...Object.keys(
                    trajectoryAnalysis.mfpca["full"].clustering[0]?.scores ?? {}
                  ).filter((v) => !v.includes("davies")),
                ].map((key, index) => {
                  return (
                    <MenuItem key={key} value={key ?? ""}>
                      {key ?? "unknown"}
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
                  setClusterCounts(Number(event.target.value ?? 1));
                }}
              >
                {[-1, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((key, index) => {
                  return (
                    <MenuItem key={index} value={key}>
                      {key === -1 ? "all" : key}
                    </MenuItem>
                  );
                })}
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
                            {`${sortBy}: ${sortedResults[i].scores[
                              sortBy ?? ""
                            ].toFixed(4)}`}
                          </Typography>
                        </Stack>
                      }
                    </Box>
                  }
                >
                  <Stack
                    direction="row"
                    flexWrap="wrap"
                    sx={{ flex: 1, height: "30px" }}
                  >
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
