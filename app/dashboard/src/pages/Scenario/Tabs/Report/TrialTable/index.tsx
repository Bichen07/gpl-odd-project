import { useEffect, useMemo, useState } from "react";
import {
  MRT_Cell,
  MRT_ColumnDef,
  MRT_Row,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { EsminiDat, KeyPerformanceIndicator } from "src/__generated__/graphql";
import { mkConfig, generateCsv, download } from "export-to-csv"; //or use your library of choice here
import { useAppSelector } from "src/redux/hooks";
import { Box, Button, MenuItem, Typography } from "@mui/material";
import { SxProps, useTheme } from "@mui/material/styles";
import ContentCopyIcon from "@mui/icons-material/ContentCopy";
import FileDownload from "@mui/icons-material/FileDownload";
import { toast } from "react-toastify";
import { downloadFile } from "src/utils";
import { getDoc } from "src/api/common";

export function formatDate(date: Date) {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are zero-based
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

const csvConfig = mkConfig({
  fieldSeparator: ",",
  decimalSeparator: ".",
  useKeysAsHeaders: true,
});

type Props = {
  sx?: SxProps;
  kpiId?: string;
  passed?: boolean;
};
export default ({ kpiId, passed, sx }: Props) => {
  const theme = useTheme();
  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const trials = useAppSelector((state) => state.batch.trials);
  const scenario = useAppSelector((state) => state.batch.scenario);

  const parameters = useAppSelector((state) => state.batch.parameters);
  const criticalityMetrics = useAppSelector(
    (state) => state.batch.criticalityMetrics,
  );

  useEffect(() => {
    setIsLoading(true);
    if (
      trials === null ||
      scenario === null ||
      criticalityMetrics === null ||
      parameters === null ||
      (kpiId && !(kpiId in criticalityMetrics) && kpiId !== "total")
    ) {
      return;
    }
    if (
      trials.length > 0 &&
      trials[0].parameters
        .map((p) => p.parameterId)
        .sort()
        .join() !==
        Object.values(parameters)
          .map((p) => p.id)
          .sort()
          .join()
    ) {
      return;
    }
    const newData: any[] = [];
    const filteredTrialIdSet =
      kpiId === "total"
        ? new Set(
            trials
              .filter((trial) =>
                passed
                  ? (trial.testObjectives?.criticalityMetrics ?? []).find(
                      (metric) => !metric.passed,
                    ) === undefined
                  : (trial.testObjectives?.criticalityMetrics ?? []).find(
                      (metric) => !metric.passed,
                    ) !== undefined,
              )
              .map((t) => t.id),
          )
        : new Set(
            trials
              .filter((trial) =>
                kpiId
                  ? trial.testObjectives?.criticalityMetrics[
                      criticalityMetrics[kpiId].index
                    ].passed === passed
                  : true,
              )
              .map((t) => t.id),
          );
    for (const doc of trials) {
      if (
        scenario.parameters === undefined ||
        scenario.parameters === null ||
        scenario.testObjectives?.criticalityMetrics === undefined ||
        scenario.testObjectives.criticalityMetrics === null ||
        doc.id === undefined ||
        doc.id === null ||
        !filteredTrialIdSet.has(doc.id)
      ) {
        continue;
      }
      let newRow: any = {};
      for (const [index, parameter] of scenario.parameters.entries()) {
        if (
          parameter.name === undefined ||
          parameter.name === null ||
          index > doc.parameters.length - 1
        ) {
          continue;
        }
        newRow[parameter.name + ` [${parameter.unit}]`] =
          doc.parameters[index].value;
      }
      for (const [
        index,
        safetyRequirement,
      ] of scenario.testObjectives.criticalityMetrics.entries()) {
        const metric =
          safetyRequirement.keyPerformanceIndicator as KeyPerformanceIndicator;
        newRow[metric.name + ` [${metric.unit}]`] =
          doc.testObjectives?.criticalityMetrics[index].value;
        newRow[metric.name + " result"] =
          doc.testObjectives?.criticalityMetrics[index].passed;
      }
      newRow["id"] = doc.id;
      newRow["createdAt"] = doc.createdAt;
      newData.push(newRow);
    }
    setTableData(newData);
  }, [parameters, criticalityMetrics, trials, scenario, kpiId, passed]);

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
      } else if (key.includes("result")) {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) =>
          cell.getValue<boolean>() ? (
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

  const handleExportData = () => {
    if (tableData === null) {
      return;
    }
    const csv = generateCsv(csvConfig)(tableData);
    download(csvConfig)(csv);
  };

  const handleCopyTrialIndices = (rows: MRT_Row<any>[]) => {
    const rowData = rows.map((row) => row.original);
    const trialIndicesString = rowData.map((data) => data["id"]).join(",");
    navigator.clipboard.writeText(trialIndicesString);
    toast.info("Copy To Clipboard!");
  };

  const table = useMaterialReactTable({
    columns,
    data: tableData ?? [],
    getRowId: (row) => row.id,
    enableDensityToggle: false,
    enableFullScreenToggle: false,
    // enableColumnResizing: true,
    // columnResizeMode: "onEnd", //instead of the default "onChange" mode
    enableRowActions: true,
    initialState: {
      density: "compact",
      columnPinning: {
        right: ["mrt-row-actions"],
      },
    },
    state: {
      isLoading: tableData === null || isLoading,
    },
    renderRowActionMenuItems: ({ row }) => [
      <MenuItem
        key="edit"
        onClick={() => {
          if (!trials) {
            toast.error("Trials are undefined!");
            return;
          }
          const trial = trials.find((trial) => trial.id === row.original.id);
          if (!trial) {
            toast.error(`Trial ID: ${row.original.id}. Not found!`);
            return;
          }
          const datId = trial.esminiDat as string;
          getDoc<EsminiDat>("esminiDats", datId).then((response) => {
            downloadFile(response.data.url ?? "");
          });
        }}
      >
        Download Esmini Dat
      </MenuItem>,
    ],
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
    renderTopToolbarCustomActions: ({ table }) => (
      <Box
        component="div"
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
            handleCopyTrialIndices(table.getPrePaginationRowModel().rows)
          }
          startIcon={<ContentCopyIcon />}
        >
          Copy Trial Ids
        </Button>
      </Box>
    ),
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
