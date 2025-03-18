import { LoadingButton } from "@mui/lab";
import { toast } from "react-toastify";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Modal,
  Paper,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { useState } from "react";
import { useParams } from "react-router-dom";
import { getStateAnalysis } from "src/api/services/StateAnalysis";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";
import { postDocument } from "src/api/services/Documents";
import { getDoc } from "src/api/common";
import { Session } from "src/__generated__/graphql";
import { ExpandMore } from "@mui/icons-material";
import { useStateAnalysisSaves } from "src/api/services/Sessions";
import axios from "axios";

export default function StateAnalysis() {
  const dispatch = useAppDispatch();
  const params = useParams();
  const [loading, setLoading] = useState(false);

  const savesResponse = useStateAnalysisSaves(params["sessionId"]);
  const savedStateAnalysis = savesResponse.data;

  const [saveLoading, setSaveLoading] = useState(false);
  const [savedName, setSavedName] = useState(
    new Date(Date.now()).toISOString(),
  );
  const [expanded, setExpanded] = useState(new Set<string>());
  const [modalOpened, setModalOpened] = useState(false);
  const [loadingSave, setLoadingSave] = useState<string | null>(null);

  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const stateAnalysis = useAppSelector(
    (state) => state.session.stateAnalysisResponse,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );

  const execute = () => {
    if (trajectoryAnalysis == null) {
      return;
    }
    const fetchData = async () => {
      try {
        const newResponse = await getStateAnalysis({
          batchIds: trajectoryAnalysis.request.batchIds,
          trialIds: filteredTrialIds,
          metricNames: ["dce_min"],
        }).then((response) => response.data);
        setLoading(false);
        console.log(newResponse);
        dispatch(sessionSlice.actions.setStateAnalysisResponse(newResponse));
      } catch (error) {
        console.error(error);
        setLoading(false);
      }
    };

    setLoading(true);
    fetchData();
  };
  return (
    <Stack>
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
            <Typography variant="h5">Saving State Analysis Response</Typography>
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
                    toast.error("Fail to save. Could not find session ID.");
                    return;
                  }
                  const jsonBlob = new Blob([JSON.stringify(stateAnalysis)], {
                    type: "application/json",
                  });
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
            {savedStateAnalysis?.Session?.savedStateAnalysis?.map(
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
                          toast.error("Fail to fetch saved state analysis");
                        });
                      console.log(saved);
                      dispatch(
                        sessionSlice.actions.setStateAnalysisResponse(saved),
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
      <LoadingButton
        variant="contained"
        sx={{ width: "100%" }}
        onClick={execute}
        loading={loading}
      >
        Analysis
      </LoadingButton>
      <Button
        size="small"
        variant="outlined"
        sx={{ height: "30px" }}
        onClick={() => setModalOpened(true)}
      >
        save
      </Button>
    </Stack>
  );
}
