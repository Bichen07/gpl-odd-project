import { useEffect, useMemo } from "react";
import {
  MRT_ColumnDef,
  MRT_Row,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { mkConfig, generateCsv, download } from "export-to-csv"; //or use your library of choice here
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import {
  setRepresentationsModalTableOpen,
  setTableData,
} from "src/redux/slices/timeSeriesClustering";
import { Box, Button } from "@mui/material";
import FileDownload from "@mui/icons-material/FileDownload";
import TableModal from "src/components/TableModal";
import { toast } from "react-toastify";

const csvConfig = mkConfig({
  fieldSeparator: ",",
  decimalSeparator: ".",
  useKeysAsHeaders: true,
});

const Table = () => {
  const dispatch = useAppDispatch();

  const representation = useAppSelector(
    (state) => state.timeSeriesClustering.representation
  );
  const representations = useAppSelector(
    (state) => state.timeSeriesClustering.representations
  );
  const selectedAttributes = useAppSelector(
    (state) => state.timeSeriesClustering.selectedAttributes
  );
  const clusters = useAppSelector(
    (state) => state.timeSeriesClustering.clusters
  );
  const tableData = useAppSelector(
    (state) => state.timeSeriesClustering.tableData
  );

  const isLoading = tableData === null;

  useEffect(() => {
    if (
      representations === null ||
      clusters === null ||
      tableData !== null ||
      selectedAttributes === null
    ) {
      return;
    }
    if (representation === "finalObservation") {
      const newHeaders = [
        "trialId",
        "cluster",
        "cluster membership",
        ...selectedAttributes,
      ];
      const newData: MRT_RowData[] = [];
      for (const [trialId, representation] of Object.entries(representations)) {
        const newRow: MRT_RowData = {};
        newRow["trialId"] = trialId;
        newRow["cluster"] = clusters[trialId].cluster;
        newRow["cluster membership"] = clusters[trialId].membership;
        for (const [index, attribute] of selectedAttributes.entries()) {
          newRow[attribute] = representation[index];
        }
        newData.push(newRow);
      }
      dispatch(
        setTableData({
          data: newData,
          headers: newHeaders,
        })
      );
    } else {
      const newData: MRT_RowData[] = [];
      for (const [trialId, representation] of Object.entries(representations)) {
        const newRow: MRT_RowData = {};
        newRow["trialId"] = trialId;
        newRow["cluster"] = clusters[trialId].cluster;
        for (const [index, value] of representation.entries()) {
          newRow[`Latent${index}`] = value;
        }
        newData.push(newRow);
      }
      const newHeaders = ["trialId"];
      if (Object.keys(newData).length > 0) {
        const item = Object.values(representations)[0];
        for (const index in item) {
          newHeaders.push(`Latent${index}`);
        }
      }
      dispatch(
        setTableData({
          data: newData,
          headers: newHeaders,
        })
      );
    }
  }, [
    representation,
    representations,
    tableData,
    selectedAttributes,
    clusters,
  ]);

  const handleExportData = () => {
    if (tableData === null) {
      return;
    }
    const csv = generateCsv(csvConfig)(tableData.data);
    download(csvConfig)(csv);
  };

  const handleCopyTrialIds = (rows: MRT_Row<any>[]) => {
    const rowData = rows.map((row) => row.original);
    const trialIdsString = rowData.map((data) => data["trialId"]).join(",");
    navigator.clipboard.writeText(trialIdsString);
    toast.info("Copy To Clipboard!");
  };

  const columns: MRT_ColumnDef<any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    return tableData.headers.map((name) => ({
      accessorKey: name,
      header: name,
    }));
  }, [tableData]);

  const table = useMaterialReactTable({
    columns,
    data: tableData?.data ?? [],
    getRowId: (row) => row.id,
    enableDensityToggle: false,
    enableFullScreenToggle: false,
    initialState: { density: "compact" },
    state: {
      isLoading,
    },
    muiTableBodyCellProps: ({ cell }) => {
      const value = cell.getValue();
      return {
        sx: {
          color:
            value === "Passed" || value === "True"
              ? "success.main"
              : value === "Failed" || value === "False"
                ? "error.main"
                : "inherit",
        },
      };
    },
    renderTopToolbarCustomActions: ({ table }) => (
      <Box
        sx={{
          display: "flex",
          gap: "16px",
          padding: "8px",
          flexWrap: "wrap",
        }}
      >
        <Button
          //export all data that is currently in the table (ignore pagination, sorting, filtering, etc.)
          onClick={handleExportData}
          startIcon={<FileDownload />}
        >
          Export All Data
        </Button>
        <Button
          disabled={table.getPrePaginationRowModel().rows.length === 0}
          //export all rows, including from the next page, (still respects filtering and sorting)
          onClick={() =>
            handleCopyTrialIds(table.getPrePaginationRowModel().rows)
          }
          startIcon={<FileDownload />}
        >
          Copy Trial Ids
        </Button>
      </Box>
    ),
  });

  return <MaterialReactTable table={table} />;
};

export default () => {
  const dispatch = useAppDispatch();
  const open = useAppSelector(
    (state) => state.timeSeriesClustering.representationsModalTableOpen
  );
  return (
    <TableModal
      open={open}
      onClose={() => dispatch(setRepresentationsModalTableOpen(false))}
    >
      <Table />
    </TableModal>
  );
};
