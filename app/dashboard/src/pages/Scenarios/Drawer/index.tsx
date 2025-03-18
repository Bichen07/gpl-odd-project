import ExploreIcon from "@mui/icons-material/Explore";
import FormatListBulletedIcon from "@mui/icons-material/FormatListBulleted";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";
import InfoIcon from "@mui/icons-material/Info";
import BarChartIcon from "@mui/icons-material/BarChart";
import {
  Drawer as MuiDrawer,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  ListItemButton,
  Divider,
} from "@mui/material";
import { useTheme, Theme, CSSObject } from "@mui/material/styles";
import { ReactNode, useState } from "react";
import { useLocation, useNavigate, useParams } from "react-router-dom";

const drawerWidth = 240;

const openedMixin = (theme: Theme): CSSObject => ({
  width: drawerWidth,
  transition: theme.transitions.create("width", {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen,
  }),
  overflowX: "hidden",
});

const closedMixin = (theme: Theme): CSSObject => ({
  transition: theme.transitions.create("width", {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  overflowX: "hidden",
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up("sm")]: {
    width: `calc(${theme.spacing(8)} + 1px)`,
  },
});

export default function Drawer() {
  const theme = useTheme();
  const params = useParams();
  const navigate = useNavigate();

  const [drawerOpened, setDrawerOpened] = useState(false);

  const items: { text: string; icon: ReactNode; tabName: string }[] = [
    {
      text: "List",
      icon: <FormatListBulletedIcon />,
      tabName: "list",
    },
    {
      text: "Explore",
      icon: <ExploreIcon />,
      tabName: "explore",
    },
  ];

  return (
    <MuiDrawer
      variant="permanent"
      open={drawerOpened}
      onMouseEnter={(_event) => setDrawerOpened(true)}
      onMouseLeave={(_event) => setDrawerOpened(false)}
      sx={{
        width: drawerWidth,
        flexShrink: 0,
        whiteSpace: "nowrap",
        boxSizing: "border-box",
        ...(drawerOpened && {
          ...openedMixin(theme),
          "& .MuiDrawer-paper": openedMixin(theme),
        }),
        ...(!drawerOpened && {
          ...closedMixin(theme),
          "& .MuiDrawer-paper": closedMixin(theme),
        }),
      }}
    >
      <List>
        <ListItem disablePadding sx={{ display: "block", "&:hover": {} }}>
          <ListItemButton
            sx={{
              minHeight: 48,
              justifyContent: drawerOpened ? "initial" : "center",
              px: 2.5,
              display: "flex",
              alignItems: "center",
            }}
            onClick={(_event) => navigate("/", { replace: true })}
          >
            <ListItemIcon
              sx={{
                minWidth: 0,
                mr: drawerOpened ? 3 : "auto",
                justifyContent: "center",
              }}
            >
              <ArrowBackIosNewIcon />
            </ListItemIcon>
            <ListItemText
              primary="Back to Sessions"
              sx={{ opacity: drawerOpened ? 1 : 0 }}
            />
          </ListItemButton>
        </ListItem>
      </List>
      <Divider />
      <List>
        {items.map(({ text, tabName, icon }) => (
          <ListItem
            key={text}
            disablePadding
            sx={{ display: "block", "&:hover": {} }}
          >
            <ListItemButton
              sx={{
                minHeight: 48,
                justifyContent: drawerOpened ? "initial" : "center",
                px: 2.5,
                display: "flex",
                alignItems: "center",
              }}
              onClick={(_event) =>
                navigate(`/${params["sessionId"]}/${tabName}`, {
                  replace: true,
                })
              }
            >
              <ListItemIcon
                sx={{
                  minWidth: 0,
                  mr: drawerOpened ? 3 : "auto",
                  justifyContent: "center",
                }}
              >
                {icon}
              </ListItemIcon>
              <ListItemText
                primary={text}
                sx={{ opacity: drawerOpened ? 1 : 0 }}
              />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </MuiDrawer>
  );
}
