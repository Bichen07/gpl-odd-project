import { XYChart, Axis, BarSeries, Grid } from "@visx/xychart";
import { useEffect, useMemo, useRef, useState } from "react";
import { scaleLinear, scaleBand } from "@visx/scale";
import { Stack } from "@mui/material";
import { useAppSelector } from "src/redux/hooks";

type ScreeDataItem = { comoponent: string; variance: number };
export default function ScreePlot() {
  const containerRef = useRef<HTMLDivElement>(null);

  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const [screeData, setScreeData] = useState<ScreeDataItem[]>([]);

  useEffect(() => {
    if (clusteringResponse == null) {
      return;
    }
    setScreeData(
      clusteringResponse.mfpca.explainedVarianceRatio.map((item, i) => ({
        comoponent: `FPC${i}`,
        variance: item,
      })),
    );
  }, [clusteringResponse]);

  const [dimension, setDimension] = useState<{ width: number; height: number }>(
    { width: 0, height: 0 },
  );
  const resizeObserver = useMemo(
    () =>
      new ResizeObserver((entries) => {
        for (let entry of entries) {
          entry.target.dispatchEvent(new Event("resize"));
          const { width, height } = entry.contentRect;
          setDimension({ width, height });
        }
      }),
    [],
  );

  useEffect(() => {
    if (!containerRef.current) {
      return;
    }
    resizeObserver.observe(containerRef.current);
    const { width, height } = containerRef.current.getBoundingClientRect();
    setDimension({ width, height });
    return () => {
      if (!containerRef.current) {
        return;
      }
      resizeObserver.unobserve(containerRef.current);
    };
  }, [containerRef.current]);

  const padding = 20;
  const scales = useMemo(() => {
    const x = scaleBand<string>({
      range: [0 + padding, dimension.width - padding],
      round: true,
      domain: screeData.map((d) => d.comoponent),
      padding: 0.4,
    });

    const y = scaleLinear<number>({
      domain: [0, 1],
      range: [dimension.height - padding, 0 + padding],
      clamp: true,
    });

    return {
      x,
      y,
    };
  }, [dimension, screeData]);

  return (
    <Stack ref={containerRef} sx={{ width: "100%", height: "100%" }}>
      <XYChart
        height={300}
        width={500}
        xScale={{ type: "band" }}
        yScale={{ type: "linear" }}
      >
        <Grid columns={false} numTicks={4} />
        <BarSeries
          dataKey="Variance"
          data={screeData}
          xAccessor={(d: ScreeDataItem) => scales.x(d.comoponent)}
          yAccessor={(d: ScreeDataItem) => scales.y(d.variance)}
        />
        <Axis orientation="bottom" />
        <Axis orientation="left" />
      </XYChart>
    </Stack>
  );
}
