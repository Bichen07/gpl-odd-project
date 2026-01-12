import { getDocs } from "@/app/_shared/api";
import { Sessions } from "@/app/_shared/graphql/__generated__/graphql";
import { Container, Stack, Typography } from "@mui/material";
import Table from "@/app/sessions/_components/Table";

export default async function Page({
  params,
  searchParams,
}: {
  params?: Promise<any>;
  searchParams?: Promise<any>;
}) {
  const queryParams = await searchParams;

  let page = queryParams.page ? parseInt(queryParams.page) : 0;
  let rowsPerPage: number = queryParams.rowsPerPage
    ? parseInt(queryParams.rowsPerPage)
    : 10;
  let totalPages: number = 1;
  let totalDocs: number = 0;

  let sessions: Sessions | undefined = undefined;

  try {
    sessions = await getDocs<Sessions>("sessions", {
      page,
      limit: rowsPerPage,
    }).then((response) => response.data);
    totalPages = sessions?.totalPages ?? 1;
    totalDocs = sessions?.totalDocs ?? 0;
  } catch (err) {
    console.error(err);
  }

  return (
    <Container>
      <Stack rowGap={3} sx={{ mt: 3 }}>
        <Typography variant="h2">Sessions</Typography>
        <Table
          data={sessions?.docs}
          page={page}
          rowsPerPage={rowsPerPage}
          totalDocs={totalDocs}
        />
      </Stack>
    </Container>
  );
}
