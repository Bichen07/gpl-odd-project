import {
  Box,
  Breadcrumbs,
  Link as MuiLink,
  SxProps,
  Typography,
} from "@mui/material";
import { Link, useLocation } from "react-router-dom";
import AllInboxIcon from "@mui/icons-material/AllInbox";

type Props = {
  replacements?: { [index: string]: string };
  skip?: number[];
  sx?: SxProps;
};
export default ({ replacements, skip, sx }: Props) => {
  const location = useLocation();
  const crumbs: React.ReactNode[] = [];

  let currentLink = "";

  location.pathname
    .split("/")
    .filter((field) => field !== "")
    .forEach((field, index) => {
      currentLink += `/${field}`;
      if (index === 0) {
        crumbs.push(
          <MuiLink
            key={index}
            component={Link}
            underline="hover"
            color="inherit"
            to={"/"}
          >
            <Box key={index}>
              <Typography fontSize={14}>Sessions</Typography>
            </Box>
          </MuiLink>,
        );
      }
      const skipSet = new Set(skip);
      if (skip && skipSet.has(index)) {
        return;
      }
      let value = field;
      if (replacements && index.toString() in replacements) {
        value = replacements[index];
      }
      crumbs.push(
        <MuiLink
          sx={sx}
          key={index}
          component={Link}
          underline="hover"
          color="inherit"
          to={currentLink}
        >
          <Typography fontSize={14}>
            {value[0].toUpperCase() + value.substring(1)}
          </Typography>
        </MuiLink>,
      );
    });

  return <Breadcrumbs sx={{ pt: 1, pb: 1 }}>{crumbs}</Breadcrumbs>;
};
