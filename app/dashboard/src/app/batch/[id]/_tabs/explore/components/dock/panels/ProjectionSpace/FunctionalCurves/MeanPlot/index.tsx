// import { AxisLeft, AxisBottom } from "@visx/axis";
// import { useCallback, useEffect, useMemo, useRef, useState } from "react";
// import { Stack } from "@mui/material";
// import { localPoint } from "@visx/event";
// import { useTheme } from "@mui/material/styles";
// import { Group } from "@visx/group";
// import { curveBasis } from "@visx/curve";
// import { LinePath } from "@visx/shape";
// import { scaleLinear } from "@visx/scale";
// import { useAppSelector } from "@/app/batch/[id]/_tabs/explore/redux/hooks";
//
// const MARGIN = { top: 10, right: 30, bottom: 30, left: 50 };
// const ASPECT_RATIO = 2;
//
// type Props = {
//   data: {
//     [name: string]: {
//       color?: string;
//       line?: number[];
//     };
//   };
// };
// export const MeanPlot = ({ data }: Props) => {
//   const theme = useTheme();
//   const containerRef = useRef<HTMLDivElement>(null);
//   const svgRef = useRef<SVGSVGElement>(null);
//
//   const clustering = useAppSelector(
//     (state) => state.batch.trajectoryAnalysis?.mfpca
//   );
//   const trajectoryAnalysis = useAppSelector(
//     (state) => state.batch.trajectoryAnalysis
//   );
//   const durationMode = useAppSelector((state) => state.batch.durationMode);
//   const mfpca = useMemo(() => {
//     return trajectoryAnalysis?.mfpca[durationMode];
//   }, [trajectoryAnalysis, durationMode]);
//
//   const [dimension, setDimension] = useState<{ width: number; height: number }>(
//     { width: 250, height: 150 }
//   );
//   const boundsWidth = useMemo(
//     () => dimension.width - MARGIN.right - MARGIN.left,
//     [dimension]
//   );
//   const boundsHeight = useMemo(
//     () => dimension.height - MARGIN.top - MARGIN.bottom,
//     [dimension]
//   );
//
//   const timepoints = mfpca?.timePoints;
//
//   const xScale = useMemo(() => {
//     let domain = [0, 5];
//     if (timepoints && timepoints.length > 1) {
//       domain[0] = timepoints[0];
//       domain[1] = timepoints[timepoints.length - 1];
//     }
//     return scaleLinear<number>({
//       domain,
//       range: [0, boundsWidth],
//     });
//   }, [data, boundsWidth, timepoints]);
//
//   const yScale = useMemo(() => {
//     const accMax: number[] = [];
//     const accMin: number[] = [];
//     for (const value of Object.values(data)) {
//       accMax.push(...(value.line ?? []));
//       accMin.push(...(value.line ?? []));
//     }
//     return scaleLinear<number>({
//       domain: [Math.min(...accMin), Math.max(...accMax)],
//       range: [boundsHeight, 0],
//     });
//   }, [data, boundsHeight]);
//
//   // const resizeObserver = useMemo(
//   //   () =>
//   //     new ResizeObserver((entries) => {
//   //       for (let entry of entries) {
//   //         entry.target.dispatchEvent(new Event("resize"));
//   //         const { width, height } = entry.contentRect;
//   //         setDimension({ width, height: width / ASPECT_RATIO });
//   //       }
//   //     }),
//   //   [],
//   // );
//   // useEffect(() => {
//   //   if (!containerRef.current) {
//   //     return;
//   //   }
//   //   resizeObserver.observe(containerRef.current);
//   //   const { width, height } = containerRef.current.getBoundingClientRect();
//   //   setDimension({ width, height: width / ASPECT_RATIO });
//   //   return () => {
//   //     if (!containerRef.current) {
//   //       return;
//   //     }
//   //     resizeObserver.unobserve(containerRef.current);
//   //   };
//   // }, [containerRef.current]);
//
//   const handleMouseMove = useCallback(
//     (event: React.MouseEvent | React.TouchEvent) => {
//       if (!svgRef.current) {
//         return;
//       }
//       const point = localPoint(svgRef.current, event);
//       if (!point) {
//         return;
//       }
//     },
//     []
//   );
//
//   const xMax = dimension.width - MARGIN.left - MARGIN.right;
//   const yMax = dimension.height - MARGIN.top - MARGIN.bottom;
//
//   return (
//     <Stack ref={containerRef} sx={{ width: "100%" }}>
//       <svg
//         width={dimension.width}
//         height={dimension.height}
//         ref={svgRef}
//         onMouseDown={(event) => {
//           if (!svgRef.current) {
//             return;
//           }
//           const point = localPoint(svgRef.current, event);
//           if (!point) {
//             return;
//           }
//           const clipManualTime = ((point.x - MARGIN.left) / xMax) * 5;
//           // dispatch(sessionSlice.actions.setClipManualTime(clipManualTime));
//         }}
//         onDoubleClick={(event) => {
//           // dispatch(sessionSlice.actions.setClipManualTime(null));
//         }}
//       >
//         <Group
//           width={boundsWidth}
//           height={boundsHeight}
//           onMouseMove={handleMouseMove}
//           onTouchMove={handleMouseMove}
//           transform={`translate(${[MARGIN.left, MARGIN.top].join(",")})`}
//         >
//           <AxisBottom
//             top={boundsHeight}
//             scale={xScale}
//             numTicks={dimension.width > 520 ? 10 : 5}
//           />
//           <AxisLeft
//             // left={dimension.width - MARGIN.left - MARGIN.right}
//             scale={yScale}
//           />
//           {Object.values(data).map((item) => (
//             <>
//               <LinePath
//                 data={Array.from(item.line?.entries() ?? [])}
//                 curve={curveBasis}
//                 x={(d) => xScale(timepoints == null ? d[0] : timepoints[d[0]])}
//                 y={(d) => yScale(d[1]) ?? 0}
//                 stroke={item.color ?? theme.palette.divider}
//                 strokeWidth={1.5}
//                 strokeOpacity={0.8}
//               />
//             </>
//           ))}
//         </Group>
//       </svg>
//     </Stack>
//   );
// };
