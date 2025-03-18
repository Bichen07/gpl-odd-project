import { Stack, Typography, CircularProgress } from "@mui/material";
import { useTheme } from "@mui/material/styles";
import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import { Plot } from "./Plot";
import { getDoc } from "src/api/common";
import { Trial } from "src/__generated__/graphql";
import { getTrajectoryFromTrial } from "src/api/services/Trials";
// import { getSelectedClusteringResult } from "src/redux/slices/session";

export function TimeSeries() {
  const theme = useTheme();

  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const selectedCluster = useAppSelector(
    (state) => state.session.selectedCluster,
  );
  const selectedBoundarySafeCluster = useAppSelector(
    (state) => state.session.selectedBoundarySafeCluster,
  );
  const clusteringResult = useAppSelector(getSelectedClusteringResult);

  const focusedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const focusedBoundaryPair = useMemo(() => {
    if (
      focusedTrialId &&
      clusteringResponse &&
      clusteringResponse.boundaryPairs.passed &&
      focusedTrialId in clusteringResponse.boundaryPairs.passed
    ) {
      return clusteringResponse.boundaryPairs.passed[focusedTrialId];
    }
    return null;
  }, [focusedTrialId, clusteringResponse]);
  const [loading, setLoading] = useState(false);

  const [plotData, setPlotData] = useState<{
    [featureName: string]: {
      [name: string]: {
        color?: string;
        line?: number[];
      };
    };
  }>();

  useEffect(() => {
    if (!clusteringResponse) {
      return;
    }
    const trajectoryQueries = clusteringResponse.trajectoryQueries;
    const features = ["speed", "acceleration", "yaw", "yawRate", "x", "y"];
    const fetchPlotData = async () => {
      setLoading(true);
      const newPlotData: typeof plotData = {};
      for (const feature of features) {
        if (focusedTrialId && focusedBoundaryPair) {
          const focusedTrajectoryData = await getTrajectoryFromTrial(
            focusedTrialId,
            trajectoryQueries[focusedTrialId],
          ).then((response) => response.data);
          const pairTrajectoryData = await getTrajectoryFromTrial(
            focusedBoundaryPair,
            trajectoryQueries[focusedBoundaryPair],
          ).then((response) => response.data);
          newPlotData[feature] = {
            pair: {
              color:
                focusedBoundaryPair in clusteringResponse.boundaryPairs.passed
                  ? theme.palette.success.main
                  : theme.palette.error.main,
              line: pairTrajectoryData["trajectory"]["Ego"].map(
                (item) => item[feature],
              ),
            },
            main: {
              color:
                focusedTrialId in clusteringResponse.boundaryPairs.passed
                  ? theme.palette.success.main
                  : theme.palette.error.main,
              line: focusedTrajectoryData["trajectory"]["Ego"].map(
                (item) => item[feature],
              ),
            },
          };
        } else if (focusedTrialId) {
          const focusedTrajectoryData = await getTrajectoryFromTrial(
            focusedTrialId,
            trajectoryQueries[focusedTrialId],
          ).then((response) => response.data);
          newPlotData[feature] = {
            passed: {
              color:
                focusedTrialId in clusteringResponse.boundaryPairs.passed
                  ? theme.palette.success.main
                  : theme.palette.error.main,
              line: focusedTrajectoryData["trajectory"]["Ego"].map(
                (item) => item[feature],
              ),
            },
          };
        }
      }
      setPlotData(newPlotData);
    };

    fetchPlotData();
  }, [focusedTrialId, focusedBoundaryPair]);

  useEffect(() => {
    setLoading(false);
  }, [plotData]);

  const getUnit = (featureName: string) => {
    if (["x", "y"].includes(featureName)) {
      return "m";
    } else if (["speed"].includes(featureName)) {
      return "kph";
    } else if (["yaw"].includes(featureName)) {
      return "deg";
    } else if (["yawRate"].includes(featureName)) {
      return "deg/s";
    } else if (["acceleration"].includes(featureName)) {
      return "mps2";
    } else if (["steerCommand"].includes(featureName)) {
      return "deg/s";
    }
    return null;
  };

  return (
    <Stack
      sx={{
        position: "relative",
        width: "100%",
        height: "100%",
      }}
    >
      <Stack
        sx={{
          filter: loading ? "blur(2px)" : "none",
        }}
      >
        {Object.entries(plotData ?? {}).map(
          ([featureName, featurePlotData]) => {
            return (
              <Stack sx={{ p: 1 }}>
                <Typography>{`${featureName} [${getUnit(
                  featureName,
                )}]`}</Typography>
                <Plot
                  key={featureName}
                  data={featurePlotData}
                  feature={featureName}
                />
              </Stack>
            );
          },
        )}
      </Stack>
      {loading ? (
        <Stack
          justifyContent="center"
          alignItems="center"
          spacing={2}
          sx={{
            position: "absolute",
            zIndex: 100,
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            // backgroundColor: "divider",
          }}
        >
          <CircularProgress />
          <Typography color="primary.main" fontWeight={700}>
            Loading...
          </Typography>
        </Stack>
      ) : null}
    </Stack>
  );
}
