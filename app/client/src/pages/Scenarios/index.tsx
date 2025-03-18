import {
  Box,
  Button,
  Card,
  CardContent,
  CardMedia,
  Container,
  Grid,
  Skeleton,
  Stack,
  Typography,
} from "@mui/material";
import defaultSchematic from "src/assets/default_schematic.jpg";
import AddCircleIcon from "@mui/icons-material/AddCircle";
import Pagination from "@mui/material/Pagination";
import { Link } from "react-router-dom";
import { useState } from "react";
import { toast } from "react-toastify";
import Breadcrumbs from "src/components/Breadcrumbs";
import { useQuery } from "@tanstack/react-query";
import ScenarioService from "src/axios/services/Scenarios";
import { useAppSelector } from "src/redux/hooks";
import { Media } from "payload/payload-types";

const Scenarios = () => {
  const [page, setPage] = useState<number>(1);
  const clientId = useAppSelector((state) => state.client.selectedId);

  const { isLoading, isError, data, error } = useQuery({
    queryKey: ["scenarios"],
    queryFn: () =>
      ScenarioService.getScenarios({
        page,
        where: { clients: { in: [clientId] } },
      }).then((response) => response.data),
  });

  if (isError) {
    toast.error(error.message);
  }

  const gridSize = {
    xs: 12,
    sm: 5,
    md: 4,
    lg: 3,
  };

  return (
    <Container
      sx={{
        pt: 3,
        pb: 3,
        display: "flex",
        flexDirection: "column",
        minHeight: "100vh",
      }}
    >
      <Box sx={{ pb: 3 }}>
        <Breadcrumbs />
      </Box>
      <Stack direction="row" alignItems="center" justifyContent="space-between">
        <Typography variant="h3">Scenarios</Typography>
        <Link to="/create_scenario">
          <Button
            variant="contained"
            startIcon={<AddCircleIcon />}
            size="small"
            sx={{ height: 1 }}
          >
            Add
          </Button>
        </Link>
      </Stack>
      <Grid container sx={{ pt: 3, flexGrow: 1 }} spacing={2}>
        {isLoading ? (
          <Grid item {...gridSize}>
            <Skeleton animation="wave" variant="rectangular" height={140} />
            <Box sx={{ pt: 0.5 }}>
              <Skeleton animation="wave" />
              <Skeleton animation="wave" width="60%" />
            </Box>
          </Grid>
        ) : !data || data.docs.length === 0 ? (
          <Stack
            justifyContent="center"
            alignItems="center"
            sx={{ width: "100%" }}
          >
            <Typography variant="h2" color="text.disabled">
              Empty
            </Typography>
          </Stack>
        ) : (
          data.docs.map((doc, index) => {
            return (
              <Grid item key={index} {...gridSize}>
                <Link to={`/scenarios/${doc?.id}`}>
                  <Card
                    elevation={0}
                    sx={{
                      transition: "transform 0.3s ease",
                      "&:hover": {
                        transform: [
                          "translateY(0px)",
                          "translateY(-5px)",
                          null,
                          null,
                          null,
                        ],
                        cursor: "pointer",
                      },
                    }}
                  >
                    <Grid container>
                      <Grid item xs={5} sm={12}>
                        <CardMedia
                          component="img"
                          image={
                            (doc.schematic as Media).sizes?.thumbnail?.url ??
                            defaultSchematic
                          }
                          sx={{
                            // height: [120, 160],
                            height: [120, 160],
                            objectFit: "contain",
                            // img: {
                            // },
                          }}
                          title="schematic"
                        />
                      </Grid>
                      <Grid item xs={7} sm={12}>
                        <CardContent>
                          <Typography variant="subtitle1">
                            {doc?.name}
                          </Typography>
                        </CardContent>
                      </Grid>
                    </Grid>
                  </Card>
                </Link>
              </Grid>
            );
          })
        )}
      </Grid>
      <Box
        sx={{
          width: "100%",
          justifyContent: "center",
        }}
      >
        {isLoading || !data || (data.totalPages ?? 0 < 1) ? null : (
          <Pagination
            sx={{
              display: `${data.totalPages ?? 0 > 1 ? "flex" : "none"}`,
            }}
            count={isLoading ? undefined : data.totalPages ?? undefined}
            variant="outlined"
            shape="rounded"
            onChange={(_event, newPage) => setPage(newPage)}
          />
        )}
      </Box>
    </Container>
  );
};

export default Scenarios;
