import chroma from "chroma-js";
import { SxProps, useTheme } from "@mui/material/styles";
import { useCallback, useEffect, useMemo, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../../../../redux/hooks";
import {
  Box,
  Button,
  Checkbox,
  Chip,
  MenuItem,
  OutlinedInput,
  Select,
  SelectChangeEvent,
  Slider,
  Stack,
  Typography,
} from "@mui/material";
import { batchSlice, ClusterInfo } from "../../../../../redux/slices/batch";
import { scaleOrdinal, scaleThreshold } from "@visx/scale";
import { LegendThreshold } from "@visx/legend";
import { toTitleSpaceCase } from "@/app/_shared/utils";
import { interactionSlice } from "../../../../../redux/slices/interaction";
import { ClusteringResult } from "@/app/_shared/graphql/queries/clustering";
import { Trial } from "@/app/_shared/graphql/queries/trials";

export default function Filtering() {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const batch = useAppSelector((state) => state.batch.batch);
  const egos = useAppSelector((state) => state.batch.egos);

  const [clusterChecked, setClusterChecked] = useState<{
    [egoName: string]: Set<string>;
  }>({});
  const [plotChecked, setPlotChecked] = useState<boolean>(true);
  const [changeChecked, setChangeChecked] = useState<boolean>(false);
  const [onPassFailBoundaryChecked, setOnPassFailBoundaryChecked] =
    useState(false);
  const [onClusterBoundaryChecked, setOnClusterBoundaryChecked] =
    useState(false);
  const [loading, setLoading] = useState<boolean>(false);
  const [kNN, setKNN] = useState(25);
  const [changeThreshold, setChangeThreshold] = useState(0);

  const [passFailChecked, setPassFailChecked] = useState<Set<string>>(
    new Set(),
  );

  // const trials = useAppSelector((state) => {
  //   let result: Trial[] = [];
  //   for (const egoTrials of Object.values(state.batch.trials)) {
  //     result = [...result, ...egoTrials];
  //   }
  //   return result;
  // });
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis,
  );

  const trials: { [trialId: string]: Trial } = useMemo(() => {
    if (!trajectoryAnalysis) {
      return {};
    }
    let result = {};
    for (const egoName of Object.keys(trajectoryAnalysis)) {
      result = { ...result, ...trajectoryAnalysis[egoName].trials };
    }
    return result;
  }, [trajectoryAnalysis]);

  const clusterInfo = useAppSelector(
    (state) => state.batch.selectedClusterInfos,
  );
  const clusteringResult = useAppSelector(
    (state) => state.batch.selectedClusteringResults,
  );

  const selectedTrialIds = useAppSelector(
    (state) => state.batch.selectedTrialIds,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.batch.filteredTrialIds,
  );
  const tree = useAppSelector((state) => state.batch.tree["ITRI"]);
  const treePoints = useAppSelector((state) => state.batch.treePoints["ITRI"]);
  const boundaryMetric = useAppSelector(
    (state) => state.batch.selectedSafetyBoundaryMetric,
  );
  const selectedMetric = useAppSelector((state) => state.batch.selectedMetric);

  const nColorSegments = 100; // Number of segments
  const metricGradMagColorscale = useMemo(() => {
    const inferno = [
      "#000004",
      "#1b0c41",
      "#4a0c6b",
      "#781c6d",
      "#a52c60",
      "#cf4446",
      "#ed6925",
      "#fb9b06",
      "#f7d13d",
      "#fcffa4",
    ];
    // inferno.reverse();
    const scale = chroma.scale(inferno);
    if (selectedMetric && selectedMetric.kpi.rule === "lessThan") {
      return scale.domain([0, 1]);
    }
    return scale;
  }, [selectedMetric, trajectoryAnalysis]);
  const metricGradMagScale = useMemo(
    () =>
      scaleThreshold({
        domain: Array.from(
          { length: nColorSegments },
          (_, i) => i / nColorSegments,
        ),
        range: Array.from({ length: nColorSegments }, (_, i) =>
          metricGradMagColorscale(i / nColorSegments).hex(),
        ),
      }),
    [metricGradMagColorscale],
  );

  const passFailColorLegendScale = useMemo(() => {
    return scaleOrdinal({
      domain:
        boundaryMetric?.kpi.name === "collision" ? ["0", "1", "2"] : ["0", "1"],
      range: (boundaryMetric?.kpi.name === "collision"
        ? ["0", "1", "2"]
        : ["0", "1"]
      ).map((v) => {
        return v === "1"
          ? theme.palette.success.light
          : v === "2"
            ? theme.palette.warning.light
            : theme.palette.error.light;
      }),
    });
  }, [boundaryMetric]);

  const resetClusterChecked = useCallback(() => {
    const result: typeof clusterChecked = {};
    for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
      const newChecked = new Set<string>();
      if (clusterInfo != null) {
        for (const label of Object.keys(clusterInfo[egoName] ?? {})) {
          newChecked.add(label);
        }
      }
      result[egoName] = newChecked;
    }
    setClusterChecked(result);
  }, [clusterInfo]);

  const resetPassFailChecked = useCallback(() => {
    const newChecked = new Set<string>();
    const array =
      boundaryMetric?.kpi.name === "collision" ? ["0", "1", "2"] : ["0", "1"];
    for (const option of array) {
      newChecked.add(option);
    }
    setPassFailChecked(newChecked);
  }, [clusterInfo]);

  const reset = () => {
    dispatch(
      // batchSlice.actions.setFilteredTrialIds(trials.map((t) => String(t?.id)))
      batchSlice.actions.setFilteredTrialIds(Object.keys(trials)),
    );
    dispatch(batchSlice.actions.setFreeformTrialIds([]));
    dispatch(batchSlice.actions.setSelectedTrialIds({ by: "", value: [] }));
    dispatch(batchSlice.actions.setSelectedTrialId(null));
    resetClusterChecked();
    resetPassFailChecked();
  };

  useEffect(() => {
    reset();
  }, [trajectoryAnalysis, clusterInfo]);

  useEffect(() => {
    resetClusterChecked();
  }, [clusterInfo]);

  useEffect(() => {
    if (trajectoryAnalysis == null || loading === false) {
      setLoading(false);
      return;
    }
    setLoading(true);

    // const trialIds = (trials ?? []).map((t) => String(t?.id));
    let newFilteredTrialIds = [...Object.keys(trials)];
    if (selectedTrialIds != null && selectedTrialIds.value.length > 0) {
      newFilteredTrialIds = selectedTrialIds.value;
    }
    newFilteredTrialIds = newFilteredTrialIds.filter((trialId, trialIndex) => {
      if (
        plotChecked &&
        selectedTrialIds.value.length > 0 &&
        !selectedTrialIds.value.includes(String(trialId))
      ) {
        return false;
      }

      let label = "";
      let foundCluster = false;
      for (const egoName of Object.keys(trajectoryAnalysis ?? {})) {
        if (
          clusteringResult != null &&
          clusterChecked[egoName] != null &&
          clusteringResult[egoName] != null &&
          trialId in clusteringResult[egoName].data
        ) {
          label = clusteringResult[egoName].data[trialId].label ?? "";
          if (clusterChecked[egoName].has(label)) {
            foundCluster = true;
            break;
          }
        }
      }

      if (!foundCluster) {
        return clusteringResult == null || clusteringResult["ITRI"] == null
          ? true
          : false;
      }

      // const trial = trials[trialId];
      //
      // let trialCollisionType = "1";
      //
      // const passed = Number(
      //   trial?.testObjectives?.criticalityMetrics.find(
      //     (m) => m.keyPerformanceIndicator.id === boundaryMetric?.kpi?.id
      //   )?.passed
      // );
      //
      // if (!passed) {
      //   trialCollisionType = "0";
      //   if (
      //     trial != null &&
      //     boundaryMetric != null &&
      //     boundaryMetric.kpi.name === "collision" &&
      //     trajectoryAnalysis != null &&
      //     "collision_type" in trial &&
      //     trial["collision_type"] == 2
      //   ) {
      //     trialCollisionType = "2";
      //   }
      // }
      //
      // if (!passFailChecked.has(trialCollisionType)) {
      //   return false;
      // }

      return true;
    });

    if (
      changeChecked &&
      selectedMetric != null &&
      selectedMetric.gradMin != null &&
      selectedMetric.gradMax != null
    ) {
      console.log(
        trajectoryAnalysis["ITRI"].metricGradients[selectedMetric.kpi.name],
      );

      const changeTrials: string[] = [];
      for (const trialId of newFilteredTrialIds) {
        // console.log(trialId);
        // console.log(
        //   trialId in
        //     trajectoryAnalysis["ITRI"].metricGradients[selectedMetric.kpi.name]
        // );
        // console.log(
        //   String(trialId) in
        //     trajectoryAnalysis["ITRI"].metricGradients[selectedMetric.kpi.name]
        // );
        if (
          !(
            trialId in
            trajectoryAnalysis["ITRI"].metricGradients[selectedMetric.kpi.name]
          )
        ) {
          console.log(`${trialId} not in metricGradients`);
          continue;
        }
        const grad =
          trajectoryAnalysis["ITRI"].metricGradients[selectedMetric.kpi.name][
          trialId
          ];

        let change = Math.sqrt(grad[0] * grad[0] + grad[1] * grad[1]);
        if (change >= changeThreshold) {
          changeTrials.push(trialId);
        }
      }
      newFilteredTrialIds = [...new Set(changeTrials)];
    }

    if (onPassFailBoundaryChecked && treePoints != null && tree != null) {
      const onBoundaryTrials: string[] = [];
      for (const trialId of newFilteredTrialIds) {
        const trial = trials[trialId];
        const currentTreePoint = treePoints.find(
          (p) => Number(p.trial?.id) === Number(trial?.id),
        );
        if (currentTreePoint == null) {
          console.log("currentTreePoint is null, conitnue..");
          continue;
        }
        const nearestTreePointIndices = tree
          ?.nearest(currentTreePoint.parameters, kNN + 1)
          .map((item) => item[0]["treeIndex"]);
        const nearestTreePoints = nearestTreePointIndices.map((i) =>
          treePoints != null ? treePoints[i] : null,
        );

        const currentLabel = clusteringResult
          ? String(clusteringResult["ITRI"]?.data[trial?.id ?? ""].label)
          : null;
        const currentPassed = trial?.testObjectives?.criticalityMetrics.find(
          (m: any) =>
            `${m.keyPerformanceIndicator.id}` ===
            String(boundaryMetric?.kpi.id),
        )?.passed;
        for (const treePoint of nearestTreePoints) {
          if (Number(treePoint?.trial?.id) === Number(trial?.id)) {
            continue;
          }
          const neighborLabel =
            clusteringResult &&
              treePoint?.trial?.id &&
              clusteringResult["ITRI"]?.data[treePoint?.trial?.id ?? ""]
              ? clusteringResult["ITRI"]?.data[treePoint?.trial?.id ?? ""].label
              : null;
          const neighborPassed =
            treePoint?.trial?.testObjectives?.criticalityMetrics.find(
              (m: any) =>
                `${m.keyPerformanceIndicator.id}` ===
                String(boundaryMetric?.kpi.id),
            )?.passed;
          if (
            currentPassed !== neighborPassed &&
            clusterChecked["ITRI"].has(currentLabel ?? "") &&
            clusterChecked["ITRI"].has(neighborLabel ?? "")
          ) {
            onBoundaryTrials.push(trialId);
            break;
          }
        }
      }
      newFilteredTrialIds = [...new Set(onBoundaryTrials)];
    }

    if (onClusterBoundaryChecked && treePoints != null && tree != null) {
      const onBoundaryTrials: string[] = [];
      for (const trialId of newFilteredTrialIds) {
        const trial = trials[trialId];
        const currentTreePoint = treePoints.find(
          (p) => Number(p.trial?.id) === Number(trial?.id),
        );
        if (currentTreePoint == null) {
          console.log("currentTreePoint is null, conitnue..");
          continue;
        }
        const nearestTreePointIndices = tree
          ?.nearest(currentTreePoint.parameters, kNN + 1)
          .map((item) => item[0]["treeIndex"]);
        const nearestTreePoints = nearestTreePointIndices.map((i) =>
          treePoints != null ? treePoints[i] : null,
        );

        const currentLabel = clusteringResult
          ? clusteringResult["ITRI"]?.data[trial?.id ?? ""].label
          : null;
        for (const treePoint of nearestTreePoints) {
          if (Number(treePoint?.trial?.id) === Number(trial?.id)) {
            continue;
          }
          const neighborLabel =
            clusteringResult &&
              treePoint?.trial?.id &&
              clusteringResult["ITRI"]?.data[treePoint?.trial?.id ?? ""]
              ? clusteringResult["ITRI"]?.data[treePoint?.trial?.id ?? ""].label
              : null;

          if (
            clusterChecked["ITRI"].has(currentLabel ?? "") &&
            clusterChecked["ITRI"].has(neighborLabel ?? "") &&
            currentLabel !== neighborLabel &&
            currentLabel != null &&
            neighborLabel != null
          ) {
            onBoundaryTrials.push(trialId);
            break;
          }
        }
      }
      newFilteredTrialIds = [...new Set(onBoundaryTrials)];
    }

    console.log(newFilteredTrialIds);
    dispatch(batchSlice.actions.setFilteredTrialIds(newFilteredTrialIds));
    dispatch(interactionSlice.actions.record("filtering" + ".filter"));
    setLoading(false);
  }, [loading]);

  return (
    <Stack rowGap={1}>
      <Stack>
        <Typography fontWeight="bold">Showing AVs</Typography>
        <Select<string[]>
          sx={{ width: "auto" }}
          size="small"
          label="Attributes"
          labelId="attributes-chip-label"
          multiple
          value={egos}
          onChange={(event: SelectChangeEvent<string[]>) => {
            const {
              target: { value },
            } = event;
            dispatch(
              batchSlice.actions.setEgos(
                // On autofill we get a stringified value.
                typeof value === "string" ? value.split(",") : value,
              ),
            );
          }}
          input={<OutlinedInput id="select-multiple-chip" label="Chip" />}
          renderValue={(selected) => (
            <Box
              component="div"
              sx={{ display: "flex", flexWrap: "wrap", gap: 0.5 }}
            >
              {selected.map((value) => (
                <Chip
                  key={value}
                  label={value == "ITRI" ? "System A" : value}
                />
              ))}
            </Box>
          )}
          MenuProps={{
            PaperProps: {
              style: {
                maxHeight: 48 * 4.5 + 8,
                width: 250,
              },
            },
          }}
        >
          {batch?.egos?.map((e) => (
            <MenuItem
              key={e.name}
              value={e.name}
              style={getStyles(
                e.name,
                batch?.egos?.map((e) => e.name) ?? [],
                theme,
              )}
            >
              {e.name === "ITRI" ? "System A" : e.name}
            </MenuItem>
          ))}
        </Select>
      </Stack>
      <Stack
        sx={{
          minWidth: "200px",
          // borderStyle: "solid",
          // borderWidth: "1px",
          // borderColor: "divider",
        }}
      >
        <Typography fontWeight="bold">Cluster Selection</Typography>
        {Object.keys(trajectoryAnalysis ?? {}).map((egoName) => {
          let indeterminate = false;
          let checked = false;
          let checkedCount = 0;
          if (clusterInfo == null || !(egoName in clusterInfo)) {
            return null;
          }
          for (const label of Object.keys(clusterInfo[egoName] ?? {})) {
            if (
              clusterChecked[egoName] != null &&
              clusterChecked[egoName].has(label)
            ) {
              checkedCount += 1;
            }
          }
          if (
            clusterChecked[egoName] != null &&
            checkedCount === Object.keys(clusterInfo[egoName] ?? {}).length
          ) {
            checked = true;
          }
          if (checkedCount > 0 && !checked) {
            indeterminate = true;
          }
          return (
            <Stack key={egoName}>
              <Stack direction="row" alignItems="center">
                <Checkbox
                  sx={{ p: 0.5 }}
                  indeterminate={indeterminate}
                  checked={checked}
                  onChange={(event) => {
                    if (event.target.checked) {
                      setClusterChecked((prev) => {
                        return {
                          ...prev,
                          [egoName]: new Set([
                            ...Object.keys(clusterInfo[egoName] ?? {}),
                          ]),
                        };
                      });
                    } else {
                      setClusterChecked((prev) => {
                        return {
                          ...prev,
                          [egoName]: new Set(),
                        };
                      });
                    }
                  }}
                />
                <Typography>
                  {egoName === "ITRI" ? "System A" : egoName}
                </Typography>
              </Stack>
              <Stack
                direction="row"
                columnGap={1}
                rowGap={0}
                flexWrap="wrap"
                sx={{ pl: 1 }}
              >
                {Object.keys(clusterInfo[egoName] ?? {}).map((clusterLabel) => {
                  return (
                    <Stack direction="row" alignItems="center">
                      <Checkbox
                        sx={{ p: 0.5 }}
                        checked={
                          clusterChecked[egoName] != null &&
                          clusterChecked[egoName].has(clusterLabel)
                        }
                        onChange={(event) => {
                          if (event.target.checked) {
                            setClusterChecked((prev) => {
                              const newChecked = new Set(prev[egoName]);
                              newChecked.add(clusterLabel);
                              return { ...prev, [egoName]: newChecked };
                            });
                          } else {
                            setClusterChecked((prev) => {
                              const newChecked = new Set(prev[egoName]);
                              newChecked.delete(clusterLabel);
                              return { ...prev, [egoName]: newChecked };
                            });
                          }
                        }}
                      />
                      <Stack columnGap={1} direction="row" alignItems="center">
                        <Box
                          component="div"
                          sx={{
                            width: "18px",
                            height: "18px",
                            background:
                              clusterInfo && clusterInfo[egoName]
                                ? clusterInfo[egoName][clusterLabel].color
                                : "divider",
                          }}
                        />
                        <Typography>{clusterLabel}</Typography>
                      </Stack>
                    </Stack>
                  );
                })}
              </Stack>
            </Stack>
          );
        })}
      </Stack>
      <Stack
        rowGap={1}
        columnGap={1}
        sx={{
          minWidth: "200px",
        }}
      >
        <Typography fontWeight="bold">Collision Selection</Typography>
        {
          //   boundaryMetric?.kpi.name === "collision"
          // ? ["0", "1", "2"]
          // : ["0", "1"]
          ["0", "1"].map((label) => {
            // let text = "Fault";
            // if (label === "1") {
            //   text = "Safe";
            // } else if (label === "2") {
            //   text = "Non-Fault";
            // }
            let text = "Yes (Fail)";
            if (label === "1") {
              text = "No (Pass)";
            } else if (label === "2") {
              text = "Non-Fault";
            }
            return (
              <Stack key={label} direction="row" alignItems="center">
                <Checkbox
                  sx={{ p: 0.5 }}
                  checked={passFailChecked.has(label)}
                  onChange={(event) => {
                    if (event.target.checked) {
                      setPassFailChecked((prev) => {
                        const newChecked = new Set(prev);
                        newChecked.add(label);
                        return newChecked;
                      });
                    } else {
                      setPassFailChecked((prev) => {
                        const newChecked = new Set(prev);
                        newChecked.delete(label);
                        return newChecked;
                      });
                    }
                  }}
                />
                <Typography>{text}</Typography>
              </Stack>
            );
          })
        }
      </Stack>
      <Stack
        rowGap={1}
        columnGap={1}
        sx={{
          minWidth: "200px",
          borderStyle: "solid",
          borderWidth: "1px",
          borderColor: "divider",
          p: 1,
        }}
      >
        <Stack direction="row" alignItems="center">
          <Checkbox
            sx={{ p: 0.5 }}
            checked={onPassFailBoundaryChecked}
            onChange={(event) => {
              setOnPassFailBoundaryChecked(event.target.checked);
            }}
          />
          <Typography fontWeight="bold">On Collision Boundary</Typography>
        </Stack>
        <Stack direction="row" alignItems="center">
          <Checkbox
            sx={{ p: 0.5 }}
            checked={onClusterBoundaryChecked}
            onChange={(event) => {
              setOnClusterBoundaryChecked(event.target.checked);
            }}
          />
          <Typography fontWeight="bold">On Cluster Boundary</Typography>
        </Stack>
        <Stack
          // direction="row"
          columnGap={1}
          rowGap={1}
        // flexWrap="wrap"
        // alignItems="center"
        >
          <Typography
            sx={{ color: "text.primary" }}
          // sx={{
          //   color:
          //     onPassFailBoundaryChecked || onClusterBoundaryChecked
          //       ? "text.primary"
          //       : "text.disabled",
          // }}
          >
            K Nearest Neighbors: {kNN}
          </Typography>
          <Slider
            defaultValue={3}
            step={1}
            marks
            min={1}
            max={50}
            value={kNN}
            // disabled={!onPassFailBoundaryChecked && !onClusterBoundaryChecked}
            onChange={(_event, value) => {
              setKNN(value);
            }}
          />
        </Stack>
      </Stack>
      <Stack
        rowGap={1}
        columnGap={1}
        sx={{
          minWidth: "200px",
          borderStyle: "solid",
          borderWidth: "1px",
          borderColor: "divider",
          p: 1,
        }}
      >
        <Stack direction="row" alignItems="center">
          <Checkbox
            sx={{ p: 0.5 }}
            checked={changeChecked}
            onChange={(event) => {
              setChangeChecked(event.target.checked);
            }}
          />
          <Typography fontWeight="bold">{`${toTitleSpaceCase(
            selectedMetric?.kpi.name ?? "",
          )} Gradient Magnitude`}</Typography>
        </Stack>
        <Stack>
          <Typography
            fontSize={18}
            // sx={{ color: changeChecked ? "text.primary" : "text.disabled" }}
            sx={{ color: "text.primary" }}
          >
            {`≥ ${changeThreshold}`}
          </Typography>
          <Stack>
            <Slider
              defaultValue={0}
              step={0.01}
              min={selectedMetric?.gradMin ?? 0}
              max={selectedMetric?.gradMax ?? 1}
              value={changeThreshold}
              // disabled={!changeChecked}
              onChange={(_event, value) => {
                setChangeThreshold(value);
              }}
            />
          </Stack>
          <Stack direction="row" justifyContent="center" alignItems="center">
            <LegendThreshold scale={metricGradMagScale}>
              {(labels) =>
                labels.map((label, i) => (
                  <Box
                    key={`legend-quantile-${i}`}
                    sx={{
                      flex: 1,
                      width: "10px",
                      height: "20px",
                      background: label.value,
                    }}
                  />
                ))
              }
            </LegendThreshold>
          </Stack>
          <Stack direction="row" justifyContent="space-between">
            <Typography fontSize={16} sx={{ mr: "3px" }}>
              {selectedMetric?.gradMin?.toFixed(2)}
            </Typography>
            <Typography fontSize={16} sx={{ ml: "3px" }}>
              {selectedMetric?.gradMax?.toFixed(2)}
            </Typography>
          </Stack>
        </Stack>
      </Stack>
      <Stack direction="row" alignItems="center">
        <Checkbox
          checked={plotChecked}
          onChange={(_event) => {
            setPlotChecked((prev) => !prev);
          }}
        />
        <Typography fontWeight="bold">Selection on Views</Typography>
      </Stack>
      <Stack direction="row" rowGap={1} columnGap={1}>
        <Button
          sx={{ flex: 2 }}
          variant="contained"
          loading={loading}
          onClick={() => setLoading(true)}
        >
          Filter
        </Button>
        <Button
          sx={{ flex: 1 }}
          size="small"
          variant="outlined"
          onClick={(event) => {
            reset();
          }}
        >
          Reset
        </Button>
      </Stack>
    </Stack>
  );
}

function getStyles(name: string, attributes: readonly string[], theme: any) {
  return {
    fontWeight: attributes.includes(name)
      ? theme.typography.fontWeightMedium
      : theme.typography.fontWeightRegular,
  };
}
