import { Box, Stack, Card, CardContent } from "@mui/material";
import Labeler from "src/components/Labeler";
import DefaultImage from "src/assets/default.jpg";
import ParameterTable from "./ParameterTable";
import CriticalityMetricTable from "./CriticalityMetricTable";
import { useAppSelector } from "src/redux/hooks";

export default () => {
  const scenario = useAppSelector((state) => state.batch.scenario);

  if (scenario === null) {
    return null;
  }

  const data = scenario;

  return (
    <Card elevation={0} sx={{ mt: 2, mb: 2 }}>
      <CardContent>
        <Stack spacing={3} sx={{ pb: 5 }}>
          <Labeler label="Description">{data.description ?? "None"}</Labeler>
          <Box>
            <Labeler
              label="Schematic"
              sx={{ flexGrow: 1, flexBasis: [0, 0, "700px"], flexShrink: 1 }}
            />
            <Box>
              <img
                style={{
                  width: "100%",
                  maxHeight: "50vh",
                  objectFit: "contain",
                }}
                src={data.schematic?.url ?? DefaultImage}
              />
            </Box>
          </Box>
          <Labeler label="Parameters" sx={{ width: "100%" }}>
            <ParameterTable sx={{ mt: 1 }} />
          </Labeler>
          <Labeler label="Criticality Metrics" sx={{ width: "100%" }}>
            <CriticalityMetricTable sx={{ mt: 1 }} />
          </Labeler>
        </Stack>
      </CardContent>
    </Card>
  );
};
