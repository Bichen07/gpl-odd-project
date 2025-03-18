import { Card, CardContent, Grid } from "@mui/material";
import ParameterScatter3D from "./ParameterScatter3D";
import TimeSeriesPCA from "./TimeSeriesPCA";
import Radar from "./Radar";

export default () => {
  return (
    <Card>
      <CardContent>
        <Grid container spacing={2}>
          <Grid item xs={6}>
            <ParameterScatter3D />
          </Grid>
          <Grid item xs={6}></Grid>
          <Grid item xs={12}>
            <Radar />
          </Grid>
          <Grid item xs={12}>
            <TimeSeriesPCA />
          </Grid>
        </Grid>
      </CardContent>
    </Card>
  );
};
