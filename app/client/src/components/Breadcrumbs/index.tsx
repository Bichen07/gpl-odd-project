import { Box, Breadcrumbs, Link as MuiLink, Typography } from "@mui/material";
import { Link, useLocation } from "react-router-dom";
// import ItriLogo from "src/assets/itri.png";
import HomeIcon from "@mui/icons-material/Home";
import { useAppSelector } from "src/redux/hooks";

type Props = {
  replacements?: { [index: string]: string };
  skip?: number[];
};
export default ({ replacements, skip }: Props) => {
  const location = useLocation();
  const crumbs: React.ReactNode[] = [];
  const selectedClientId = useAppSelector((state) => state.client.selectedId);
  const clientOptions = useAppSelector((state) => state.client.options);

  let currentLink = "";

  location.pathname
    .split("/")
    .filter((field) => field !== "")
    .forEach((field, index) => {
      currentLink += `/${field}`;
      if (index === 0) {
        crumbs.push(
          <Box key={index}>
            {!clientOptions || !selectedClientId ? null : (
              <Typography>{clientOptions[selectedClientId].name}</Typography>
            )}
          </Box>
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
          key={index}
          component={Link}
          underline="hover"
          color="inherit"
          to={currentLink}
        >
          <Typography fontSize={14}>
            {value[0].toUpperCase() + value.substring(1)}
          </Typography>
        </MuiLink>
      );
    });

  return <Breadcrumbs>{crumbs}</Breadcrumbs>;
};
