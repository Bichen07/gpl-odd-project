import { SxProps, Box } from "@mui/material";
import {
  MRT_ColumnDef,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";

type Props = {
  sx?: SxProps;
};
export default ({ sx }: Props) => {
  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);

  const scenario = useAppSelector((state) => state.batch.scenario);

  useEffect(() => {
    if (scenario === null) {
      return;
    }
    if (
      !scenario.testObjectives?.criticalityMetrics ||
      scenario.testObjectives?.criticalityMetrics.length === 0
    ) {
      setTableData([]);
      return;
    }
    const criticalityMetrics = scenario.testObjectives.criticalityMetrics;
    const newData: MRT_RowData[] = [];
    for (const metric of criticalityMetrics) {
      const newRow: MRT_RowData = {};
      newRow["Name"] = metric.keyPerformanceIndicator?.name ?? "None";
      newRow["Unit"] = metric.keyPerformanceIndicator?.unit ?? "None";
      newRow["Rule"] = metric.keyPerformanceIndicator?.rule ?? "None";
      newRow["Threshold"] = metric.threshold ?? "None";
      newRow["Description"] = metric.description ?? "None";
      newData.push(newRow);
    }
    setTableData(newData);
  }, [scenario]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    return tableData.length === 0
      ? []
      : Object.keys(tableData[0]).map((key) => ({
          accessorKey: key,
          header: key,
          size: key === "Description" ? 300 : 0,
        }));
  }, [tableData]);

  const table = useMaterialReactTable({
    columns,
    data: tableData ?? [],
    state: {
      isLoading: tableData === null,
    },
    muiTablePaperProps: {
      elevation: 0,
      sx: {
        backgroundColor: "background.paper",
      },
    },
    enableColumnActions: false,
    enableColumnFilters: false,
    enablePagination: false,
    enableSorting: false,
    enableTopToolbar: false,
    enableBottomToolbar: false,
    muiTableBodyRowProps: {
      hover: false,
      sx: {
        "&:last-child td, &:last-child th": { borderBottom: 0 },
      },
    },
    muiTableContainerProps: {
      sx: {
        borderStyle: "solid",
        borderWidth: "1.5px",
        borderColor: "divider",
        borderRadius: "5px",
        ".MuiTableCell-root:not(:last-child)": {
          borderRightStyle: "solid",
          borderRightWidth: "1.5px",
          borderRightColor: "divider",
        },
        ...sx,
      },
    },
    muiTableHeadCellProps: {
      sx: {
        fontStyle: "italic",
        fontWeight: "normal",
      },
    },
  });

  return (
    <Box
      component="div"
      sx={{
        backgroundColor: "background.paper",
        mb: 3,
        ".MuiBox-root": {
          backgroundColor: "background.paper",
        },
        ".MuiTableCell-root": {
          backgroundColor: "background.paper",
        },
        ...sx,
      }}
    >
      <MaterialReactTable table={table} />
    </Box>
  );
};
