import { Container, Stack, Typography } from "@mui/material";
import { Batches } from "@/app/_shared/graphql/queries/batches";
import { getBatches } from "@/app/_shared/graphql/queries/batches";
import ScenarioCard from "./_components/ScenarioCard";
import Pagination from "./_components/Pagination";

export default async function Page({
  params,
  searchParams,
}: {
  params?: Promise<any>;
  searchParams?: Promise<any>;
}) {
  const { id } = await params;
  const queryParams = await searchParams;

  let page = queryParams.page ? parseInt(queryParams.page) : 1;
  let rowsPerPage: number = queryParams.rowsPerPage
    ? parseInt(queryParams.rowsPerPage)
    : 10;
  let totalPages: number = 1;
  let totalDocs: number = 0;

  let batches: Batches | null | undefined = undefined;
  try {
    batches = await getBatches({
      page,
      limit: rowsPerPage,
      where: {
        // @ts-ignore
        session: {
          equals: id,
        },
      },
    });
    totalPages = batches?.totalPages ?? 1;
    totalDocs = batches?.totalDocs ?? 0;
  } catch (err) {
    console.error(err);
  }

  return (
    <Container>
      <Stack
        sx={{
          pt: 3,
          pb: 3,
          minHeight: "100vh",
        }}
      >
        <Typography variant="h2" sx={{ mb: 2 }}>
          Batches
        </Typography>
        <Stack
          sx={{ width: "100%" }}
          flexWrap="wrap"
          direction="row"
          rowGap={3}
        >
          {batches?.docs?.map((batch, index) =>
            batch ? (
              <ScenarioCard
                key={batch.id ?? index}
                to={`/batch/${batch.id}`}
                scenario={batch?.scenario}
              />
            ) : null
          )}
        </Stack>
        <Stack sx={{ mt: 3, width: "100%" }} alignItems="center">
          <Pagination page={page} batches={batches} />
        </Stack>
      </Stack>
    </Container>
  );
}
