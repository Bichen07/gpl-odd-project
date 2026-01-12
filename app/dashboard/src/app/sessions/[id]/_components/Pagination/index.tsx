"use client";

import { Batches } from "@/app/_shared/graphql/queries/batches";
import { Pagination as MuiPagination } from "@mui/material";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { useCallback } from "react";

type Props = {
  batches: Batches | null | undefined;
  page: number;
};
export default function Pagination({ batches, page }: Props) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

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
    [searchParams],
  );

  return (
    <MuiPagination
      sx={{
        display: `${(batches?.totalPages ?? 0 > 1) ? "flex" : "none"}`,
      }}
      page={page}
      count={batches?.totalPages ?? undefined}
      variant="outlined"
      shape="rounded"
      onChange={(_, newPage) =>
        router.push(
          pathname +
          "?" +
          createQueryString([{ name: "page", value: newPage.toString() }]),
        )
      }
    />
  );
}
