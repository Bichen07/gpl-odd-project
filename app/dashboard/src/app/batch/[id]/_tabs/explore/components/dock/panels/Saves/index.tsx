"use client";
import axios from "axios";
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
  ToggleButton,
} from "@mui/material";
import { SavedTrajectoryAnalysis } from "@/app/_shared/graphql/queries/batches";
import {
  ClusteringTask,
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
    (state) => state.batch.trajectoryAnalysis
  );
  const dispatch = useAppDispatch();

  const isBaseline = useAppSelector((state) => state.batch.baselineMode);

  const { batchId, saves } = props;
  const [loadingFilename, setLoadingFilename] = useState<string | null>(null);
  const [savingName, setSavingName] = useState<string>(
    new Date().toLocaleString("en", { timeZone: "Asia/Taipei" })
  );

  const [modalOpened, setModalOpened] = useState(false);
  const [expanded, setExpanded] = useState(new Set<string>());
  const [analysisLoading, setAnalysisLoading] = useState(false);
  const [analysisSavingLoading, setAnalysisSavingLoading] = useState(false);

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
          <Stack
            sx={{ mb: 2 }}
            direction="row"
            flexWrap="wrap"
            rowGap={1}
            columnGap={1}
          >
            {saves?.map((item, index) => (
              <Paper
                key={item.id ?? index}
                component={Button}
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
                        // `${process.env.NEXT_PUBLIC_PAYLOAD_API_ADDRESS}/api/documents/${item.filename}`,
                        item?.url ?? "",
                        { responseType: "arraybuffer" }
                      );
                      const zipBlob = await response.data;

                      const zip = await JSZip.loadAsync(zipBlob);

                      // Log all filenames
                      console.log(item.filename);
                      console.log("Files in ZIP:");
                      Object.keys(zip.files).forEach((name) =>
                        console.log(name)
                      );

                      // Find the first `.json` file (or any file you want)
                      const jsonFileName = Object.keys(zip.files).find((name) =>
                        name.endsWith(".json")
                      );
                      if (jsonFileName == null)
                        throw new Error("No JSON file found in ZIP");

                      const jsonText = await zip
                        .file(jsonFileName)
                        ?.async("text");
                      const jsonObject = JSON.parse(jsonText ?? "");

                      console.log("UNZIPPED Save");
                      console.log(jsonObject);
                      for (const key of Object.keys(jsonObject)) {
                        jsonObject[key]["id"] = item.id;
                      }
                      dispatch(
                        batchSlice.actions.setTrajectoryAnalysis(jsonObject)
                      );
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
            <LoadingButton
              variant="contained"
              sx={{ width: "100%" }}
              onClick={() => {
                const fetchData = async () => {
                  try {
                    // console.log(tasks);
                    const newResponse = await getTrajectoryAnalysis({
                      batchIds: [batchId],
                      framePeriod: 0.1,
                      tasks,
                    })
                      .then((response) => {
                        console.log(response);
                        return response.data;
                      })
                      .catch((error) => {
                        console.error(error);
                        return null;
                      });
                    setAnalysisLoading(false);
                    console.log(newResponse);
                    dispatch(
                      batchSlice.actions.setTrajectoryAnalysis(
                        newResponse as any
                      )
                    );
                  } catch (error) {
                    console.error(error);
                    setAnalysisLoading(false);
                    toast.error("Clustering failed!");
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
                    onClick={() => {
                      const updateBatch = async () => {
                        console.log("SAVE NEW RESPONSE");
                        console.log(trajectoryAnalysis);
                        const jsonBlob = new Blob(
                          [JSON.stringify(trajectoryAnalysis)],
                          {
                            type: "application/json",
                          }
                        );
                        const form = new FormData();
                        form.append("file", jsonBlob, savingName + ".json");
                        await postDocument(form)
                          .then((response) => console.log(response.data))
                          .catch((error) => {
                            console.error(error);
                            setAnalysisSavingLoading(false);
                            toast.error(
                              "Fail to save. Cannot upload the json document."
                            );
                          });
                        setAnalysisSavingLoading(false);
                      };

                      setAnalysisSavingLoading(true);
                      updateBatch();
                    }}
                  >
                    save help
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

      <ToggleButton
        value="baseline_toggle"
        size="small"
        selected={false}
        onChange={(_event) => {
          dispatch(batchSlice.actions.setBaselineMode(!isBaseline));
        }}
      >
        {isBaseline ? "Baseline On" : "Baseline Off"}
      </ToggleButton>
    </Stack>
  );
}
