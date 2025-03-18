import { Box, Stack, SxProps, Typography } from "@mui/material";
import Pagination from "@mui/material/Pagination";
import ScenarioCard from "./ScenarioCard";
import { useParams, useSearchParams } from "react-router-dom";
import Filter from "./Filter";
import { useSessionBatches } from "src/api/services/Batches";
import { useState } from "react";

type Props = {
  sx?: SxProps;
};
export default function List({ sx }: Props) {
  const params = useParams();

  const [searchParams, setSearchParams] = useSearchParams();
  const [filterKeywords, setFilterKeywords] = useState<Set<string>>(
    new Set<string>(),
  );

  const { data, isLoading, isError } = useSessionBatches(params["sessionId"]);

  const itemsPerPage = 16;
  const page = parseInt(searchParams.get("page") ?? "1");

  let cardDeck = null;
  if (
    isError ||
    (data?.Batches && data.Batches.docs && data.Batches.docs.length === 0)
  ) {
    cardDeck = (
      <Stack
        justifyContent="center"
        alignItems="center"
        sx={{ width: "100%", minHeight: "60vh" }}
      >
        <Typography variant="h2" color="text.disabled">
          {isError ? "Error" : "Empty"}
        </Typography>
      </Stack>
    );
  } else if (isLoading || data) {
    cardDeck = (
      <Stack sx={{ width: "100%" }} flexWrap="wrap" direction="row" rowGap={3}>
        {isLoading
          ? Array.from(Array(itemsPerPage)).map((_, index) => (
              <ScenarioCard key={index} scenario={null} />
            ))
          : data?.Batches?.docs
              ?.slice(
                itemsPerPage * (page - 1),
                itemsPerPage * (page - 1) + itemsPerPage + 1,
              )
              .filter((doc) => {
                if (filterKeywords.size === 0) {
                  return true;
                }
                for (const filterKeyword of filterKeywords) {
                  if ((doc?.scenario.name ?? "").includes(filterKeyword)) {
                    return true;
                  }
                }
                return false;
              })
              .map((batch, index) =>
                batch ? (
                  <ScenarioCard
                    key={batch.id ?? index}
                    to={`/${params["sessionId"]}/batch/${batch.id}`}
                    scenario={batch?.scenario}
                  />
                ) : null,
              )}
      </Stack>
    );
  }

  return (
    <Box
      component="div"
      sx={{
        pt: 3,
        pb: 3,
        display: "flex",
        flexDirection: "column",
        minHeight: "100vh",
        ...sx,
      }}
    >
      <Typography variant="h3" sx={{ mb: 1 }}>
        Batches
      </Typography>
      <Filter keywords={filterKeywords} setKeywords={setFilterKeywords} />
      {cardDeck}
      <Stack sx={{ mt: 3, width: "100%" }} alignItems="center">
        {isLoading || !data ? null : (
          <Pagination
            sx={{
              display: `${data.Batches?.totalPages ?? 0 > 1 ? "flex" : "none"}`,
            }}
            page={page}
            count={
              isLoading ? undefined : data.Batches?.totalPages ?? undefined
            }
            variant="outlined"
            shape="rounded"
            onChange={(_, page) =>
              setSearchParams((prev) => {
                return { ...prev, page: `${page}` };
              })
            }
          />
        )}
      </Stack>
    </Box>
  );
}
