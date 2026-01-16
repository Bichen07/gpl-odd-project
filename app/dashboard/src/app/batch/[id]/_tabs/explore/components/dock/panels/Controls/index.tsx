import {
  Stack,
  Typography,
  Accordion,
  AccordionSummary,
  AccordionDetails,
} from "@mui/material";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import { MouseEvent, useState } from "react";
import Filtering from "./Filtering";
import HeatmapAndReplayer from "./HeatmapAndReplayer";
import Global from "./Global";

export default function Controls() {
  const [menuOpened, setMenuOpened] = useState<string | null>(null);
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  const handleMenuAnchorClick = (event: MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpened(null);
  };
  const elevation = 1;
  const fontSize = 18;
  return (
    <Stack>
      <Accordion elevation={elevation} disableGutters square>
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          <Typography component="span" fontSize={fontSize}>
            Filtering
          </Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Stack>
            <Filtering />
          </Stack>
        </AccordionDetails>
      </Accordion>
      <Accordion elevation={elevation} disableGutters square>
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          <Typography component="span" fontSize={fontSize}>
            Heatmap
          </Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Stack>
            <HeatmapAndReplayer
              anchorEl={anchorEl}
              menuOpened={menuOpened}
              handleMenuClose={handleMenuClose}
              handleMenuAnchorClick={handleMenuAnchorClick}
              setMenuOpened={setMenuOpened}
            />
          </Stack>
        </AccordionDetails>
      </Accordion>
      <Accordion elevation={elevation} disableGutters square>
        <AccordionSummary expandIcon={<ExpandMoreIcon />}>
          <Typography component="span" fontSize={fontSize}>
            Criticality Metric
          </Typography>
        </AccordionSummary>
        <AccordionDetails>
          <Stack>
            <Global />
          </Stack>
        </AccordionDetails>
      </Accordion>
    </Stack>
  );
}
