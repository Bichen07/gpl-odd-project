import { Container, Box, Typography, Stack } from "@mui/material";
import { useParams } from "react-router-dom";
import { toast } from "react-toastify";
import LoadingOverlay from "src/components/LoadingOverlay";
import Breadcrumbs from "src/components/Breadcrumbs";
import Introduction from "./Introduction";
import ScenarioService from "src/axios/services/Scenarios";
import VisualizationAndAnalysis from "./VisualizationAndAnalysis";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { setData, setLoading } from "src/redux/slices/scenario";
import { useEffect } from "react";
import Tables from "./Tables";

export default () => {
  const params = useParams();
  const dispatch = useAppDispatch();

  const scenario = useAppSelector((state) => state.scenario.data);
  const loading = useAppSelector((state) => state.scenario.loading);

  useEffect(() => {
    dispatch(setLoading(true));
    dispatch(setData(null));
    ScenarioService.getScenario(params["id"] ?? "")
      .then((response) => {
        dispatch(setData(response.data));
      })
      .catch((error) => {
        toast.error(error);
      });
  }, []);

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    dispatch(setLoading(false));
  }, [scenario]);

  if (loading || scenario === null) {
    return <LoadingOverlay />;
  }

  return (
    <Container sx={{ pt: 3, pb: 6 }}>
      <Box sx={{ pb: 3 }}>
        <Breadcrumbs replacements={{ "1": scenario.name ?? scenario.id }} />
      </Box>
      <Typography variant="h3" sx={{ pb: 3 }}>
        {scenario.name ?? scenario.id}
      </Typography>
      <Stack>
        <Introduction />
        <VisualizationAndAnalysis />
        {/* <Tables /> */}
      </Stack>
    </Container>
  );
};
