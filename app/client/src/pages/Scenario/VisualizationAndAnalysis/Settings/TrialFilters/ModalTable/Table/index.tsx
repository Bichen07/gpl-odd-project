import { useEffect, useMemo } from "react";
import {
  MRT_ColumnDef,
  MRT_Row,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { CriticalityMetric } from "payload/payload-types";
import { mkConfig, generateCsv, download } from "export-to-csv"; //or use your library of choice here
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { setTableData } from "src/redux/slices/trialFilters";
import { Box, Button } from "@mui/material";
import FileDownload from "@mui/icons-material/FileDownload";
import { toast } from "react-toastify";

const csvConfig = mkConfig({
  fieldSeparator: ",",
  decimalSeparator: ".",
  useKeysAsHeaders: true,
});

const Table = () => {
  const dispatch = useAppDispatch();

  const trials = useAppSelector((state) => state.trialFilters.trials);
  const parameters = useAppSelector((state) => state.trialFilters.parameters);
  const scenario = useAppSelector((state) => state.scenario.data);
  const filteredTrialIds = useAppSelector(
    (state) => state.trialFilters.filteredTrialIds
  );
  const data = useAppSelector((state) => state.trialFilters.tableData);

  const isLoading = data === null;

  useEffect(() => {
    if (
      trials === null ||
      filteredTrialIds === null ||
      parameters === null ||
      scenario === null
    ) {
      return;
    }
    const newColumns: MRT_ColumnDef<any>[] = [];
    const newData: any[] = [];
    const filteredTrialIdSet = new Set(filteredTrialIds);
    for (const [trialIndex, doc] of Object.values(trials).entries()) {
      if (!filteredTrialIdSet.has(doc.id)) {
        continue;
      }
      let newRow: any = {};
      for (const [index, parameter] of scenario.parameters.entries()) {
        newRow[parameter.name] = doc.parameters[index].value;
        if (trialIndex === 0) {
          newColumns.push({
            accessorKey: parameter.name,
            header: parameter.name,
          });
        }
      }
      for (const [
        index,
        safetyRequirement,
      ] of scenario.safetyRequirements.entries()) {
        const metric = safetyRequirement.criticalityMetric as CriticalityMetric;
        newRow[metric.name] = doc.safetyRequirements[index].value;
        if (trialIndex === 0) {
          newColumns.push({
            accessorKey: metric.name,
            header: metric.name,
          });
        }
      }
      newRow["id"] = doc.id;
      newRow["createdAt"] = doc.createdAt;
      newData.push(newRow);
      if (trialIndex === 0) {
        newColumns.push({
          accessorKey: "id",
          header: "id",
        });
        newColumns.push({
          accessorKey: "createdAt",
          header: "createdAt",
        });
      }
    }
    // setColumns(newColumns);
    dispatch(setTableData(newData));
  }, [parameters, trials, filteredTrialIds, scenario]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (data === null) {
      return [];
    }
    return data.length === 0
      ? []
      : Object.keys(data[0]).map((key) => ({
        accessorKey: key,
        header: key,
      }));
  }, [data]);

  const handleExportData = () => {
    if (data === null) {
      return;
    }
    const csv = generateCsv(csvConfig)(data);
    download(csvConfig)(csv);
  };

  const handleCopyTrialIds = (rows: MRT_Row<any>[]) => {
    const rowData = rows.map((row) => row.original);
    const trialIdsString = rowData.map((data) => data["id"]).join(",");
    navigator.clipboard.writeText(trialIdsString);
    toast.info("Copy To Clipboard!");
  };

  const table = useMaterialReactTable({
    columns,
    data: data ?? [],
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

export default Table;
