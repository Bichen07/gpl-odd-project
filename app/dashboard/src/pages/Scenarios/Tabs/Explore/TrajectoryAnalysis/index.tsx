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
  TextField,
  Button,
} from "@mui/material";
import { postDocument } from "src/api/services/Documents";
import { useState } from "react";
import { getDoc } from "src/api/common";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";
import { toast } from "react-toastify";
import axios from "axios";
import { BatchesSelect } from "./BatchesSelect";
import { Execution } from "./Execution";
import { useTrajectoryAnalysisSaves } from "src/api/services/Sessions";
import { useParams } from "react-router-dom";
import { useSessionBatches } from "src/api/services/Batches";
import { LoadingButton } from "@mui/lab";
import { Session } from "src/__generated__/graphql";
import { ClusteringTaskSelect } from "./ClusteringTasksSelect";
import { ClusteringTask } from "src/api/services/TrajectoryAnalysis";

export default function TrajectoryAnalysis() {
  const dispatch = useAppDispatch();
  const params = useParams();

  const trajectoryAnalysisResponse = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const savesResponse = useTrajectoryAnalysisSaves(params["sessionId"]);
  const savedTrajectoryAnalysis = savesResponse.data;
  const sesssionBatchesResponse = useSessionBatches(params["sessionId"]);
  let batches = sesssionBatchesResponse?.data?.Batches?.docs ?? null;

  const [saveLoading, setSaveLoading] = useState(false);
  const [savedName, setSavedName] = useState(
    new Date(Date.now()).toISOString(),
  );
  const [modalOpened, setModalOpened] = useState(false);
  const [loadingSave, setLoadingSave] = useState<string | null>(null);
  const [expanded, setExpanded] = useState(new Set<string>());
  const [filteredBatchIds, setFilteredBatchIds] = useState(new Set<string>());

  const [tasks, setTasks] = useState<ClusteringTask[]>([
    { method: "hdbscan", nClusters: 0 },
    // { method: "hdbscanFlat", nClusters: 2 },
    // { method: "hdbscanFlat", nClusters: 3 },
    // { method: "hdbscanFlat", nClusters: 4 },
    // { method: "hdbscanFlat", nClusters: 5 },
    // { method: "hdbscanFlat", nClusters: 6 },
    // { method: "hdbscanFlat", nClusters: 7 },
    // { method: "hdbscanFlat", nClusters: 8 },
    // { method: "hdbscanFlat", nClusters: 9 },
    // { method: "hdbscanFlat", nClusters: 10 },
    // { method: "hdbscanFlat", nClusters: 11 },
    // { method: "hdbscanFlat", nClusters: 12 },
    // { method: "hdbscanFlat", nClusters: 13 },
    // { method: "hdbscanFlat", nClusters: 14 },
    // { method: "hdbscanFlat", nClusters: 15 },
    { method: "hierarchy", nClusters: 2 },
    { method: "hierarchy", nClusters: 3 },
    { method: "hierarchy", nClusters: 4 },
    { method: "hierarchy", nClusters: 5 },
    { method: "hierarchy", nClusters: 6 },
    { method: "hierarchy", nClusters: 7 },
    { method: "hierarchy", nClusters: 8 },
    { method: "hierarchy", nClusters: 9 },
    { method: "hierarchy", nClusters: 10 },
    { method: "hierarchy", nClusters: 11 },
    { method: "hierarchy", nClusters: 12 },
    { method: "hierarchy", nClusters: 13 },
    { method: "hierarchy", nClusters: 14 },
    { method: "hierarchy", nClusters: 15 },
    { method: "hierarchy", nClusters: 16 },
    { method: "hierarchy", nClusters: 17 },
    { method: "hierarchy", nClusters: 18 },
    { method: "hierarchy", nClusters: 19 },
    { method: "hierarchy", nClusters: 20 },
    // { method: "kmeans", nClusters: 2 },
    // { method: "kmeans", nClusters: 3 },
    // { method: "kmeans", nClusters: 4 },
    // { method: "kmeans", nClusters: 5 },
    // { method: "kmeans", nClusters: 6 },
    // { method: "kmeans", nClusters: 7 },
    // { method: "kmeans", nClusters: 8 },
    // { method: "kmeans", nClusters: 9 },
    // { method: "kmeans", nClusters: 10 },
    // { method: "kmeans", nClusters: 11 },
    // { method: "kmeans", nClusters: 12 },
    // { method: "kmeans", nClusters: 13 },
    // { method: "kmeans", nClusters: 14 },
    // { method: "kmeans", nClusters: 15 },
    // { method: "kmeans", nClusters: 16 },
    // { method: "kmeans", nClusters: 17 },
    // { method: "kmeans", nClusters: 18 },
    // { method: "kmeans", nClusters: 19 },
    // { method: "kmeans", nClusters: 20 },
  ]);

  return (
    <Stack sx={{ backgroundColor: "background.paper", height: "100%" }}>
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
            {savedTrajectoryAnalysis?.Session?.savedTrajectoryAnalysis?.map(
              (item, index) => (
                <Paper
                  key={index}
                  component={LoadingButton}
                  disabled={loadingSave !== null}
                  loading={loadingSave === item.url}
                  onClick={() => {
                    const fetchData = async () => {
                      if (!item.url) {
                        return;
                      }
                      setLoadingSave(item.url);
                      const saved = await axios(item.url ?? "")
                        .then((response) => response.data)
                        .catch((error) => {
                          console.error(error);
                          toast.error(
                            "Fail to fetch saved trajectory analysis",
                          );
                        });
                      console.log(saved);
                      dispatch(
                        sessionSlice.actions.setTrajectoryAnalysisResponse(
                          saved,
                        ),
                      );
                      setLoadingSave(null);
                    };
                    fetchData();
                  }}
                  sx={{
                    p: 2,
                    ":hover": { cursor: "pointer", filter: "brightness(80%)" },
                  }}
                >
                  {item.url ? item.url.split("/").slice(-1)[0] : null}
                </Paper>
              ),
            )}
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
            <Stack sx={{ width: "100%" }}>
              <BatchesSelect
                setFilteredBatchIds={setFilteredBatchIds}
                filteredBatchIds={filteredBatchIds}
                expanded={expanded}
                setExpanded={setExpanded}
              />
              <ClusteringTaskSelect
                tasks={tasks}
                setTasks={setTasks}
                expanded={expanded}
                setExpanded={setExpanded}
              />
            </Stack>
            <Execution
              tasks={tasks}
              batchIds={
                filteredBatchIds.size > 0
                  ? [...filteredBatchIds]
                  : batches
                    ? batches.map((b) => b?.id ?? "")
                    : []
              }
            />
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
                    value={savedName}
                    onChange={(event) => setSavedName(event.target.value)}
                  />
                  <LoadingButton
                    variant="contained"
                    loading={saveLoading}
                    onClick={() => {
                      const updateSession = async () => {
                        const sessionId = params["sessionId"];
                        if (!sessionId) {
                          toast.error(
                            "Fail to save. Could not find session ID.",
                          );
                          return;
                        }
                        const jsonBlob = new Blob(
                          [JSON.stringify(trajectoryAnalysisResponse)],
                          {
                            type: "application/json",
                          },
                        );
                        const form = new FormData();
                        form.append("file", jsonBlob, savedName + ".json");
                        const document = await postDocument(form)
                          .then((response) => response.data)
                          .catch((error) => {
                            console.error(error);
                            toast.error(
                              "Fail to save. Cannot upload the json document.",
                            );
                          });
                        if (!document) {
                          return;
                        }
                        const originalData = await getDoc<Session>(
                          "sessions",
                          sessionId,
                        ).then((response) => response.data);

                        // const updatedData = {
                        //   savedTrajectoryAnalysis: [
                        //     ...(originalData.savedTrajectoryAnalysis ?? []),
                        //     document?.id,
                        //   ],
                        // };

                        setSaveLoading(false);
                      };

                      setSaveLoading(true);
                      updateSession();
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
    </Stack>
  );
}
