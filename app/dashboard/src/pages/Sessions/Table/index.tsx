import { Box, SxProps } from "@mui/material";
import {
  MRT_Cell,
  MRT_ColumnDef,
  MRT_RowData,
  MaterialReactTable,
  useMaterialReactTable,
} from "material-react-table";
import { useEffect, useMemo, useState } from "react";
import { useNavigate, useParams, useSearchParams } from "react-router-dom";
import { Session_Where_And, Sessions } from "src/__generated__/graphql";
import { formatDate } from "src/utils";
import { getDocs } from "src/api/common";

type Props = {
  sx?: SxProps;
};
export default ({ sx }: Props) => {
  const params = useParams();
  const navigate = useNavigate();
  const [searchParams, _setSearchParams] = useSearchParams();

  const itemsPerPage = 30;
  const page = parseInt(searchParams.get("page") ?? "1");

  const whereQuery: Session_Where_And[] = [];

  const [tableData, setTableData] = useState<MRT_RowData[] | null>(null);

  const [loading, setLoading] = useState(true);
  const [isError, setIsError] = useState<boolean | null>(null);
  const [data, setData] = useState<Sessions | null | undefined>(null);

  useEffect(() => {
    setLoading(true);
    const fetchData = async () => {
      try {
        const sessions = await getDocs<Sessions>("sessions", {
          page,
          where: {
            AND: whereQuery,
          },
          limit: itemsPerPage,
          depth: 0,
        }).then((response) => response.data);
        setData(sessions);
        setIsError(false);
      } catch (error) {
        setData(undefined);
        setIsError(true);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    if (data === null) {
      return;
    }
    setLoading(false);
  }, [data]);

  useEffect(() => {
    if (tableData !== null || !data || !data.docs) {
      return;
    }
    if (data.docs.length === 0) {
      setTableData([]);
      return;
    }
    const newData: MRT_RowData[] = [];
    for (const doc of data.docs) {
      const newRow: MRT_RowData = {};
      newRow["Id"] = doc?.id ?? "None";
      newRow["UpdatedAt"] = doc?.updatedAt ?? "None";
      newData.push(newRow);
    }
    setTableData(newData);
  }, [tableData, data]);

  useEffect(() => {
    setTableData(null);
  }, [params["id"]]);

  const columns: MRT_ColumnDef<MRT_RowData, any>[] = useMemo(() => {
    if (tableData === null) {
      return [];
    }
    const getCellRenderer = (key: string) => {
      if (key.includes("At")) {
        return ({ cell }: { cell: MRT_Cell<MRT_RowData, any> }) =>
          formatDate(new Date(cell.getValue<string>()));
      } else {
        return undefined;
      }
    };
    return tableData.length === 0
      ? []
      : Object.keys(tableData[0]).map((key) => ({
          accessorKey: key,
          header: key,
          size: key === "Description" ? 300 : 0,
          Cell: getCellRenderer(key),
        }));
  }, [tableData]);

  const table = useMaterialReactTable({
    columns,
    data: tableData ?? [],
    muiTablePaperProps: {
      elevation: 0,
    },
    state: {
      isLoading: loading,
    },
    enableColumnActions: false,
    enableColumnFilters: false,
    enablePagination: false,
    enableSorting: false,
    enableTopToolbar: false,
    enableBottomToolbar: false,
    manualFiltering: true, //turn off built-in client-side filtering
    manualPagination: true, //turn off built-in client-side pagination
    manualSorting: true, //turn off built-in client-side sorting
    muiToolbarAlertBannerProps: isError
      ? {
          color: "error",
          children: "Error loading data",
        }
      : undefined,
    //clicking anywhere on the row will select it
    muiTableBodyRowProps: ({ row }) => ({
      onClick: (_event) => {
        const sessionId = row.original["Id"];
        navigate(`/${sessionId}`);
      },
      sx: { cursor: "pointer" },
    }),
  });

  return (
    <Box component="div" sx={sx}>
      <MaterialReactTable table={table} />
    </Box>
  );
};
