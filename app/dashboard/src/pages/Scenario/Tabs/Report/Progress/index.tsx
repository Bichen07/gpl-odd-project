import {
  Box,
  Card,
  CardContent,
  LinearProgress,
  Paper,
  Stack,
  SxProps,
  Typography,
} from "@mui/material";
import { useMemo } from "react";
import { useParams } from "react-router-dom";
import Labeler from "src/components/Labeler";
import { useAppSelector } from "src/redux/hooks";

function secondsToHM(seconds: number) {
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);

  return (
    <Typography fontSize={26}>
      {`${hours}`}
      <Typography display="inline" fontSize={18} sx={{ m: "0 5px" }}>
        hr{hours !== 1 ? "s" : ""}
      </Typography>
      {`${minutes}`}
      <Typography display="inline" fontSize={18} sx={{ m: "0 5px" }}>
        min{minutes !== 1 ? "s" : ""}
      </Typography>
    </Typography>
  );
}

function formatDate(date: Date) {
  if (!date) {
    return;
  }
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are zero-based
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return (
    <Stack>
      <Typography fontSize={20}>{`${year}-${month}-${day}`}</Typography>
      <Typography fontSize={20}>{`${hours}:${minutes}:${seconds}`}</Typography>
    </Stack>
  );
}

type Props = {
  sx?: SxProps;
};
export default function Progress({ sx }: Props) {
  const params = useParams();
  const scenario = useAppSelector((state) => state.batch.scenario);
  const batch = useAppSelector((state) => state.batch.batch);
  const trials = useAppSelector((state) => state.batch.trials);

  const [firstTrial, lastTrial, executionSeconds] = useMemo(() => {
    if (!trials) {
      return [undefined, undefined];
    }
    const sorted = [...trials].sort(
      (a, b) =>
        new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime(),
    );
    let newExecutionSeconds = 0;
    let pivotIndex = 0;
    for (let i = 0; i < sorted.length - 1; i += 1) {
      const nextMinutes =
        (new Date(sorted[i + 1].createdAt).getTime() -
          new Date(sorted[i].createdAt).getTime()) /
        (60 * 1000);
      if (nextMinutes > 30 || i === sorted.length - 2) {
        const pivotSeconds =
          (new Date(sorted[i].createdAt).getTime() -
            new Date(sorted[pivotIndex].createdAt).getTime()) /
          1000;
        newExecutionSeconds += pivotSeconds;
        pivotIndex = i + 1;
      }
    }
    return [sorted[0], sorted[sorted.length - 1], newExecutionSeconds];
  }, [trials]);

  const progressValue =
    (trials?.length ?? 0) / (batch?.requiredNumberOfTrials ?? 1);
  return (
    <Card elevation={0} sx={sx}>
      <CardContent sx={{ margin: "10px" }}>
        <Box component="div">
          <Labeler label="IDs">
            <Stack direction="row" rowGap={1} columnGap={1} flexWrap="wrap">
              <Typography
                component={Paper}
                sx={{
                  color: "text.disabled",
                  display: "inline-block",
                  padding: 1,
                  textWrap: "none",
                }}
              >
                Session ID: {params["sessionId"]}
              </Typography>
              <Typography
                component={Paper}
                sx={{
                  color: "text.disabled",
                  display: "inline-block",
                  padding: 1,
                }}
              >
                Batch ID: {params["batchId"]}
              </Typography>
              <Typography
                component={Paper}
                sx={{
                  color: "text.disabled",
                  display: "inline-block",
                  padding: 1,
                }}
              >
                Scenario ID: {scenario?.id ?? ""}
              </Typography>
            </Stack>
          </Labeler>
          <Stack
            direction="row"
            sx={{ mt: 2 }}
            justifyContent="space-between"
            flexWrap="wrap"
            rowGap={1}
            columnGap={1}
          >
            <Labeler label="Completed Trials">
              <Typography fontSize={30}>{trials?.length}</Typography>
            </Labeler>
            <Labeler label="Running Time">
              {secondsToHM(executionSeconds ?? 0)}
            </Labeler>
            <Labeler label="First Trial At">
              {formatDate(new Date(firstTrial?.createdAt))}
            </Labeler>
            <Labeler label="Last Trial At">
              {formatDate(new Date(lastTrial?.createdAt))}
            </Labeler>
            <Labeler label="Status">
              <Typography variant="h5">
                {batch?.status?.toUpperCase()}
              </Typography>
            </Labeler>
          </Stack>
          <Box
            component="div"
            sx={{ display: "flex", alignItems: "center", mt: 2 }}
          >
            <Typography variant="body2" color="text.secondary">
              Progress
            </Typography>
            <Box component="div" sx={{ width: "100%", mr: 1, ml: 2 }}>
              <LinearProgress
                sx={{ height: 10 }}
                variant="determinate"
                value={progressValue * 100}
              />
            </Box>
            <Typography
              variant="body2"
              color="text.secondary"
            >{`${trials?.length}/${batch?.requiredNumberOfTrials}`}</Typography>
          </Box>
        </Box>
      </CardContent>
    </Card>
  );
}
