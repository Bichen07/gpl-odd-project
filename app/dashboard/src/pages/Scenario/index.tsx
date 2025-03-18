import { Box, Divider } from "@mui/material";
import { useTheme } from "@mui/material/styles";
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { Batch, Scenario as ScenarioData } from "src/__generated__/graphql";
import { getDoc } from "src/api/common";
import Breadcrumbs from "src/components/Breadcrumbs";
import LoadingOverlay from "src/components/LoadingOverlay";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { batchSlice } from "src/redux/slices/batch";
import { getCriticalityMetrics, getParameters } from "src/utils";
import Drawer from "./Drawer";
import Report from "./Tabs/Report";
import Explore from "./Tabs/Explore";
import Info from "./Tabs/Info";

export default function Scenario() {
  const theme = useTheme();
  const dispatch = useAppDispatch();

  const params = useParams();
  const batchId = params["batchId"] ?? "";

  const [loading, setLoading] = useState(true);

  const scenario = useAppSelector((state) => state.batch.scenario);
  const parameters = useAppSelector((state) => state.batch.parameters);
  const trials = useAppSelector((state) => state.batch.trials);
  const criticalityMetrics = useAppSelector(
    (state) => state.batch.criticalityMetrics,
  );

  useEffect(() => {
    setLoading(true);
    dispatch(batchSlice.actions.reset());
    const fetchData = async () => {
      try {
        const batch = await getDoc<Batch>("batches", batchId, {
          depth: 1,
        }).then((response) => response.data);
        dispatch(batchSlice.actions.setBatch(batch));
        const trials = batch.trials;
        dispatch(batchSlice.actions.setTrials(trials ?? []));
        dispatch(batchSlice.actions.setFilteredTrials(trials ?? []));
        const scenarioId = batch.scenario.id as string;
        const scenario = await getDoc<ScenarioData>(
          "scenarios",
          scenarioId,
        ).then((response) => response.data);
        dispatch(batchSlice.actions.setScenario(scenario));
        dispatch(batchSlice.actions.setParameters(getParameters(scenario)));
        const criticalityMetrics = getCriticalityMetrics(
          scenario,
          batch.trials ?? [],
        );
        dispatch(batchSlice.actions.setCriticalityMetrics(criticalityMetrics));
        dispatch(
          batchSlice.actions.setSelectedCriticalityMetric(
            Object.values(criticalityMetrics ?? {})[0],
          ),
        );
      } catch (error) {
        console.error(error);
      }
    };
    fetchData();
  }, [batchId]);

  useEffect(() => {
    if (!scenario || !parameters || !trials || !criticalityMetrics) {
      return;
    }
    setLoading(false);
  }, [scenario, parameters, trials, criticalityMetrics]);

  if (loading) {
    return <LoadingOverlay />;
  }

  return (
    <Box component="div">
      <Drawer />
      <Box
        component="div"
        sx={{
          paddingLeft: `calc(${theme.spacing(8)} + ${
            params["tabName"] === "explore" ? "0px" : "2rem"
          })`,
          paddingRight: params["tabName"] === "explore" ? 0 : "2rem",
        }}
      >
        <Box
          component="div"
          sx={{
            mt: 3,
            mb: 3,
            display: params["tabName"] === "explore" ? "none" : "initial",
          }}
        >
          <Breadcrumbs
            replacements={{ "1": scenario?.id ?? batchId }}
            skip={[1]}
          />
        </Box>
        <Report
          sx={{
            display:
              params["tabName"] === undefined || params["tabName"] === "report"
                ? "initial"
                : "none",
          }}
        />
        <Info
          sx={{
            display: params["tabName"] === "info" ? "initial" : "none",
          }}
        />
        <Explore
          sx={{
            display: params["tabName"] === "explore" ? "flex" : "none",
          }}
        />
      </Box>
    </Box>
  );
}
