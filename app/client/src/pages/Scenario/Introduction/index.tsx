import { Box, Typography, Grid, Stack, Card, CardContent } from "@mui/material";
import Labeler from "src/components/Labeler";
import { Fragment } from "react";
import defaultSchematic from "src/assets/default_schematic.jpg";
import { useAppSelector } from "src/redux/hooks";

export default () => {
  const scenario = useAppSelector((state) => state.scenario.data);

  if (!scenario) {
    return null;
  }

  const parameterTable = (
    <Grid
      container
      sx={{
        width: "100%",
        ".MuiGrid-root": {
          borderColor: "divider",
          borderWidth: "0.5px",
          borderStyle: "solid",
          padding: 1,
        },
      }}
    >
      <Grid item xs={2}>
        <Typography>Name</Typography>
      </Grid>
      <Grid item xs={2}>
        <Typography>Unit</Typography>
      </Grid>
      <Grid item xs={8}>
        <Typography>Description</Typography>
      </Grid>
      {scenario.parameters.map((parameter, index) => (
        <Fragment key={index}>
          <Grid item xs={2}>
            <Typography>{parameter.name}</Typography>
          </Grid>
          <Grid item xs={2}>
            <Typography>{parameter.unit}</Typography>
          </Grid>
          <Grid item xs={8}>
            <Typography>{parameter.description ?? "None"}</Typography>
          </Grid>
        </Fragment>
      ))}
    </Grid>
  );

  return (
    <>
      <Typography variant="h4" sx={{ mt: 2, mb: 2 }}>
        Introduction
      </Typography>
      <Card elevation={0}>
        <CardContent>
          <Stack spacing={3} sx={{ pb: 5 }}>
            <Labeler label="Description">
              {scenario?.description ?? "None"}
            </Labeler>
            <Stack
              direction={["column", "column", "row"]}
              justifyItems={["center", "flex-start"]}
              alignItems={["flex-start"]}
            >
              <Labeler
                label="Schematic"
                sx={{ flexGrow: 1, flexBasis: [0, 0, "700px"], flexShrink: 1 }}
              >
                <Box
                  sx={{
                    mr: [0, 0, 3],
                    mb: [3, 3, 0],
                    // width: "100%",
                    // height: "100%",
                  }}
                >
                  <img
                    style={{
                      // width: "100px",
                      width: "100%",
                      maxHeight: "300px",
                      // height: "100%",
                      objectFit: "contain",
                    }}
                    src={scenario.schematic.url ?? defaultSchematic}
                  />
                </Box>
              </Labeler>
              <Labeler label="Parameters" sx={{ width: "100%" }}>
                {parameterTable}
              </Labeler>
            </Stack>
          </Stack>
        </CardContent>
      </Card>
    </>
  );
};
