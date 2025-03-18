import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { Box, Card, CardContent, Stack, Typography } from "@mui/material";
import Tooltip from "@mui/material/Tooltip";
import Radar from "./Radar";
import { useCallback, useMemo } from "react";
import { sessionSlice } from "src/redux/slices/session";
import { ClusteringResult } from "src/api/services/Clustering";

export default function TrajectoryAnalysisClusteringResponse() {
  const dispatch = useAppDispatch();

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusteringResult = useAppSelector((state) => {
    return state.session.selectedTrajectoryAnalysisClusteringResult;
  });
  const clusterInfos = useAppSelector((state) => {
    return state.session.trajectoryAnalysisClusterInfos;
  });

  const lowerTheBetterScores = new Set(["daviesBouldinScore", "sDbwScore"]);

  const results = useMemo(() => {
    if (trajectoryAnalysis === null) {
      return null;
    }
    return trajectoryAnalysis.clustering.results;
  }, [trajectoryAnalysis]);

  const normalizeClusterScores = useCallback(
    (results: ClusteringResult[] | null) => {
      const bounds: { [scoreName: string]: [number, number] } = {};
      for (const result of results ?? []) {
        if (result == null) {
          continue;
        }
        for (const [key, value] of Object.entries(result.scores)) {
          if (key.includes("gap")) {
            continue;
          }
          const scoreValue = value as number;

          if (!(key in bounds)) {
            bounds[key] = [scoreValue, scoreValue];
          }
          bounds[key][0] = Math.min(bounds[key][0], scoreValue);
          bounds[key][1] = Math.max(bounds[key][1], scoreValue);
        }
      }
      const returnValue: { [scoreName: string]: number }[] = [];
      for (const result of results ?? []) {
        if (result == null) {
          continue;
        }
        const normalizedScores: { [scoreName: string]: number } = {};
        for (const [key, value] of Object.entries(result.scores)) {
          if (key.includes("gap")) {
            continue;
          }
          const scoreValue = value as number;
          if (lowerTheBetterScores.has(key)) {
            // scores that lower the better
            normalizedScores[key] =
              (bounds[key][1] - scoreValue) / (bounds[key][1] - bounds[key][0]);
          } else {
            normalizedScores[key] =
              (scoreValue - bounds[key][0]) / (bounds[key][1] - bounds[key][0]);
          }
        }
        returnValue.push(normalizedScores);
      }
      return returnValue;
    },
    [trajectoryAnalysis],
  );

  const normalizedClusterScores = normalizeClusterScores(results);

  const mean = (arr: number[]) =>
    arr.reduce((acc, val) => acc + val, 0) / arr.length || 0;

  const sortIndices = useCallback(
    (normalizedClusterScores: { [scoreName: string]: number }[] | null) => {
      if (!normalizedClusterScores) {
        return null;
      }
      return Array.from(
        normalizedClusterScores ?? [],
        (_value, index) => index,
      ).sort((indexA, indexB) => {
        const maxA = Math.max(
          ...Object.values(normalizedClusterScores[indexA]),
        );
        const avgA = mean(Object.values(normalizedClusterScores[indexA]));
        const maxB = Math.max(
          ...Object.values(normalizedClusterScores[indexB]),
        );
        const avgB = mean(Object.values(normalizedClusterScores[indexB]));
        return 0.5 * maxB + 0.5 * avgB - (0.5 * maxA + 0.5 * avgA);
      });
      // return Array.from(
      //   normalizedClusterScores ?? [],
      //   (_value, index) => index,
      // );
    },
    [],
  );

  const sortedIndices = sortIndices(normalizedClusterScores);

  // useEffect(() => {
  //   if (sortedIndices && sortedIndices.length > 0) {
  //     dispatch(
  //       sessionSlice.actions.setSelectedClusteringResultIndex(sortedIndices[0]),
  //     );
  //   }
  // }, [selectedCluster]);

  if (trajectoryAnalysis === null || normalizedClusterScores === null) {
    return <Typography>Loading...</Typography>;
  }
  if (trajectoryAnalysis.clustering.results.length === 0) {
    return <Typography>Empty</Typography>;
  }

  // console.log(
  //   clusteringResponse?.criticalStateClustering?.results.find(
  //     (arg) => arg != null,
  //   ),
  // );
  const scoreNames = Object.keys(
    results?.find((arg) => arg != null)?.scores ?? {},
  ).filter((key) => !key.includes("gap"));

  return (
    <Card elevation={0} sx={{ width: "100%", height: "100%" }}>
      <CardContent sx={{ height: "100%" }}>
        <Stack rowGap={1} sx={{ overflowY: "scroll", height: "100%" }}>
          {sortedIndices?.map((index) => {
            // const result = clusteringResponse.results[index];
            if (!results) {
              return null;
            }
            const result = results[index];
            if (!result) {
              return null;
            }
            return (
              <Stack
                key={`${result.task.method}_${result.task.nClusters}_trajectoryAnalysis`}
                onClick={() => {
                  dispatch(
                    sessionSlice.actions.setSelectedTrajectoryAnalysisClusteringResult(
                      results[index] ?? null,
                    ),
                  );
                  dispatch(
                    sessionSlice.actions.setSelectedTrajectoryAnalysisClusterInfo(
                      clusterInfos && index < clusterInfos.length
                        ? clusterInfos[index]
                        : null,
                    ),
                  );
                }}
                direction="row"
                sx={{
                  padding: "10px",
                  width: "100%",
                  height: "60px",
                  transition: "all 0.3s",
                  borderStyle: "solid",
                  borderWidth: "1px",
                  borderRadius: "7px",
                  borderColor:
                    results[index] === clusteringResult
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
                      {trajectoryAnalysis.request.tasks[index].nClusters <
                      2 ? null : (
                        <Typography>
                          {`nClusters: ${trajectoryAnalysis.request.tasks[index].nClusters}`}
                        </Typography>
                      )}
                    </Box>
                  }
                >
                  <Typography
                    sx={{
                      alignSelf: "center",
                      mr: 2,
                      fontWeight: "bold",
                      textAlign: "center",
                      width: "3ch",
                    }}
                  >
                    {index + 1}
                  </Typography>
                </Tooltip>
                <Stack direction="row" sx={{ flex: 1 }}>
                  {Object.entries(
                    clusterInfos ? (clusterInfos[index] ?? {}) : {},
                  ).map(([label, item]) => (
                    <Tooltip
                      key={item.color}
                      sx={{
                        height: "100%",
                        flex: item.count,
                      }}
                      followCursor
                      title={
                        <>
                          <Typography fontWeight="bold">{`Cluster ${label}`}</Typography>
                          <Typography>
                            {`counts: ${item.count}`}
                            <br />
                          </Typography>
                        </>
                      }
                    >
                      <div
                        key={index}
                        style={{
                          flex: item.count,
                          height: "100%",
                          backgroundColor: item.color,
                        }}
                      />
                    </Tooltip>
                  ))}
                </Stack>
                <Tooltip
                  followCursor
                  title={
                    <>
                      {scoreNames.map((scoreName) => (
                        <Box component="div" key={scoreName}>
                          <Typography fontWeight="bold">{scoreName}</Typography>
                          <Typography>
                            {`normalized: ${normalizedClusterScores[index][
                              scoreName
                            ].toFixed(2)}`}
                          </Typography>
                          <Typography>
                            {`original: ${result.scores[scoreName]}`}
                          </Typography>
                          <Typography fontSize={12}>
                            {lowerTheBetterScores.has(scoreName)
                              ? "the lower the better"
                              : "the higher the better"}
                            <br />
                            <br />
                          </Typography>
                        </Box>
                      ))}
                    </>
                  }
                >
                  <div>
                    <Radar
                      data={scoreNames.map(
                        (scoreName) =>
                          normalizedClusterScores[index][scoreName],
                      )}
                    />
                  </div>
                </Tooltip>
              </Stack>
            );
          })}
        </Stack>
      </CardContent>
    </Card>
  );
}
