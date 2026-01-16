// @ts-nocheck
"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  type MRT_ColumnDef,
  useMaterialReactTable,
  MRT_PaginationState,
  MaterialReactTable,
} from "material-react-table";
import { Session, Sessions } from "@/app/_shared/graphql/__generated__/graphql";
import { Object } from "ts-toolbelt";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

type Props = {
  data?: Object.Path<Sessions, ["docs"]>;
  page: number;
  totalDocs: number;
  rowsPerPage: number;
};
export const Table = ({ data, page, rowsPerPage, totalDocs }: Props) => {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [pagination, setPagination] = useState<MRT_PaginationState>({
    pageIndex: page,
    pageSize: rowsPerPage,
  });

  // Get a new searchParams string by merging the current
  // searchParams with a provided key/value pair
  const createQueryString = useCallback(
    (newQueries: { name: string; value: string }[]) => {
      const params = new URLSearchParams(searchParams.toString());
      for (const query of newQueries) {
        params.set(query.name, query.value);
      }

      return params.toString();
    },
    [searchParams]
  );

  useEffect(() => {
    router.push(
      pathname +
      "?" +
      createQueryString([
        { name: "page", value: (pagination.pageIndex + 1).toString() },
        { name: "rowsPerPage", value: pagination.pageSize.toString() },
      ])
    );
  }, [pagination]);

  const columns = useMemo<MRT_ColumnDef<Session>[]>(
    () => [
      {
        accessorKey: "id",
        header: "ID",
      },
      {
        accessorKey: "updatedAt",
        header: "UpdatedAt",
      },
    ],
    []
  );

  const table = useMaterialReactTable({
    columns,
    data: data ?? [], //data must be memoized or stable (useState, useMemo, defined outside of this component, etc.)
    enableKeyboardShortcuts: false,
    enableColumnActions: false,
    enableColumnFilters: false,
    enableSorting: false,
    enableGlobalFilter: false,
    enableDensityToggle: false,
    enableHiding: false,
    enableFullScreenToggle: false,
    enableTopToolbar: false,
    rowCount: totalDocs,
    state: {
      isLoading: data == null,
      pagination,
    },

    manualPagination: true, //turn off built-in client-side pagination
    onPaginationChange: setPagination,

    muiTableBodyRowProps: ({ row }) => ({
      onClick: (event) => {
        if (data == null) {
          return;
        }
        router.push(pathname + "/" + data[row.index].id);
      },
      sx: {
        cursor: "pointer", //you might want to change the cursor too when adding an onClick
      },
    }),

    muiTablePaperProps: {
      elevation: 0, //change the mui box shadow
    },
  });

  //using MRT_Table instead of MaterialReactTable if we do not need any of the toolbar components or features
  return <MaterialReactTable table={table} />;
};

export default Table;
