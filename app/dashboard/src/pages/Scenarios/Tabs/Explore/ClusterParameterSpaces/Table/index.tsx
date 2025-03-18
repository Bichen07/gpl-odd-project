import { useEffect, useMemo, useState } from "react";
import {
  MRT_Cell,
  MRT_ColumnDef,
  MRT_RowData,
  MRT_RowSelectionState,
  MaterialReactTable,
  getMRT_RowSelectionHandler,
  useMaterialReactTable,
} from "material-react-table";
import { Box, Tooltip, Typography } from "@mui/material";
import { SxProps } from "@mui/material/styles";
import { ClusterResult } from "src/api/services/Clustering";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
  clusterLabel: string | undefined;
  clusterResult: ClusterResult | null;
};
export default ({ sx, clusterLabel, clusterResult }: Props) => {
  const dispatch = useAppDispatch();

  const batches = useAppSelector((state) => state.session.batches);
  const batchTrialMappings = useAppSelector(
    (state) => state.session.batchTrialMappings,
  );
  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [rowSelection, setRowSelection] = useState<MRT_RowSelectionState>({});
  const [hoveredTrialId, setHoveredTrialId] = useState<string | null>(null);

  useEffect(() => {
    dispatch(
      sessionSlice.actions.setHighlightedTrialIds(
        new Set<string>(Object.keys(rowSelection)),
      ),
    );
  }, [rowSelection]);

  useEffect(() => {
    setIsLoading(true);
    if (!clusterResult || !clusterLabel || !batches) {
      setTableData([]);
      return;
    }
    const newData: any[] = [];
    for (const item of clusterResult.data) {
      if (item.label !== clusterLabel) {
        continue;
      }
      let newRow: any = {};
      newRow["membership"] = item.probability;
      const batchId = Object.keys(batchTrialMappings).find((batchId) =>
        batchTrialMappings[batchId].has(item.trialId),
      );
      const scenarioName = batches?.docs?.find((b) => b?.id === batchId)
        ?.scenario.name;
      newRow["scenario"] = scenarioName;
      newRow["trialId"] = item.trialId;
      newData.push(newRow);
    }
    setTableData(newData);
  }, [clusterResult, clusterLabel, batchTrialMappings, batches]);

  useEffect(() => {
    setIsLoading(false);
  }, [tableData]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    const getCellRenderer = (key: string) => {
      return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) => {
        let value = cell.getValue();
        if (!key.includes("Id") && !key.includes("scenario")) {
          value = value.toFixed(4);
        }
        return value;
      };
    };
    const getFilterOptions = (key: string) => {
      if (key.includes("Id") || key.includes("scenario")) {
        return undefined;
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
          size: 50,
          ...getFilterOptions(key),
        }));
  }, [tableData]);

  const table = useMaterialReactTable({
    columns,
    data: tableData ?? [],
    getRowId: (row) => row.trialId,
    enableDensityToggle: false,
    enableFullScreenToggle: false,
    enableHiding: false,
    // enableTopToolbar: false,
    initialState: {
      density: "compact",
    },
    state: {
      isLoading: tableData === null || isLoading,
      rowSelection,
    },
    enableRowSelection: true,
    muiTableHeadRowProps: {
      // sx: { "th:first-child": { display: "none" } },
    },
    muiTableBodyRowProps: ({ row, staticRowIndex, table }) => ({
      onMouseOver: (event) => {
        // console.log(row.id);
      },
      onClick: (event) =>
        getMRT_RowSelectionHandler({ row, staticRowIndex, table })(event), //import this helper function from material-react-table
      sx: {
        cursor: "pointer",
        // "td:first-child": { display: "none" },
      },
    }),
    // renderCreateRowDialogContent
    onRowSelectionChange: setRowSelection,
    // muiTableBodyRowProps: ({ row, staticRowIndex, table }) => ({
    //   //implement row selection click events manually
    //   onClick: (event) =>
    //     getMRT_RowSelectionHandler({ row, staticRowIndex, table })(event), //import this helper function from material-react-table
    //   selected: rowSelection[row.id],
    //   sx: {
    //     cursor: "pointer",
    //   },
    // }),
  });

  return (
    <Box component="div" sx={sx}>
      <MaterialReactTable table={table} />
    </Box>
  );
};
