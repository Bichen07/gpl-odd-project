import React, { useCallback } from "react";
import { ReactNode, useEffect, useMemo, useRef, useState } from "react";
import FilterListIcon from "@mui/icons-material/FilterList";
import SportsScoreIcon from "@mui/icons-material/SportsScore";
import {
  Glyph,
  GlyphCircle,
  GlyphStar,
  GlyphTriangle,
  GlyphSquare,
  GlyphWye,
  GlyphDiamond,
  GlyphCross,
} from "@visx/glyph";
import { KeyPerformanceIndicator } from "src/__generated__/graphql";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { SxProps, useTheme } from "@mui/material/styles";
import {
  MRT_Cell,
  MRT_RowData,
  type MRT_ColumnDef,
  useMaterialReactTable,
  getMRT_RowSelectionHandler,
  MaterialReactTable,
  MRT_RowVirtualizer,
  MRT_SortingState,
  MRT_ColumnFiltersState,
} from "material-react-table";
import {
  Box,
  Stack,
  Checkbox,
  FormControlLabel,
  TextField,
  Typography,
  MenuItem,
  Menu,
  Button,
  IconButton,
  FormControl,
  InputLabel,
  Select,
  Divider,
  FormLabel,
  RadioGroup,
  Radio,
} from "@mui/material";
import {
  sessionSlice,
  ViewerMode,
  viewerModes,
} from "src/redux/slices/session";
import { findPairsFromTwoGroups } from "src/utils";
import { Clear } from "@mui/icons-material";

