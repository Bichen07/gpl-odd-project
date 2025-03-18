import { Card, CardContent } from "@mui/material";
import TrialFilters from "./TrialFilters";
import TimeSeriesClustering from "./TimeSeriesClustering";

export default () => {
  return (
    <Card elevation={0}>
      <CardContent>
        <TrialFilters />
        <TimeSeriesClustering />
      </CardContent>
    </Card>
  );
};
