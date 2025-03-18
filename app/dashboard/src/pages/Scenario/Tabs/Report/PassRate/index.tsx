import {
  Box,
  Card,
  CardContent,
  Divider,
  Stack,
  Typography,
} from "@mui/material";
import { SxProps, useTheme } from "@mui/material/styles";
import { BarChart, PieChart } from "@mui/x-charts";
import { useEffect, useState } from "react";
import Labeler from "src/components/Labeler";
import { useAppSelector } from "src/redux/hooks";
import { titleizeCamelCase } from "src/utils";
import ModalTable from "./ModalTable";

type Props = { sx?: SxProps };
export default function PassRate({ sx }: Props) {
  const theme = useTheme();
  const [passRate, setPassRate] = useState<{ [key: string]: number }>({});
  const [modalOpen, setModalOpen] = useState(false);
  const [openedKpiId, setOpenedKpiId] = useState("");
  const [openedPassed, setOpenedPassed] = useState(false);

  const trials = useAppSelector((state) => state.batch.trials);
  const criticalityMetrics = useAppSelector(
    (state) => state.batch.criticalityMetrics,
  );

  useEffect(() => {
    if (!trials || !criticalityMetrics) {
      return;
    }
    if (trials.length === 0) {
      setPassRate({});
      return;
    }
    const newPassRate: { [key: string]: number } = { total: 0 };
    for (const trial of trials) {
      let trialTotalPassed = true;
      for (const criticalityMetric of trial.testObjectives
        ?.criticalityMetrics ?? []) {
        const passed = criticalityMetric.passed ?? false;
        const kpiId = `${criticalityMetric.keyPerformanceIndicator}`;
        if (!(kpiId in criticalityMetrics)) {
          return;
        }
        const metricName = criticalityMetrics[kpiId].name;
        if (!(metricName in newPassRate)) {
          newPassRate[metricName] = 0;
        }
        newPassRate[metricName] += Number(passed);
        trialTotalPassed = trialTotalPassed && passed;
      }
      newPassRate["total"] += Number(trialTotalPassed);
    }
    for (const key in newPassRate) {
      newPassRate[key] /= trials.length;
    }
    setPassRate(newPassRate);
  }, [trials, criticalityMetrics]);

  const getPassRateItemComponent = (metricName: string) => {
    return (
      <Stack direction="row" key={metricName} rowGap={1} columnGap={1}>
        <Stack direction="row" rowGap={1}>
          <Labeler label={titleizeCamelCase(metricName) + " Pass Rate"}>
            <Typography variant="h4">
              {Math.floor(passRate[metricName] * 100)}%
            </Typography>
          </Labeler>
        </Stack>
        <Stack
          sx={{
            mt: 2,
            ml: 1,
            ".countItem": {
              padding: "0 10px",
              ":hover": {
                cursor: "pointer",
                boxShadow: "inset 0 0 0 10em rgba(255, 255, 255, 0.1)",
              },
            },
          }}
        >
          <Stack
            direction="row"
            alignItems="center"
            className="countItem"
            onClick={() => {
              setOpenedKpiId(
                Object.keys(criticalityMetrics ?? {}).find(
                  (key) =>
                    criticalityMetrics &&
                    criticalityMetrics[key].name === metricName,
                ) ?? "total",
              );
              setOpenedPassed(true);
              setModalOpen(true);
            }}
          >
            <Box
              component="div"
              sx={{
                width: "10px",
                height: "10px",
                borderRadius: "50%",
                backgroundColor: theme.palette.success.main,
                mr: 1,
              }}
            />
            <Typography sx={{ fontSize: "20px" }}>
              {Math.floor(passRate[metricName] * (trials?.length ?? 0))}
              <Typography sx={{ fontSize: 14, ml: 1 }} noWrap display="inline">
                passed
              </Typography>
            </Typography>
          </Stack>
          <Stack
            direction="row"
            alignItems="center"
            className="countItem"
            onClick={() => {
              setOpenedKpiId(
                Object.keys(criticalityMetrics ?? {}).find(
                  (key) =>
                    criticalityMetrics &&
                    criticalityMetrics[key].name === metricName,
                ) ?? "total",
              );
              setOpenedPassed(false);
              setModalOpen(true);
            }}
          >
            <Box
              component="div"
              sx={{
                width: "10px",
                height: "10px",
                borderRadius: "50%",
                backgroundColor: theme.palette.error.main,
                mr: 1,
              }}
            />
            <Typography sx={{ fontSize: "20px" }}>
              {Math.floor((1 - passRate[metricName]) * (trials?.length ?? 0))}
              <Typography sx={{ fontSize: 14, ml: 1 }} noWrap display="inline">
                failed
              </Typography>
            </Typography>
          </Stack>
        </Stack>
      </Stack>
    );
  };

  return (
    <Card elevation={0} sx={sx}>
      <CardContent>
        <ModalTable
          open={modalOpen}
          passed={openedPassed}
          kpiId={openedKpiId}
          onClose={() => setModalOpen(false)}
        />
        <Stack
          direction="row"
          rowGap={2}
          columnGap={10}
          flexWrap="wrap"
          sx={{ mb: 2, padding: "10px" }}
        >
          {Object.keys(passRate).map((key) => getPassRateItemComponent(key))}
        </Stack>
        <Stack
          flexWrap="wrap"
          alignItems="center"
          flexDirection={{
            xs: "column",
            md: "row",
          }}
        >
          <Stack
            component="div"
            alignItems="center"
            flexWrap="wrap"
            sx={{ position: "relative", flex: 1 }}
          >
            {!("total" in passRate) ? null : (
              <Box
                component="div"
                sx={{
                  position: "absolute",
                  top: "50%",
                  left: "50%",
                  transform: "translate(-50%, -50%)",
                }}
              >
                <Typography sx={{ fontSize: 14 }}>Total Pass Rate</Typography>
                <Typography sx={{ textAlign: "center", fontSize: 24 }}>
                  {Math.floor(passRate["total"] * 100)}%
                </Typography>
              </Box>
            )}
            <PieChart
              onItemClick={(_event, d) => {
                setOpenedKpiId("total");
                setOpenedPassed(d.dataIndex === 0 ? true : false);
                setModalOpen(true);
              }}
              margin={{ right: 10, left: 10, top: 10, bottom: 10 }}
              slotProps={{ legend: { hidden: true } }}
              height={300}
              series={[
                {
                  innerRadius: "60%",
                  outerRadius: "80%",
                  data:
                    "total" in passRate
                      ? [
                          {
                            id: "passed",
                            value: passRate["total"],
                            label: "Passed",
                            color: theme.palette.success.main,
                          },
                          {
                            id: "failed",
                            value: 1 - passRate["total"],
                            label: "Failed",
                            color: theme.palette.error.main,
                          },
                        ]
                      : [],
                },
              ]}
            />
          </Stack>
          <Divider
            orientation="vertical"
            flexItem
            sx={{ display: { xs: "none", md: "initial" } }}
          />
          <Stack
            component="div"
            rowGap={1}
            sx={{
              overflowY: "scroll",
              position: "relative",
              flex: 2.5,
              height: "300px",
              width: "100%",
              mb: 2,
            }}
          >
            <Typography
              sx={{
                color: "text.disabled",
                marginLeft: "20px",
                height: "20px",
              }}
            >
              Requirements
            </Typography>
            <Box
              component="div"
              sx={{
                minHeight: { xs: "none", md: "500px" },
              }}
            >
              {Object.keys(passRate)
                .filter((key) => key !== "total")
                .map((key) => {
                  return (
                    <Stack sx={{ margin: "20px 0" }}>
                      <Typography sx={{ ml: 3 }}>{key}</Typography>
                      <BarChart
                        layout="horizontal"
                        height={50}
                        margin={{ top: 0, bottom: 0 }}
                        slotProps={{ legend: { hidden: true } }}
                        leftAxis={{
                          disableLine: true,
                          disableTicks: true,
                          tickLabelStyle: {
                            display: "none",
                          },
                        }}
                        bottomAxis={{
                          disableLine: true,
                          disableTicks: true,
                        }}
                        onItemClick={(_event, d) => {
                          const metricName = Object.keys(passRate).filter(
                            (key) => key !== "total",
                          )[d.dataIndex];
                          const newKpiId =
                            Object.keys(criticalityMetrics ?? {}).find(
                              (key) =>
                                criticalityMetrics &&
                                criticalityMetrics[key].name === metricName,
                            ) ?? "total";
                          setOpenedKpiId(newKpiId);
                          setOpenedPassed(
                            d.seriesId === "failed" ? false : true,
                          );
                          setModalOpen(true);
                        }}
                        series={[
                          {
                            id: "passed",
                            highlightScope: {
                              highlighted: "item",
                            },
                            data: [passRate[key]],
                            stack: "A",
                            color: theme.palette.success.main,
                          },
                          {
                            id: "failed",
                            highlightScope: {
                              highlighted: "item",
                            },
                            data: [1 - passRate[key]],
                            stack: "A",
                            color: theme.palette.error.main,
                          },
                        ]}
                      />
                    </Stack>
                  );
                })}
            </Box>
          </Stack>
        </Stack>
      </CardContent>
    </Card>
  );
}
