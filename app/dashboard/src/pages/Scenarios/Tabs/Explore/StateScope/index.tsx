import { useMemo } from "react";
import { Stack, Typography } from "@mui/material";
import {
  MRT_Cell,
  MRT_ColumnDef,
  MRT_Row,
  MRT_RowData,
  MaterialReactTable,
  getMRT_RowSelectionHandler,
  useMaterialReactTable,
} from "material-react-table";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";

const Table = () => {
  const dispatch = useAppDispatch();
  const stateAnalysis = useAppSelector(
    (state) => state.session.stateAnalysisResponse,
  );

  //should be memoized or stable
  const columns = useMemo<MRT_ColumnDef<any>[]>(() => {
    const getCellRenderer = (key: string) => {
      if (key.includes("id") || key.includes("Id")) {
        return undefined;
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
      return {
        filterVariant: "range",
        filterFn: "between",
      };
    };
    return [
      {
        accessorKey: "stateId", //access nested data with dot notation
        header: "State ID",
        Cell: getCellRenderer("stateId"),
        ...getFilterOptions("stateId"),
      },
      {
        accessorKey: "trialId", //access nested data with dot notation
        header: "Trial ID",
        Cell: getCellRenderer("trialId"),
        ...getFilterOptions("trialId"),
      },
      {
        accessorKey: "time", //access nested data with dot notation
        header: "Time",
        Cell: getCellRenderer("time"),
        ...getFilterOptions("time"),
      },
      {
        accessorKey: "egoGradientMagnitude", //access nested data with dot notation
        header: "Ego Gradient",
        Cell: getCellRenderer("egoGradientMagnitude"),
        ...getFilterOptions("egoGradientMagnitude"),
      },
      {
        // accessorKey: `${stateAnalysis?.egoFeatureNames[0]}MetricGradientMagnitude`,
        accessorKey: `metricGradientMagnitude`,
        header: "Metric Gradient",
        Cell: getCellRenderer("metricGradientMagnitude"),
        ...getFilterOptions("metricGradientMagnitude"),
      },
      ...(stateAnalysis?.egoFeatureNames.map((name) => ({
        accessorKey: name,
        header: name,
        Cell: getCellRenderer(name),
        ...getFilterOptions(name),
      })) ?? []),
      ...(stateAnalysis?.envFeatureNames.map((name) => ({
        accessorKey: name,
        header: name,
        Cell: getCellRenderer(name),
        ...getFilterOptions(name),
      })) ?? []),
    ];
  }, [stateAnalysis]);

  const data = useMemo<any[]>(() => {
    const result: any[] = [];
    for (const state of Object.values(stateAnalysis?.states ?? {})) {
      let egoGradientMagnitude = 0;
      for (const bundle of Object.values(state.egoGradients)) {
        for (const value of Object.values(bundle)) {
          egoGradientMagnitude += value * value;
        }
      }
      egoGradientMagnitude = Math.sqrt(egoGradientMagnitude);
      let metricGradientMagnitude = 0;
      for (const value of Object.values(state.metricGradients["dce_min"])) {
        metricGradientMagnitude += value[0] * value[0];
      }
      metricGradientMagnitude = Math.sqrt(metricGradientMagnitude);
      result.push({
        stateId: state.id,
        trialId: state.data["trialId"],
        time: state.data["time"],
        egoGradientMagnitude: egoGradientMagnitude,
        metricGradientMagnitude: metricGradientMagnitude,
        ...state.data,
      });
    }
    return result;
  }, [stateAnalysis]);

  const table = useMaterialReactTable({
    columns,
    data, //data must be memoized or stable (useState, useMemo, defined outside of this component, etc.)
    enableRowSelection: true,
    enableMultiRowSelection: false, //shows radio buttons instead of checkboxes
    muiTableBodyRowProps: ({ row, staticRowIndex, table }) => ({
      onClick: (event) => {
        getMRT_RowSelectionHandler({ row, staticRowIndex, table })(event); //import this helper function from material-react-table
        const selectedState = Object.values(stateAnalysis?.states ?? {})[
          staticRowIndex
        ];
        dispatch(sessionSlice.actions.setSelectedStateId(selectedState.id));
      },
      sx: { cursor: "pointer" },
    }),
    mrtTheme: (theme) => ({
      baseBackgroundColor: theme.palette.background.paper, //change default background color
    }),
    muiTableProps: {
      sx: {
        overflowY: "scroll",
        height: "100%",
      },
    },
  });

  return <MaterialReactTable table={table} />;
};

export default function StateScope() {
  return (
    <Stack sx={{ height: "100%" }}>
      <Table />
    </Stack>
  );
}
