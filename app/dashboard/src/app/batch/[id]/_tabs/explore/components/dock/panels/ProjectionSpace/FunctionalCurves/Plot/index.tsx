// import { useEffect, useMemo, useRef, useState } from "react";
// import { Stack } from "@mui/material";
// import { useTheme } from "@mui/material/styles";
// import { Data, Layout } from "plotly.js";
// import Plot from "react-plotly.js";
// import { useAppSelector } from "@/app/batch/[id]/_tabs/explore/redux/hooks";
//
// type Props = {
//   data:
//     | {
//         attribute: string;
//         color?: string;
//         line?: number[];
//         sortValue?: number;
//       }[]
//     | null;
// };
// export const FpcPlot = ({ data }: Props) => {
//   const theme = useTheme();
//   const containerRef = useRef<HTMLDivElement>(null);
//
//   const trajectoryAnalysis = useAppSelector(
//     (state) => state.batch.trajectoryAnalysis
//   );
//   const durationMode = useAppSelector((state) => state.batch.durationMode);
//   const mfpca = useMemo(() => {
//     return trajectoryAnalysis?.mfpca[durationMode];
//   }, [trajectoryAnalysis, durationMode]);
//
//   const [plotData, setPlotData] = useState<{
//     layout: Partial<Layout>;
//     data: Data[] | null;
//   } | null>(null);
//
//   const timepoints = mfpca?.timePoints;
//
//   useEffect(() => {
//     if (data == null) {
//       return;
//     }
//     const newData: Data[] = [];
//
//     for (const dataItem of data) {
//       newData.push({
//         x: timepoints,
//         y: dataItem.line,
//         type: "scatter",
//         name: dataItem.attribute,
//       });
//     }
//     newData.sort((a, b) => ((a.name ?? "") > (b.name ?? "") ? 1 : -1));
//
//     const layout: Partial<Layout> = {
//       width: 600,
//       height: 300,
//       plot_bgcolor: theme.palette.background.paper,
//       paper_bgcolor: theme.palette.background.paper,
//       font: {
//         color: theme.palette.text.secondary,
//       },
//       // showlegend: false,
//       margin: { l: 30, r: 0, t: 30, b: 30, pad: 0 },
//     };
//     setPlotData({ data: newData, layout });
//   }, [data]);
//
//   return (
//     <Plot
//       useResizeHandler
//       layout={
//         plotData?.layout ?? {
//           plot_bgcolor: theme.palette.background.default,
//           paper_bgcolor: theme.palette.background.default,
//           font: {
//             color: theme.palette.text.secondary,
//           },
//         }
//       }
//       data={plotData?.data ?? []}
//     />
//   );
// };
