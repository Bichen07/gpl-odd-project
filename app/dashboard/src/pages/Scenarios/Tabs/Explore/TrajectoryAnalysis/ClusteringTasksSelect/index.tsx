import { ExpandMore } from "@mui/icons-material";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Divider,
  List,
  ListItem,
  Typography,
} from "@mui/material";
import { Fragment } from "react/jsx-runtime";
import { ClusteringTask } from "src/api/services/Clustering";
import Labeler from "src/components/Labeler";

type Props = {
  expanded: Set<string>;
  setExpanded: React.Dispatch<React.SetStateAction<Set<string>>>;
  tasks: ClusteringTask[];
  setTasks: React.Dispatch<React.SetStateAction<ClusteringTask[]>>;
};
export function ClusteringTaskSelect({
  tasks,
  setTasks,
  expanded,
  setExpanded,
}: Props) {
  return (
    <Accordion
      expanded={expanded.has("ClusteringTaskSelect")}
      onChange={() =>
        setExpanded((prev) => {
          const newSet = new Set(prev);
          const expandedId = "ClusteringTaskSelect";
          if (newSet.has(expandedId)) {
            newSet.delete(expandedId);
          } else {
            newSet.add(expandedId);
          }
          return newSet;
        })
      }
      disableGutters
      elevation={0}
      sx={{
        backgroundColor: "background.paper",
        width: "100%",
      }}
      square
    >
      <AccordionSummary
        aria-controls="panel1d-content"
        id="panel1d-header"
        expandIcon={<ExpandMore />}
        sx={{ p: 0 }}
      >
        <Typography>{`${tasks.length} Clustering Tasks`}</Typography>
      </AccordionSummary>
      <AccordionDetails sx={{ p: 0 }}>
        <List>
          {tasks.map((item, index) => (
            <Fragment key={index}>
              <ListItem
                sx={{
                  display: "flex",
                  columnGap: "2rem",
                  rowGap: "1rem",
                  alignItems: "center",
                  flexWrap: "wrap",
                }}
              >
                <Typography>{index}</Typography>
                <Labeler label="method">
                  <Typography>{item.method}</Typography>
                </Labeler>
                {item.nClusters === 0 ? null : (
                  <Labeler label="nClusters">
                    <Typography>{item.nClusters}</Typography>
                  </Labeler>
                )}
              </ListItem>
              <Divider />
            </Fragment>
          ))}
        </List>
      </AccordionDetails>
    </Accordion>
  );
}
