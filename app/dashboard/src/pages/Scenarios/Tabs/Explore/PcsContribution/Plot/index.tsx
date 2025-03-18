import { useEffect, useMemo, useState } from "react";
import { useAppSelector } from "src/redux/hooks";
import {
  MRT_ColumnDef,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { Box } from "@mui/material";
import { ClusteringMode } from "src/redux/slices/session";

type Props = {
  mode: Omit<ClusteringMode, "boundaryDiff">;
};
export default function Plot({ mode }: Props) {
  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);
  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );
  const clustering = useMemo(() => {
    if (clusteringResponse === null) {
      return null;
    }
    if (mode === "critical") {
      return clusteringResponse.criticalStateClustering;
    } else {
      return clusteringResponse.lastEgoDiffClustering;
    }
  }, [clusteringResponse]);
  useEffect(() => {
    if (clustering == null) {
      setTableData([]);
      return;
    }
    const attributes = clustering.attributes;
    const newData: MRT_RowData[] = [];
    for (const [attributeIndex, cos2row] of clustering.loadings.entries()) {
      const newRow: MRT_RowData = {};

      newRow["attribute"] = attributes[attributeIndex];
      for (const [index, value] of cos2row.entries()) {
        newRow[`PC${index}`] = value.toFixed(2);
      }
      newData.push(newRow);
    }
    setTableData(newData);
  }, [clustering]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    return tableData.length === 0
      ? []
      : Object.keys(tableData[0]).map((key) => ({
        accessorKey: key,
        header: key,
        size: 0,
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
      }}
    >
      <MaterialReactTable table={table} />
    </Box>
  );
}
