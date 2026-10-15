import { Box, Stack } from "@mui/material";
import Explore from "./_tabs/explore";

export default async function Page({
  params,
  searchParams,
}: {
  params?: Promise<any>;
  searchParams?: Promise<any>;
}) {
  const { id } = await params;
  const sp = (await searchParams) ?? {};

  return (
    <Stack>
      <Explore
        batchId={id}
        ego={sp.ego ? String(sp.ego) : undefined}
        k={sp.k ? String(sp.k) : undefined}
        s={sp.s ? String(sp.s) : undefined}
        section={sp.section ? String(sp.section) : undefined}
      />
    </Stack>
  );
}
