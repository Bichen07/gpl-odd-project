import { Box } from "@mui/material";

import { useTheme } from "@mui/material/styles";
import { useParams } from "react-router-dom";
import Breadcrumbs from "src/components/Breadcrumbs";
import List from "./Tabs/List";
import Drawer from "./Drawer";
import Explore from "./Tabs/Explore";

export default function Scenario() {
  const theme = useTheme();
  const params = useParams();
  return (
    <Box component="div">
      <Drawer />
      <Box
        component="div"
        sx={{
          paddingLeft: `calc(${theme.spacing(8)} + ${params["tabName"] === "explore" ? "0px" : "2rem"
            })`,
          paddingRight: params["tabName"] === "explore" ? 0 : "2rem",
          paddingBottom: params["tabName"] === "explore" ? 0 : "2rem",
        }}
      >
        <Box
          component="div"
          sx={{
            mt: 3,
            mb: 3,
            display: params["tabName"] === "explore" ? "none" : "initial",
          }}
        >
          <Breadcrumbs />
        </Box>
        <List
          sx={{
            display:
              !params["tabName"] || params["tabName"] === "list"
                ? "initial"
                : "none",
          }}
        />
        <Explore
          sx={{
            display: params["tabName"] === "explore" ? "flex" : "none",
          }}
        />
      </Box>
    </Box>
  );
}
