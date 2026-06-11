"use client";
import { toast } from "react-toastify";
import { LoadingButton } from "@mui/lab";
import { ExpandMore } from "@mui/icons-material";
import {
  Box,
  Accordion,
  AccordionDetails,
  Modal,
  AccordionSummary,
  Paper,
  Stack,
  Typography,
  Button,
  TextField,
  LinearProgress,
} from "@mui/material";
import axios from "axios";
import {
  appendBatchTrajectoryAnalysisSave,
  SavedTrajectoryAnalysis,
} from "@/app/_shared/graphql/queries/batches";
import {
  AnalysisProgress,
  ClusteringTask,
  getAnalysisProgress,
  getTrajectoryAnalysis,
} from "@/app/_shared/graphql/queries/clustering";
// import { IDockviewPanelProps } from "dockview";
import { useEffect, useState } from "react";
import { postDocument } from "@/app/_shared/graphql/queries/documents";
import { useAppDispatch, useAppSelector } from "../../../../redux/hooks";
import { batchSlice } from "../../../../redux/slices/batch";
import JSZip from "jszip";
import LZString from "lz-string";

type Props = {
  batchId: string;
  saves: SavedTrajectoryAnalysis;
};
export default function Saves(props: Props) {
  const trajectoryAnalysis = useAppSelector(
    (state) => state.batch.trajectoryAnalysis,
  );
  const dispatch = useAppDispatch();

  const isBaseline = useAppSelector((state) => state.batch.baselineMode);

  const { batchId, saves } = props;
  const [saveItems, setSaveItems] = useState<SavedTrajectoryAnalysis>(saves);
  const [loadingFilename, setLoadingFilename] = useState<string | null>(null);
  const [savingName, setSavingName] = useState<string>(
    new Date().toLocaleString("en", { timeZone: "Asia/Taipei" }),
  );

  const [modalOpened, setModalOpened] = useState(false);
  const [expanded, setExpanded] = useState(new Set<string>());
  const [analysisLoading, setAnalysisLoading] = useState(false);
  const [analysisSavingLoading, setAnalysisSavingLoading] = useState(false);
  const [analysisElapsedSec, setAnalysisElapsedSec] = useState(0);
  const [analysisStatus, setAnalysisStatus] = useState<string | null>(null);
  const [analysisProgress, setAnalysisProgress] =
    useState<AnalysisProgress | null>(null);
  const [progressPollFailed, setProgressPollFailed] = useState(false);
  const [activeSaveId, setActiveSaveId] = useState<string | null>(null);

  useEffect(() => {
    setSaveItems(saves);
  }, [saves]);

  const formatElapsed = (seconds: number) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m}:${s.toString().padStart(2, "0")}`;
  };

  useEffect(() => {
    if (!analysisLoading) {
      setAnalysisElapsedSec(0);
      setAnalysisProgress(null);
      setProgressPollFailed(false);
      return;
    }
    const startedAt = Date.now();
    const timer = window.setInterval(() => {
      setAnalysisElapsedSec(Math.floor((Date.now() - startedAt) / 1000));
    }, 1000);
    let failedPolls = 0;
    const pollProgress = window.setInterval(async () => {
      try {
        const response = await getAnalysisProgress();
        setAnalysisProgress(response.data);
        failedPolls = 0;
        setProgressPollFailed(false);
      } catch {
        failedPolls += 1;
        if (failedPolls >= 2) {
          setProgressPollFailed(true);
        }
      }
    }, 1500);
    void getAnalysisProgress()
      .then((response) => {
        setAnalysisProgress(response.data);
        setProgressPollFailed(false);
      })
      .catch(() => setProgressPollFailed(true));
    return () => {
      window.clearInterval(timer);
      window.clearInterval(pollProgress);
    };
  }, [analysisLoading]);

  // const minSamples = [-1];
  // const minClusterSizes = [5, 10, 15, 25, 50, 75, 100];
  // const clusterSelectionEpsilon = [0];
  // const minSamples = [-1, 5, 10, 15, 20];
  // const minSamples = [-1];
  //
  const minSamples = [-1, 3, 5, 7, 10, 15, 25, 30, 35, 50];
  const minClusterSizes = [5, 10, 20, 30, 40, 50, 75, 100];
  const clusterSelectionEpsilon = [0, 0.3, 0.5, 1.0, 1.5, 3.0, 5.0, 10];
  // const minSamples = [-1, 5, 10, 25];
  // const minClusterSizes = [5, 10, 25, 50];
  // const clusterSelectionEpsilon = [0, 0.3, 0.5, 1.0, 3.0];

  // const clusterSelectionEpsilon = [
  //   0, 0.3, 0.5, 0.7, 1.0, 3.0, 5.0, 7.5, 10.0, 25, 50, 75, 100, 200, 250, 500,
  //   750, 1000,
  // ];
  // const minClusterSizes = [5, 10, 15, 25, 50, 75, 100, 150];
  // const minSamples = [-1, 5, 10, 15, 25, 35, 50];
  // const clusterSelectionEpsilon = [
  //   0, 0.3, 0.5, 0.7, 1.0, 1.5, 3.0, 5.0, 10, 25,
  // ];
  const clusterSelectionMethods: ("eom" | "leaf")[] = ["eom"];
  const [tasks, setTasks] = useState<ClusteringTask[]>([
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 10 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 15 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 20 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 25 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 30 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 35 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 40 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 45 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 50 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 55 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 60 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 70 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 80 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 90 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 100 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 125 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 150 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 175 },
    // { method: "hdbscan+mfpca", nClusters: 0, minClusterSize: 200 },
  ]);

  useEffect(() => {
    const newTasks: ClusteringTask[] = [];
    for (const a of minClusterSizes) {
      for (const b of minSamples) {
        for (const c of clusterSelectionEpsilon) {
          if (b > a) {
            continue;
          }
          for (const d of clusterSelectionMethods) {
            newTasks.push({
              method: "hdbscan+mfpca",
              nClusters: 0,
              minClusterSize: a,
              minSamples: b,
              clusterSelectionEpsilon: c,
              clusterSelectionMethod: d,
            });
          }
        }
      }
    }
    // console.log(newTasks);
    // const nClusters = [2, 3, 4, 5, 6, 7, 8];
    // for (const nCluster of nClusters) {
    //   newTasks.push({
    //     method: "hierarchy+mfpca",
    //     nClusters: nCluster,
    //     minClusterSize: 0,
    //     minSamples: -1,
    //     clusterSelectionEpsilon: 0,
    //     clusterSelectionMethod: "eom",
    //   });
    // }
    setTasks(newTasks);
  }, []);

  return (
    <Stack
      sx={{
        backgroundColor: "background.paper",
        height: "100%",
        width: "100%",
      }}
    >
      <Accordion
        disableGutters
        elevation={0}
        sx={{ p: 2, backgroundColor: "background.paper" }}
        expanded={expanded.has("saves")}
        onChange={() =>
          setExpanded((prev) => {
            const newSet = new Set(prev);
            const expandedId = "saves";
            if (newSet.has(expandedId)) {
              newSet.delete(expandedId);
            } else {
              newSet.add(expandedId);
            }
            return newSet;
          })
        }
      >
        <AccordionSummary sx={{ p: 0 }} expandIcon={<ExpandMore />}>
          <Typography variant="subtitle1">Saves</Typography>
        </AccordionSummary>
        <AccordionDetails
          sx={{
            margin: 0,
            display: "flex",
            rowGap: 1,
            columnGap: 1,
            flexWrap: "wrap",
            padding: 0,
          }}
        >
          <Stack sx={{ mb: 1, width: "100%" }} rowGap={1}>
            {trajectoryAnalysis != null && (
              <Stack direction="row" flexWrap="wrap" gap={1} alignItems="center">
                <Typography variant="caption" color="text.secondary">
                  Loaded analysis
                  {activeSaveId != null ? ` (save #${activeSaveId})` : " (current run)"}
                  {" — "}
                  {Object.values(trajectoryAnalysis)[0]?.trials
                    ? Object.keys(Object.values(trajectoryAnalysis)[0].trials).length
                    : "?"}{" "}
                  trials. Run Analysis again for latest Payload data, or Clear below.
                </Typography>
                <Button
                  size="small"
                  variant="outlined"
                  color="warning"
                  onClick={() => {
                    dispatch(batchSlice.actions.setTrajectoryAnalysis(null));
                    setActiveSaveId(null);
                    toast.info(
                      "Cleared loaded analysis. Click Analysis to cluster all current trials.",
                    );
                  }}
                >
                  Clear analysis
                </Button>
              </Stack>
            )}
          </Stack>
          <Stack
            sx={{ mb: 2 }}
            direction="row"
            flexWrap="wrap"
            rowGap={1}
            columnGap={1}
          >
            {saveItems?.map((item, index) => (
              <Paper
                key={item.id ?? index}
                component={Button}
                sx={{
                  ...(activeSaveId === String(item.id)
                    ? { bgcolor: "primary.main", color: "primary.contrastText" }
                    : {}),
                }}
                loading={loadingFilename === item.filename}
                disabled={loadingFilename != null}
                onClick={() => {
                  setLoadingFilename(item.filename);
                  const loadSave = async () => {
                    try {
                      // axios
                      //   .get(
                      //     `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/Documents/${item.filename}`
                      //   )
                      //   .then((response) => {
                      //     // console.log(response.data);
                      //     setLoadingFilename(null);
                      //     dispatch(
                      //       batchSlice.actions.setTrajectoryAnalysis(
                      //         response.data
                      //       )
                      //     );
                      //   });

                      console.log(item.filename);
                      const response = await axios.get(
                        item?.url ?? "",
                        { responseType: "arraybuffer" },
                      );
                      const fileBlob = response.data;
                      let jsonObject: any;

                      const isZip =
                        item.filename?.toLowerCase().endsWith(".zip") ||
                        (fileBlob.byteLength >= 2 &&
                          new Uint8Array(fileBlob)[0] === 0x50 &&
                          new Uint8Array(fileBlob)[1] === 0x4b);

                      if (isZip) {
                        const zip = await JSZip.loadAsync(fileBlob);
                        const jsonFileName = Object.keys(zip.files).find(
                          (name) => name.endsWith(".json"),
                        );
                        if (jsonFileName == null) {
                          throw new Error("No JSON file found in ZIP");
                        }
                        const jsonText = await zip
                          .file(jsonFileName)
                          ?.async("text");
                        jsonObject = JSON.parse(jsonText ?? "");
                      } else {
                        const jsonText = new TextDecoder().decode(fileBlob);
                        jsonObject = JSON.parse(jsonText);
                      }

                      console.log("UNZIPPED Save");
                      console.log(jsonObject);
                      for (const key of Object.keys(jsonObject)) {
                        jsonObject[key]["id"] = item.id;
                      }
                      dispatch(
                        batchSlice.actions.setTrajectoryAnalysis(jsonObject),
                      );
                      setActiveSaveId(String(item.id));
                      setLoadingFilename(null);
                    } catch (err) {
                      setLoadingFilename(null);
                      dispatch(batchSlice.actions.setTrajectoryAnalysis(null));
                      toast.error("Fail to load selectd saved file!");
                      console.error(err);
                    }
                  };
                  loadSave();
                }}
              >
                {item.filename}
              </Paper>
            ))}
          </Stack>
        </AccordionDetails>
      </Accordion>
      <Accordion
        disableGutters
        elevation={0}
        sx={{ backgroundColor: "background.paper", p: 2 }}
        expanded={expanded.has("newClustering")}
        onChange={() =>
          setExpanded((prev) => {
            const newSet = new Set(prev);
            const expandedId = "newClustering";
            if (newSet.has(expandedId)) {
              newSet.delete(expandedId);
            } else {
              newSet.add(expandedId);
            }
            return newSet;
          })
        }
      >
        <AccordionSummary sx={{ p: 0 }} expandIcon={<ExpandMore />}>
          <Typography variant="subtitle1">Create New</Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Stack
            direction="row"
            flexWrap="wrap"
            rowGap={2}
            columnGap={2}
            sx={{ p: 0 }}
          >
            {analysisLoading && (() => {
              const showLiveProgress =
                analysisProgress?.active && (analysisProgress.total ?? 0) > 0;
              const estimatedPercent = Math.min(
                95,
                Math.round((analysisElapsedSec / 120) * 100),
              );
              const estimatedTasks =
                analysisElapsedSec < 45
                  ? 0
                  : Math.min(
                      tasks.length,
                      Math.round(
                        ((analysisElapsedSec - 45) / 15) * tasks.length,
                      ),
                    );
              return (
                <Stack sx={{ width: "100%" }} rowGap={1}>
                  <LinearProgress
                    variant={showLiveProgress ? "determinate" : "determinate"}
                    value={
                      showLiveProgress
                        ? analysisProgress.percent
                        : estimatedPercent
                    }
                  />
                  <Typography variant="body2" color="text.secondary">
                    {showLiveProgress
                      ? analysisProgress.message
                      : analysisStatus ??
                        `Running MFPCA + ${tasks.length} HDBSCAN tasks…`}
                  </Typography>
                  {showLiveProgress ? (
                    <Typography variant="body2" color="text.secondary">
                      {analysisProgress.current}/{analysisProgress.total} (
                      {analysisProgress.percent}%)
                    </Typography>
                  ) : (
                    <Typography variant="body2" color="text.secondary">
                      {estimatedTasks > 0
                        ? `~${estimatedTasks}/${tasks.length} HDBSCAN tasks (estimated, ${estimatedPercent}%)`
                        : `Preparing trajectories / MFPCA… (${estimatedPercent}% estimated)`}
                    </Typography>
                  )}
                  {progressPollFailed && !showLiveProgress && (
                    <Typography variant="caption" color="warning.main">
                      Live task counter unavailable — restart Analyzer
                      (Ctrl+C, then litestar run --port 9010). Terminal logs
                      still show real progress.
                    </Typography>
                  )}
                  <Typography variant="caption" color="text.secondary">
                    Elapsed {formatElapsed(analysisElapsedSec)} — keep this tab
                    open. Check Clustering Selection when complete.
                  </Typography>
                </Stack>
              );
            })()}
            <LoadingButton
              variant="contained"
              sx={{ width: "100%" }}
              disabled={analysisLoading || tasks.length === 0}
              onClick={() => {
                const fetchData = async () => {
                  setAnalysisStatus(
                    `Contacting Analyzer (batch ${batchId}, ${tasks.length} tasks)…`,
                  );
                  try {
                    const response = await getTrajectoryAnalysis({
                      batchIds: [batchId],
                      framePeriod: 0.1,
                      tasks,
                    });
                    const newResponse = response.data;
                    if (newResponse == null || typeof newResponse !== "object") {
                      throw new Error("Analyzer returned an empty response.");
                    }
                    dispatch(
                      batchSlice.actions.setTrajectoryAnalysis(
                        newResponse as any,
                      ),
                    );
                    setActiveSaveId(null);
                    toast.success(
                      `Analysis complete (${formatElapsed(analysisElapsedSec)}). Open Clustering Selection to pick a result.`,
                    );
                    setAnalysisStatus(null);
                  } catch (error) {
                    console.error(error);
                    let message = "Clustering failed. Check Analyzer logs.";
                    if (axios.isAxiosError(error)) {
                      const detail =
                        (error.response?.data as { detail?: string })?.detail ??
                        error.message;
                      message = `Analyzer error (${error.response?.status ?? "network"}): ${detail}`;
                    } else if (error instanceof Error) {
                      message = error.message;
                    }
                    toast.error(message);
                    setAnalysisStatus(message);
                  } finally {
                    setAnalysisLoading(false);
                  }
                };

                setAnalysisLoading(true);
                fetchData();
              }}
              loading={analysisLoading}
            >
              Analysis
            </LoadingButton>
            <Modal open={modalOpened} onClose={() => setModalOpened(false)}>
              <Box
                component="div"
                sx={{
                  position: "absolute",
                  top: "50%",
                  left: "50%",
                  transform: "translate(-50%, -50%)",
                  boxShadow: 10,
                }}
              >
                <Stack component={Paper} sx={{ p: 4 }} rowGap={3}>
                  <Typography variant="h5">
                    Saving Trajectory Analysis Response
                  </Typography>
                  <TextField
                    label="name"
                    variant="outlined"
                    value={savingName}
                    onChange={(event) => setSavingName(event.target.value)}
                  />
                  <LoadingButton
                    variant="contained"
                    loading={analysisSavingLoading}
                    disabled={trajectoryAnalysis == null}
                    onClick={() => {
                      const saveAnalysis = async () => {
                        if (trajectoryAnalysis == null) {
                          toast.error(
                            "Nothing to save — run Analysis first and wait for it to finish.",
                          );
                          return;
                        }
                        try {
                          const zip = new JSZip();
                          zip.file(
                            "trajectories.json",
                            JSON.stringify(trajectoryAnalysis),
                          );
                          const zipBlob = await zip.generateAsync({
                            type: "blob",
                            compression: "DEFLATE",
                          });
                          const zipFilename = savingName + ".zip";
                          const form = new FormData();
                          form.append("file", zipBlob, zipFilename);
                          const uploadResponse = await postDocument(form);
                          const doc = (uploadResponse.data as { doc?: {
                            id: number;
                            url?: string | null;
                            filename?: string | null;
                          } }).doc;
                          if (doc?.id == null) {
                            throw new Error(
                              "Upload succeeded but document id is missing.",
                            );
                          }
                          const existingIds = (saveItems ?? [])
                            .map((item) => Number(item?.id))
                            .filter((id) => Number.isFinite(id));
                          await appendBatchTrajectoryAnalysisSave(
                            Number(batchId),
                            Number(doc.id),
                            existingIds,
                          );
                          setSaveItems((prev) => [
                            ...(prev ?? []),
                            {
                              id: Number(doc.id),
                              url: doc.url ?? null,
                              filename: doc.filename ?? zipFilename,
                            },
                          ]);
                          toast.success(
                            `Saved "${zipFilename}" and linked to batch ${batchId}.`,
                          );
                          setModalOpened(false);
                        } catch (error) {
                          console.error(error);
                          toast.error(
                            "Failed to upload document. Is Payload reachable?",
                          );
                        } finally {
                          setAnalysisSavingLoading(false);
                        }
                      };

                      setAnalysisSavingLoading(true);
                      saveAnalysis();
                    }}
                  >
                    Save
                  </LoadingButton>
                </Stack>
              </Box>
            </Modal>
            <Button
              size="small"
              variant="outlined"
              sx={{ height: "30px" }}
              onClick={() => setModalOpened(true)}
            >
              save
            </Button>
          </Stack>
        </AccordionDetails>
      </Accordion>

      {/* <ToggleButton */}
      {/*   value="baseline_toggle" */}
      {/*   size="small" */}
      {/*   selected={false} */}
      {/*   onChange={(_event) => { */}
      {/*     dispatch(batchSlice.actions.setBaselineMode(!isBaseline)); */}
      {/*   }} */}
      {/* > */}
      {/*   {isBaseline ? "Baseline On" : "Baseline Off"} */}
      {/* </ToggleButton> */}
    </Stack>
  );
}
