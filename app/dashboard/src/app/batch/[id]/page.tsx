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

  return (
    <Stack>
      <Explore batchId={id} />
    </Stack>
  );
}
