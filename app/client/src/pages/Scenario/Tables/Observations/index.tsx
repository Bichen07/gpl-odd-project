import { useEffect, useMemo, useState } from "react";
import {
  MRT_ColumnDef,
  MaterialReactTable,
  useMaterialReactTable,
  type MRT_ColumnFiltersState,
  type MRT_PaginationState,
  type MRT_SortingState,
} from "material-react-table";
import ObservationService from "src/axios/services/Observations";
import { useParams } from "react-router-dom";
import { Box } from "@mui/material";
import FileDownloadIcon from "@mui/icons-material/FileDownload";
import { mkConfig, generateCsv, download } from "export-to-csv"; //or use your library of choice here
import LoadingButton from "@mui/lab/LoadingButton";
import { toast } from "react-toastify";
import { observationDocsToRows } from "src/utils";

const titleizeCamelCase = (str: string) => {
  return str
    .replace(/([a-z])([A-Z])/g, "$1 $2") // Add space between lowercase and uppercase letters
    .replace(/^[a-z]/, function(match) {
      // Capitalize the first letter
      return match.toUpperCase();
    });
};

const csvConfig = mkConfig({
  fieldSeparator: ",",
  decimalSeparator: ".",
  useKeysAsHeaders: true,
});

const Table = () => {
  const params = useParams();
  const [data, setData] = useState<any[]>([]);
  const [isError, setIsError] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isRefetching, setIsRefetching] = useState(false);
  const [rowCount, setRowCount] = useState(0);

  //table state
  const [columnFilters, setColumnFilters] = useState<MRT_ColumnFiltersState>(
    []
  );
  const [globalFilter, setGlobalFilter] = useState("");
  const [sorting, setSorting] = useState<MRT_SortingState>([]);
  const [pagination, setPagination] = useState<MRT_PaginationState>({
    pageIndex: 0,
    pageSize: 10,
  });
  const [exportLoading, setExportLoading] = useState(false);

  const handleExportData = () => {
    const fetchData = async () => {
      setExportLoading(true);
      const queries: any[] = [];
      for (const columnFilter of columnFilters) {
        if (columnFilter.id === "isFinal") {
          queries.push({
            [columnFilter.id]: { equals: Boolean(columnFilter.value) },
          });
        }
      }

      try {
        const response = await ObservationService.getObservations({
          where: {
            and: [
              {
                "trial.search.scenario": { equals: params["id"] },
              },
              ...queries,
            ],
          },
          limit: 100000,
          depth: 1,
        }).then((response) => response.data);
        const exportData: any[] = observationDocsToRows(response.docs);
        const csv = generateCsv(csvConfig)(exportData);
        download(csvConfig)(csv);
      } catch (error) {
        console.error(error);
        toast.error(error);
        return;
      }
      setExportLoading(false);
    };

    fetchData();
  };

  //if you want to avoid useEffect, look at the React Query example instead
  useEffect(() => {
    if (!data.length) {
      setIsLoading(true);
    } else {
      setIsRefetching(true);
    }
    const fetchData = async () => {
      // url.searchParams.set('size', `${pagination.pageSize}`);
      // url.searchParams.set('filters', JSON.stringify(columnFilters ?? []));
      // url.searchParams.set('globalFilter', globalFilter ?? '');
      // url.searchParams.set('sorting', JSON.stringify(sorting ?? []));

      const queries: any[] = [];
      for (const columnFilter of columnFilters) {
        if (columnFilter.id === "isFinal") {
          queries.push({
            [columnFilter.id]: { equals: columnFilter.value === "True" },
          });
        }
      }

      try {
        const response = await ObservationService.getObservations({
          where: {
            and: [
              {
                "trial.search.scenario": { equals: params["id"] },
              },
              ...queries,
            ],
          },
          limit: pagination.pageSize,
          page: pagination.pageIndex,
          depth: 1,
        }).then((response) => response.data);
        const updatedData: any[] = docsToRows(response.docs);
        setData(updatedData);
        setRowCount(response.totalDocs);
      } catch (error) {
        setIsError(true);
        console.error(error);
        return;
      }
      setIsError(false);
      setIsLoading(false);
      setIsRefetching(false);
    };

    fetchData();
  }, [
    columnFilters, //re-fetch when column filters change
    globalFilter, //re-fetch when global filter changes
    pagination.pageIndex, //re-fetch when page index changes
    pagination.pageSize, //re-fetch when page size changes
    sorting, //re-fetch when sorting changes
  ]);

  const columns: MRT_ColumnDef<any>[] = useMemo(() => {
    return data.length === 0
      ? []
      : Object.keys(data[0]).map((key) => ({
        accessorKey: key,
        header: titleizeCamelCase(key),
      }));
  }, [data]);

  const table = useMaterialReactTable({
    columns,
    data,
    getRowId: (row) => row.id,
    initialState: { density: "compact" },
    manualFiltering: true,
    manualPagination: true,
    manualSorting: true,
    muiToolbarAlertBannerProps: isError
      ? {
        color: "error",
        children: "Error loading data",
      }
      : undefined,
    onColumnFiltersChange: setColumnFilters,
    onGlobalFilterChange: setGlobalFilter,
    onPaginationChange: setPagination,
    onSortingChange: setSorting,
    rowCount,
    state: {
      columnFilters,
      globalFilter,
      isLoading,
      pagination,
      showAlertBanner: isError,
      showProgressBars: isRefetching,
      sorting,
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
    renderTopToolbarCustomActions: () => (
      <Box
        sx={{
          display: "flex",
          gap: "16px",
          padding: "8px",
          flexWrap: "wrap",
        }}
      >
        <LoadingButton
          variant="contained"
          size="small"
          loading={exportLoading}
          onClick={handleExportData}
          startIcon={<FileDownloadIcon />}
        >
          Export All Data
        </LoadingButton>
      </Box>
    ),
  });

  return <MaterialReactTable table={table} />;
};

export default Table;