export function formatDate(date: Date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are zero-based
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

const options = [
  "all",
  "boundary",
  "boundaryDrastic",
  "boundaryModerate",
  "drastic",
] as const;
type Option = (typeof options)[number];

type Props = {
  sx?: SxProps;
  kpiId?: string;
  passed?: boolean;
};
export default function CaseScope({ sx }: Props) {
  const theme = useTheme();
  const dispatch = useAppDispatch();
  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const shapeStrings = useAppSelector((state) => state.session.shapeStrings);

  const metrics = useAppSelector((state) => state.session.metrics);
  const pairMode = useAppSelector((state) => state.session.pairMode);
  const viewerMode = useAppSelector((state) => state.session.viewerMode);

  const [option, setOption] = useState<Option>("boundary");

  const reverseBoundaryMode = useAppSelector(
    (state) => state.session.reverseBoundaryMode,
  );
  const selectedMetric = useAppSelector(
    (state) => state.session.selectedMetric,
  );
  const trajectoryAnalysisResponse = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const tree = useAppSelector((state) => state.session.tree);
  const treePoints = useAppSelector((state) => state.session.treePoints);
  const selectedBoundaryMetric = useAppSelector(
    (state) => state.session.selectedSafetyBoundaryMetric,
  );
  const kNeighbors = useAppSelector(
    (state) => state.session.boundaryKNeighbors,
  );
  const boundaryFilteringEnabled = useAppSelector(
    (state) => state.session.boundaryFilteringEnabled,
  );

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [menuOpened, setMenuOpened] = useState<string | null>(null);
  const handleMenuAnchorClick = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };

  // const rowVirtualizerInstanceRef = useRef<MRT_RowVirtualizer>(null);
  // const [sorting, setSorting] = useState<MRT_SortingState>([]);

  // useEffect(() => {
  //   //scroll to the top of the table when the sorting changes
  //   try {
  //     rowVirtualizerInstanceRef.current?.scrollToIndex?.(0);
  //   } catch (error) {
  //     console.error(error);
  //   }
  // }, [sorting]);

  const selectedTrialId = useAppSelector(
    (state) => state.session.selectedTrialId,
  );
  const selectedPairTrialId = useAppSelector(
    (state) => state.session.selectedPairTrialId,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const clusterInfo = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusterInfo,
  );
  const clusteringResult = useAppSelector(
    (state) => state.session.selectedTrajectoryAnalysisClusteringResult,
  );
  const boundaryTrialIds = useAppSelector(
    (state) => state.session.boundaryTrialIds,
  );
  const filteredTrialIds = useAppSelector(
    (state) => state.session.filteredTrialIds,
  );
  const freeformTrialIds = useAppSelector(
    (state) => state.session.freeformTrialIds,
  );
  const pairTrialMapping = useAppSelector(
    (state) => state.session.pairTrialMapping,
  );
  const safe2unsafeMapping = useAppSelector(
    (state) => state.session.safe2unsafeMappings,
  );
  const cluster2cluster = useAppSelector(
    (state) => state.session.cluster2cluster,
  );
  const selectedC2CLabel = useAppSelector(
    (state) => state.session.cluster2clusterSelectedLabel,
  );
  // const [columnFilterTriggered, setColumnFilterTriggered] = useState(false);

  // useEffect(() => {
  //   if (!selectedMetric || !clusteringResult) {
  //     return;
  //   }
  //   let pairMappings = pairTrialMapping[selectedMetric.kpi.name];
  //   if (viewerMode == "pass/fail") {
  //     pairMappings = safe2unsafeMapping;
  //   }
  //
  //   const result: { [label: string]: { [saferTrialId: string]: string } } = {};
  //
  //   for (const [safer, unsafer] of Object.entries(pairMappings)) {
  //     if (
  //       unsafer == null ||
  //       !Object.keys(clusteringResult.data).includes(safer) ||
  //       !Object.keys(clusteringResult.data).includes(unsafer)
  //     ) {
  //       continue;
  //     }
  //     const saferCluster = clusteringResult.data[safer].label;
  //     const unsaferCluster = clusteringResult.data[unsafer].label;
  //     if (saferCluster === unsaferCluster && !boundaryFilteringEnabled) {
  //       continue;
  //     }
  //     const label = `${saferCluster}-${unsaferCluster}`;
  //     if (!(label in result)) {
  //       result[label] = {};
  //     }
  //     result[label][safer] = unsafer;
  //   }
  //
  //   dispatch(sessionSlice.actions.setCluster2Cluster(result));
  // }, [
  //   viewerMode,
  //   clusteringResult,
  //   selectedMetric,
  //   trajectoryAnalysis,
  //   safe2unsafeMapping,
  //   pairTrialMapping,
  // ]);

  useEffect(() => {
    setIsLoading(true);
    if (!trajectoryAnalysis) {
      return;
    }

    const parameters = trajectoryAnalysis.clustering.parameters;
    const batches = Object.values(trajectoryAnalysis.batches ?? {});
    if (
      parameters == null ||
      batches == null ||
      batches.length === 0 ||
      batches[0] == null
    ) {
      return;
    }
    const scenario = batches[0].scenario;
    if (scenario == null) {
      return;
    }
    const newData: any[] = [];

    // const usedTrials =
    //   selectedTrialId && selectedPairTrialId
    //     ? [
    //       trajectoryAnalysis.trials[selectedTrialId],
    //       trajectoryAnalysis.trials[selectedPairTrialId],
    //     ]
    //     : Object.values(trajectoryAnalysis.trials);
    const usedTrials = Object.values(trajectoryAnalysis.trials);
    const cTrials = new Set(Object.keys(trajectoryAnalysis.clustering.scores));
    // boundaryTrialIds.includes(t.id ?? ""),
    // filteredTrialIds.length == 0 || filteredTrialIds.includes(t.id ?? ""),
    for (const doc of usedTrials.filter((t) =>
      // boundaryTrialIds.includes(t.id ?? ""),
      cTrials.has(t.id ?? ""),
    )) {
      if (
        scenario.parameters === undefined ||
        scenario.parameters === null ||
        scenario.testObjectives?.criticalityMetrics === undefined ||
        scenario.testObjectives.criticalityMetrics === null ||
        doc.id === undefined ||
        doc.id === null
      ) {
        continue;
      }

      let newRow: any = {};

      if (!(doc.id in trajectoryAnalysis.clustering.gradients.data)) {
        continue;
      }

      newRow["id"] = doc.id;
      if (clusterInfo && clusteringResult) {
        newRow["cluster"] = clusteringResult.data[doc.id].label;
        // newRow["membership"] = clusteringResult.data[doc.id].probability;
      }

      let egoGradientMagnitude = 0;
      for (const row of trajectoryAnalysis.clustering.gradients.data[doc.id]) {
        // for (const value of row) {
        //   egoGradientMagnitude += value * value;
        // }
      }
      egoGradientMagnitude = Math.sqrt(egoGradientMagnitude);

      for (const [index, parameter] of scenario.parameters.entries()) {
        if (
          parameter.name === undefined ||
          parameter.name === null ||
          index > doc.parameters.length - 1
        ) {
          continue;
        }
        let unit = parameter.unit;
        let value = doc.parameters[index].value;
        if (unit === "kph" && value != null) {
          value = value / 3.6;
        }
        unit = unit === "kph" ? "m/s" : unit;
        newRow[parameter.name + ` [${unit}]`] = value;
      }

      for (const metricName of Object.keys(
        trajectoryAnalysis.clustering.metricGradients,
      )) {
        if (metricName !== selectedMetric?.kpi.name) {
          continue;
        }
        const metric = scenario.testObjectives.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator?.name === metricName,
        );
        let unit = metric?.keyPerformanceIndicator?.unit;
        let value = doc.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.name === metricName,
        )?.value;
        newRow[`${metricName} [${unit}]`] = value;
        let metricGradientMagnitude = 0;
        for (const [pi, value] of trajectoryAnalysis.clustering.metricGradients[
          metricName
        ].data[doc.id].entries()) {
          metricGradientMagnitude += value[0] * value[0];

          if (parameters == null) {
            console.log("no parameters");
            return;
          }
          const parameter = scenario.parameters.find(
            (p) => p.name === parameters[pi].name,
          );
          newRow[`d(${metricName})/d(${parameters[pi].name})`] = value[0];
          // newRow[`d(${metricName})/d(${parameters[pi].name})`] =
          //   value[0] / ((parameter?.max ?? 1) - (parameter?.min ?? 0));
        }
        metricGradientMagnitude = Math.sqrt(metricGradientMagnitude);
        newRow[`||∇${metricName}||`] = metricGradientMagnitude;
      }

      for (const metricName of Object.keys(
        trajectoryAnalysis.clustering.metricGradients,
      )) {
        if (metricName !== selectedBoundaryMetric?.kpi.name) {
          continue;
        }
        let metricGradientMagnitude = 0;
        const metric = scenario.testObjectives.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator?.name === metricName,
        );
        let unit = metric?.keyPerformanceIndicator?.unit;
        let value = doc.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.name === metricName,
        )?.value;
        let passed = doc.testObjectives?.criticalityMetrics.find(
          (m) => m.keyPerformanceIndicator.name === metricName,
        )?.passed;
        newRow[`${metricName} [${unit}]`] = value;
        newRow[`${metricName} passed`] = passed;
      }

      newRow["FPCGradMag"] = egoGradientMagnitude;

      newData.push(newRow);
    }
    setTableData(newData);

    // setColumnFilterTriggered(false);
  }, [
    // trajectoryAnalysis,
    // selectedPairTrialId,
    // filteredTrialIds,
    clusterInfo,
    // boundaryTrialIds,
    selectedMetric,
    selectedBoundaryMetric,
  ]);

  useEffect(() => {
    setIsLoading(false);
  }, [tableData]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    const getCellRenderer = (key: string) => {
      if (key.includes("id")) {
        return undefined;
      } else if (key.includes("At")) {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) =>
          formatDate(new Date(cell.getValue<string>()));
      } else if (key === "cluster") {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) => {
          const shapeProps = {
            fill: clusterInfo ? clusterInfo[cell.getValue()].color : "black",
            left: 6,
            top: 6,
            // width: "12px",
            // height: "12px",
            // style: {
            //   width: "12px",
            //   height: "12px",
            // },
          };

          const shapeIndex = Number(cell.getValue());
          const shapeString = shapeStrings[shapeIndex];

          let shape: ReactNode | null = null;
          if (shapeString === "circle") {
            shape = <GlyphCircle {...shapeProps} />;
          } else if (shapeString === "square") {
            shape = <GlyphSquare {...shapeProps} />;
          } else if (shapeString === "wye") {
            shape = <GlyphWye {...shapeProps} />;
          } else if (shapeString === "triangle") {
            shape = <GlyphTriangle {...shapeProps} />;
          } else if (shapeString === "diamond") {
            shape = <GlyphDiamond {...shapeProps} />;
          } else if (shapeString === "cross") {
            shape = <GlyphCross {...shapeProps} />;
          } else if (shapeString === "star") {
            shape = <GlyphStar {...shapeProps} />;
          }

          return (
            <Stack direction="row" alignItems="center">
              <Stack flexDirection="column">
                <svg width={"12px"} height={"12px"}>
                  {shape}
                </svg>
              </Stack>
              <Typography sx={{ fontSize: "14px", ml: 1 }}>
                {cell.getValue()}
              </Typography>
            </Stack>
          );
        };
      } else if (key.includes("passed")) {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) => {
          return cell.getValue<boolean>() ? (
            <Typography
              sx={{ color: theme.palette.success.main, fontSize: "14px" }}
            >
              Passed
            </Typography>
          ) : (
            <Typography
              sx={{ color: theme.palette.error.main, fontSize: "14px" }}
            >
              Failed
            </Typography>
          );
        };
      } else {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) => {
          return (
            cell.getValue<number>() == null ? NaN : cell.getValue<number>()
          ).toFixed(4);
        };
      }
    };
    const getFilterOptions = (key: string) => {
      if (key.includes("id") || key.includes("At") || key.includes("result")) {
        return undefined;
      }
      if (key.includes("cluster")) {
        return {
          filterVariant: "multi-select",
          filterSelectOptions: Object.keys(clusterInfo ?? []),
          filterFn: "arrIncludesSome",
        };
      }
      return {
        filterVariant: "range",
        filterFn: "between",
      };
    };
    return tableData.length === 0
      ? []
      : Object.keys(tableData[0]).map((key) => ({
          accessorKey: key,
          header: key,
          Cell: getCellRenderer(key),
          size: key.includes("/") ? 300 : key === "cluster" ? 130 : 200,
          ...getFilterOptions(key),
        }));
  }, [tableData]);

  const table = useMaterialReactTable({
    columns,
    data: tableData ?? [],
    getRowId: (row) => row.id,
    enableDensityToggle: false,
    enableFullScreenToggle: false,
    columnFilterDisplayMode: "popover",
    enableRowActions: true,
    enableHiding: false,
    enableGlobalFilter: false,
    // enableTopToolbar: false,

    // enableColumnFilters: false,
    // enableRowSelection: true,

    positionPagination: "top",
    enableMultiRowSelection: false, //shows radio buttons instead of checkboxes
    initialState: {
      density: "compact",
      columnPinning: {
        right: ["mrt-row-actions"],
      },
    },
    renderRowActionMenuItems: ({ row }) => [
      <MenuItem
        key="pair"
        onClick={() => {
          if (selectedPairTrialId != null) {
            dispatch(sessionSlice.actions.setSelectedPairTrialId(null));
          } else {
            dispatch(sessionSlice.actions.setSelectedTrialId(row.original.id));
            dispatch(sessionSlice.actions.findAndSetSelectedPairTrialId());
          }
        }}
      >
        {`${
          selectedPairTrialId
            ? "Cancel Showing Pair"
            : "Show Nearest Gradient Paired Case"
        }`}
      </MenuItem>,
    ],
    muiTableBodyRowProps: ({ row, staticRowIndex, table }) => ({
      onClick: (event) =>
        getMRT_RowSelectionHandler({ row, staticRowIndex, table })(event), //import this helper function from material-react-table
      sx: { cursor: "pointer" },
    }),
    muiTableBodyCellProps: ({ cell }) => {
      const value = cell.getValue();
      return {
        sx: {
          backgroundColor: "background.paper",
          color:
            value === "Passed" || value === "True"
              ? "success.main"
              : value === "Failed" || value === "False"
                ? "error.main"
                : "inherit",
        },
      };
    },
    muiTablePaperProps: () => ({
      elevation: 0,
    }),
    muiTopToolbarProps: () => ({
      sx: {
        minHeight: 0,
        ".MuiTablePagination-root": {
          margin: 0,
          marginRight: "auto",
          paddingTop: 0,
          paddingBottom: 0,
        },
        ".MuiBox-root": {
          minHeight: 0,
          p: 0,
        },
      },
    }),
    muiPaginationProps: {
      // color: "primary",
      // shape: "rounded",
      // showRowsPerPage: false,
      // variant: "outlined",
      sx: {
        paddingTop: 0,
        paddingBottom: 0,
      },
    },

    // defaultDisplayColumn: { enableResizing: true },
    enableBottomToolbar: false,
    enableColumnResizing: true,
    // enableColumnVirtualization: true,
    // enableGlobalFilterModes: true,
    // enablePagination: false,
    // enableColumnPinning: true,
    enableStickyHeader: true,
    state: { isLoading },
    muiTableContainerProps: { sx: { maxHeight: "100%" } },
    enableRowNumbers: true,
    // enableRowVirtualization: true,
    // muiTableContainerProps: { sx: { maxHeight: "600px" } },
    // onSortingChange: setSorting,
    // state: { isLoading, sorting },
    // rowVirtualizerInstanceRef, //optional
    // rowVirtualizerOptions: { overscan: 5 }, //optionally customize the row virtualizer
    // columnVirtualizerOptions: { overscan: 2 }, //optionally customize the column virtualizer
    renderTopToolbarCustomActions: ({ table }) => (
      <Stack
        sx={{ position: "absolute", right: "0px" }}
        direction="row"
        rowGap={1}
      >
        <IconButton
          size="small"
          onClick={(event) => {
            handleMenuAnchorClick(event);
            setMenuOpened("metric");
          }}
        >
          <SportsScoreIcon />
        </IconButton>
        <IconButton
          size="small"
          onClick={(event) => {
            handleMenuAnchorClick(event);
            setMenuOpened("global-filter");
          }}
        >
          <FilterListIcon />
        </IconButton>
        <IconButton
          size="small"
          onClick={(event) => {
            if (filteredTrialIds.length > 0) {
              dispatch(sessionSlice.actions.setFilteredTrialIds([]));
            }
            dispatch(sessionSlice.actions.setFreeformTrialIds([]));
          }}
        >
          <Clear />
        </IconButton>
      </Stack>
    ),
  });

  useEffect(() => {
    if (selectedMetric == null) {
      return;
    }

    let trialIds = new Set<string>(
      table
        .getFilteredRowModel()
        .rows.map((row) => row.original["id"] ?? "unknown"),
    );

    if (trialIds.has("unknown")) {
      return;
    }

    // if (trialIds.has("unknown") && clusteringResult != null) {
    //   trialIds = new Set<string>(Object.keys(clusteringResult.data));
    // }
    // let trialIds = new Set<string>(Object.keys(clusteringResult?.data ?? {}));

    for (const trialId of [...trialIds]) {
      if (boundaryFilteringEnabled && !boundaryTrialIds.includes(trialId)) {
        trialIds.delete(trialId);
        continue;
      }
      if (freeformTrialIds.length && !freeformTrialIds.includes(trialId)) {
        trialIds.delete(trialId);
        continue;
      }
    }
    if (selectedPairTrialId && !trialIds.has(selectedPairTrialId)) {
      trialIds.add(selectedPairTrialId);
    }

    let pairMappings = pairTrialMapping[selectedMetric.kpi.name];
    if (
      boundaryFilteringEnabled &&
      option === "boundary" &&
      viewerMode == "pass/fail"
    ) {
      const allTrials = trajectoryAnalysis?.trials ?? {};

      const allUnsafeTrialIds = Object.values(trajectoryAnalysis?.trials ?? {})
        .filter((t) => {
          return !t.testObjectives?.criticalityMetrics.find(
            (m) =>
              m.keyPerformanceIndicator.name ===
              selectedBoundaryMetric?.kpi.name,
          )?.passed;
        })
        .map((t) => t.id ?? "");

      const safeTrialIds =
        allTrials == null
          ? []
          : [...boundaryTrialIds].filter(
              (id: string) =>
                allTrials[id].testObjectives?.criticalityMetrics.find(
                  (m) =>
                    m.keyPerformanceIndicator.name ===
                    selectedBoundaryMetric?.kpi.name,
                )?.passed,
            );

      // allUnsafeTrialIds.map(id => allTrials[id].)
      const safe2unsafePairMapping = findPairsFromTwoGroups(
        selectedBoundaryMetric,
        trajectoryAnalysisResponse,
        tree,
        treePoints,
        { safer: safeTrialIds, unsafer: allUnsafeTrialIds },
      );

      trialIds = new Set<string>(
        [...trialIds].filter((id) => id in safe2unsafePairMapping),
      );

      for (const trialId of [...trialIds]) {
        trialIds.add(safe2unsafePairMapping[trialId]);
      }

      dispatch(
        sessionSlice.actions.setSafe2UnsafeMappings(safe2unsafePairMapping),
      );

      pairMappings = safe2unsafePairMapping;
    }

    const pairedIds = new Set<string>();
    // if (pairMode && pairTrialMapping && selectedMetric) {
    //   for (const trialId of [...trialIds]) {
    //     const pair = pairTrialMapping[selectedMetric.kpi.name][trialId] ?? "";
    //     if (!trialIds.has(pair)) {
    //       trialIds.add(
    //         pairTrialMapping[selectedMetric.kpi.name][trialId] ?? "",
    //       );
    //       pairedIds.add(
    //         pairTrialMapping[selectedMetric.kpi.name][trialId] ?? "",
    //       );
    //     }
    //   }
    // }
    dispatch(sessionSlice.actions.setPairedTrialIds([...pairedIds]));

    const cluster2cluster: {
      [label: string]: { [saferTrialId: string]: string };
    } = {};

    if (clusteringResult) {
      for (const [safer, unsafer] of Object.entries(pairMappings)) {
        if (
          unsafer == null ||
          !Object.keys(clusteringResult.data).includes(safer) ||
          !Object.keys(clusteringResult.data).includes(unsafer)
        ) {
          continue;
        }
        const saferCluster = clusteringResult.data[safer].label;
        const unsaferCluster = clusteringResult.data[unsafer].label;
        if (saferCluster === unsaferCluster && !boundaryFilteringEnabled) {
          continue;
        }
        const label = `${saferCluster}->${unsaferCluster}`;
        if (!(label in cluster2cluster)) {
          cluster2cluster[label] = {};
        }
        cluster2cluster[label][safer] = unsafer;
      }
    }

    dispatch(sessionSlice.actions.setCluster2Cluster(cluster2cluster));

    if (cluster2cluster && selectedC2CLabel !== "all") {
      if (selectedC2CLabel == "rest") {
        const notKeep = new Set<string>();
        for (const group of Object.values(cluster2cluster)) {
          for (const [safer, unsafer] of Object.entries(group)) {
            notKeep.add(safer);
            notKeep.add(unsafer);
          }
        }
        for (const id of [...trialIds]) {
          if (notKeep.has(id)) {
            trialIds.delete(id);
          }
        }
      } else if (selectedC2CLabel in cluster2cluster) {
        const keep = new Set<string>();
        for (const [safer, unsafer] of Object.entries(
          cluster2cluster[selectedC2CLabel],
        )) {
          keep.add(safer);
          keep.add(unsafer);
        }
        for (const id of [...trialIds]) {
          if (!keep.has(id)) {
            trialIds.delete(id);
          }
        }
      }
    }

    // setColumnFilterTriggered(false);
    dispatch(sessionSlice.actions.setFilteredTrialIds([...trialIds]));
  }, [
    // table.getFilteredRowModel(),
    // columnFilterTriggered,
    boundaryTrialIds,
    freeformTrialIds,
    selectedMetric,
    viewerMode,
    clusteringResult,
    selectedC2CLabel,
    table.getFilteredRowModel().rows.length,

    // cluster2cluster,
    // selectedC2CLabel,
  ]);

  return (
    <Stack
      sx={{
        backgroundColor: "background.paper",
        height: "100%",
        ...sx,
        // ".MuiBox-root": {
        //   backgroundColor: "background.paper",
        // },
        // ".MuiTableCell-root": {
        //   backgroundColor: "background.paper",
        // },
        ".Mui-TableHeadCell-Content-Wrapper": {
          whiteSpace: "nowrap",
        },
        // ".MuiBox-root": {
        //   p: 0,
        //   minHeight: 0,
        // },
        // ".MuiTablePagination-root": {
        //   padding: 0,
        // },
      }}
    >
      <MaterialReactTable table={table} />
      <Menu
        id="metric-menu"
        anchorEl={anchorEl}
        open={menuOpened === "metric"}
        onClose={handleMenuClose}
      >
        <Stack sx={{ p: 2 }}>
          <FormControl sx={{ m: 0, p: 0 }}>
            <InputLabel size="small" id="viewerMode-selection-label">
              Viewer Mode
            </InputLabel>
            <Select
              sx={{ p: 0 }}
              label="ViewerMode"
              labelId="viewerMode-selection-label"
              id="viewerMode-selection"
              size="small"
              value={viewerMode}
              onChange={(event) => {
                dispatch(
                  sessionSlice.actions.setViewerMode(
                    event.target.value as ViewerMode,
                  ),
                );
              }}
            >
              {Object.values(viewerModes ?? {}).map((name, index) => {
                return (
                  <MenuItem key={name} value={name}>
                    {name ?? "unknown"}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
        </Stack>
        <Stack sx={{ p: 2, minWidth: "200px" }}>
          <Typography sx={{ fontSize: "14px", mb: 2 }}>
            Metric Selection
          </Typography>
          <FormControl sx={{ m: 0, p: 0 }}>
            <InputLabel size="small" id="criticality-metric-selection-label">
              Criticality Metric
            </InputLabel>
            <Select
              sx={{ p: 0 }}
              label="Criticality Metric"
              labelId="criticality-metric-selection-label"
              id="criticality-metric-selection"
              size="small"
              value={selectedMetric?.kpi.name ?? ""}
              onChange={(event) => {
                dispatch(
                  sessionSlice.actions.setSelectedMetric(
                    metrics ? metrics[event.target.value] : null,
                  ),
                );
              }}
            >
              {Object.values(metrics ?? {}).map((doc, index) => {
                return (
                  <MenuItem
                    key={doc.kpi.name ?? index}
                    value={doc.kpi.name ?? ""}
                  >
                    {doc.kpi.name ?? "unknown"}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
          <FormControl sx={{ m: 0, mt: 2 }}>
            <InputLabel size="small" id="safety-metric-selection-label">
              Safety Boundary Metric
            </InputLabel>
            <Select
              label="Safety Boundary Metric"
              labelId="safety-metric-selection-label"
              id="safety-metric-selection"
              size="small"
              value={selectedBoundaryMetric?.kpi.name ?? ""}
              onChange={(event) => {
                dispatch(
                  sessionSlice.actions.setSelectedSafetyBoundaryMetric(
                    metrics ? metrics[event.target.value] : null,
                  ),
                );
              }}
            >
              {Object.values(metrics ?? {}).map((doc, index) => {
                return (
                  <MenuItem
                    key={doc.kpi.name ?? index}
                    value={doc.kpi.name ?? ""}
                  >
                    {doc.kpi.name ?? "unknown"}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
        </Stack>
      </Menu>
      <Menu
        id="global-filter-menu"
        anchorEl={anchorEl}
        open={menuOpened === "global-filter"}
        onClose={handleMenuClose}
      >
        <Stack sx={{ p: 2 }}>
          <Typography sx={{ fontSize: "14px", mb: 2 }}>
            Global Filtering
          </Typography>
          <Stack>
            <Typography sx={{ mb: 1 }}>Pass / Fail Boundary</Typography>
            <Stack direction="row" sx={{ padding: "5px 0" }} columnGap={1}>
              <FormControlLabel
                sx={{
                  mr: 0,
                  ".MuiTypography-root": {
                    fontSize: "14px",
                  },
                }}
                control={
                  <Checkbox
                    checked={boundaryFilteringEnabled}
                    onChange={(_event, value) => {
                      dispatch(
                        sessionSlice.actions.setBoundaryFilteringEnabled(value),
                      );
                    }}
                  />
                }
                label=""
              />
              <TextField
                disabled={!boundaryFilteringEnabled}
                label="kNeighbors"
                type="number"
                size="small"
                sx={{ p: 0, m: 0, maxWidth: "120px" }}
                value={kNeighbors}
                onChange={(event) => {
                  dispatch(
                    sessionSlice.actions.setBoundaryKNeighbors(
                      Number(event.target.value),
                    ),
                  );
                }}
              />
            </Stack>
            {/* <FormControl> */}
            {/*   <FormLabel>Options</FormLabel> */}
            {/*   <RadioGroup */}
            {/*     value={option} */}
            {/*     onChange={(event) => setOption(event.target.value as Option)} */}
            {/*   > */}
            {/*     {options.map((o) => { */}
            {/*       return ( */}
            {/*         <FormControlLabel */}
            {/*           key={o} */}
            {/*           value={o} */}
            {/*           control={<Radio />} */}
            {/*           label={o} */}
            {/*         /> */}
            {/*       ); */}
            {/*     })} */}
            {/*   </RadioGroup> */}
            {/* </FormControl> */}
            <Button
              sx={{ width: "100%", mt: 1 }}
              size="small"
              variant="contained"
              onClick={() => {
                dispatch(sessionSlice.actions.setBoundaryTrialIds());
              }}
            >
              Filter
            </Button>
          </Stack>
        </Stack>
        <Stack sx={{ p: 2 }}>
          <Typography>{`Cluster -> Cluster ${viewerMode === "pass/fail" ? "(Pass -> Fail)" : "(Safer -> More Unsafe)"}`}</Typography>
          <FormControl>
            <RadioGroup
              value={selectedC2CLabel}
              onChange={(event) =>
                dispatch(
                  sessionSlice.actions.setSelectedCluster2ClusterLabel(
                    event.target.value,
                  ),
                )
              }
            >
              {["all", ...Object.keys(cluster2cluster ?? {})]
                .filter((o) => o !== "3->1")
                .map((o) => {
                  return (
                    <FormControlLabel
                      key={o}
                      value={o}
                      control={<Radio />}
                      label={o}
                    />
                  );
                })}
            </RadioGroup>
          </FormControl>
        </Stack>
        {/* <Stack sx={{ p: 2 }}> */}
        {/*   <FormControlLabel */}
        {/*     sx={{ */}
        {/*       mr: 0, */}
        {/*       fontSize: "12px", */}
        {/*       ".MuiTypography-root": { */}
        {/*         fontSize: "14px", */}
        {/*       }, */}
        {/*     }} */}
        {/*     control={ */}
        {/*       <Checkbox */}
        {/*         sx={{ fontSize: "12px" }} */}
        {/*         checked={pairMode} */}
        {/*         onChange={(_event, value) => { */}
        {/*           dispatch(sessionSlice.actions.setPairMode(value)); */}
        {/*         }} */}
        {/*       /> */}
        {/*     } */}
        {/*     label="Pair Mode" */}
        {/*   /> */}
        {/*   <FormControlLabel */}
        {/*     sx={{ */}
        {/*       mr: 0, */}
        {/*       fontSize: "12px", */}
        {/*       ".MuiTypography-root": { */}
        {/*         fontSize: "14px", */}
        {/*       }, */}
        {/*     }} */}
        {/*     control={ */}
        {/*       <Checkbox */}
        {/*         sx={{ fontSize: "12px" }} */}
        {/*         checked={reverseBoundaryMode} */}
        {/*         onChange={(_event, value) => { */}
        {/*           dispatch(sessionSlice.actions.setReverseBoundaryMode(value)); */}
        {/*         }} */}
        {/*       /> */}
        {/*     } */}
        {/*     label="Reverse Boundary Mode" */}
        {/*   /> */}
        {/* </Stack> */}
      </Menu>
    </Stack>
  );
}
