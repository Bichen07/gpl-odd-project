import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Divider,
  List,
  ListItem,
  ListItemText,
  Typography,
} from "@mui/material";
import Filter from "./Filter";
import { ExpandMore } from "@mui/icons-material";
import { useSessionBatches } from "src/api/services/Batches";
import { useParams } from "react-router-dom";
import { Fragment } from "react/jsx-runtime";

export function BatchesSelect({
  filteredBatchIds,
  setFilteredBatchIds,
  expanded,
  setExpanded,
}: {
  filteredBatchIds: Set<string>;
  setFilteredBatchIds: React.Dispatch<React.SetStateAction<Set<string>>>;
  expanded: Set<string>;
  setExpanded: React.Dispatch<React.SetStateAction<Set<string>>>;
}) {
  const params = useParams();

  const { data, isLoading } = useSessionBatches(params["sessionId"]);
  let batches = data?.Batches;

  return (
    <Accordion
      disableGutters
      elevation={0}
      sx={{
        backgroundColor: "background.paper",
        p: 0,
        width: "100%",
      }}
      expanded={expanded.has("clusteringScenarios")}
      onChange={() =>
        setExpanded((prev) => {
          const newSet = new Set(prev);
          const expandedId = "clusteringScenarios";
          if (newSet.has(expandedId)) {
            newSet.delete(expandedId);
          } else {
            newSet.add(expandedId);
          }
          return newSet;
        })
      }
    >
      <AccordionSummary sx={{ p: 0 }} expandIcon={<ExpandMore />}>
        <Typography>{`${
          filteredBatchIds.size > 0
            ? filteredBatchIds.size
            : Object.keys(batches?.docs ?? []).length
        } Scenarios`}</Typography>
      </AccordionSummary>
      {isLoading ? null : (
        <AccordionDetails sx={{ p: 0 }}>
          <Filter setFilteredBatchIds={setFilteredBatchIds} />
          <List sx={{ m: 0, p: 0 }}>
            {batches?.docs
              ?.filter(
                (batch) =>
                  filteredBatchIds.size === 0 ||
                  filteredBatchIds.has(batch?.id ?? ""),
              )
              .map((batch, index) => {
                return (
                  <Fragment key={batch?.id ?? index}>
                    <ListItem key={index}>
                      <ListItemText>
                        <Typography>{`${batch?.scenario.name}`}</Typography>
                      </ListItemText>
                    </ListItem>
                    <Divider
                      variant="inset"
                      component="li"
                      sx={{ width: "100%", m: 0 }}
                    />
                  </Fragment>
                );
              })}
          </List>
        </AccordionDetails>
      )}
    </Accordion>
  );
}
