import "rc-dock/dist/rc-dock.css";
import DockLayout, { TabData } from "rc-dock";
import { useEffect, useRef, useState, createContext } from "react";
import { Box, Button, Menu, MenuItem, Stack } from "@mui/material";
import { SxProps, useTheme } from "@mui/material/styles";
import layout from "./layout";
import Settings from "./Settings";
import ParameterSpace from "./ParameterSpace";
import Violin from "./Violin";
import Legends from "./Legends";

type MenuOption = "tabs" | null;
const menuOptions: MenuOption[] = ["tabs"];

export const DockLayoutContext = createContext<DockLayout | null>(null);

type Props = {
  sx?: SxProps;
};
export default function Explore({ sx }: Props) {
  const theme = useTheme();
  const dockLayoutRef = useRef<DockLayout>(null);

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [menuOpen, setMenuOpen] = useState<MenuOption>(null);
  const [dockLayoutRefState, setDockLayoutRefState] =
    useState<DockLayout | null>(null);

  const handleMenuClick = (
    event: React.MouseEvent<HTMLButtonElement>,
    option: MenuOption,
  ) => {
    setAnchorEl(event.currentTarget);
    setMenuOpen(option);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
    setMenuOpen(null);
  };
  const handleOpenSettings = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("settings")) {
      return;
    }
    const newTab: TabData = {
      id: "settings",
      title: "settings",
      content: <Settings />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenParameterSpace = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("parameterSpace")) {
      return;
    }
    const newTab: TabData = {
      id: "parameterSpace",
      title: "parameter space",
      content: <ParameterSpace />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenViolin = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("violin")) {
      return;
    }
    const newTab: TabData = {
      id: "violin",
      title: "violin",
      content: <Violin />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "bottom");
    setMenuOpen(null);
  };
  const handleOpenLegends = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("legends")) {
      return;
    }
    const newTab: TabData = {
      id: "legends",
      title: "legends",
      content: <Legends />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "bottom");
    setMenuOpen(null);
  };

  useEffect(() => {
    if (!dockLayoutRef.current) {
      return;
    }
    setDockLayoutRefState(dockLayoutRef.current);
  }, [dockLayoutRef.current]);

  useEffect(() => {
    if (!dockLayoutRefState) {
      return;
    }
    handleOpenSettings();
    handleOpenViolin();
    handleOpenParameterSpace();
    handleOpenLegends();
  }, [dockLayoutRefState]);

  return (
    <Box
      component="div"
      sx={{
        position: "relative",
        display: "flex",
        flexDirection: "column",
        width: "100%",
        height: "100vh",
        ".dock-tabpane": {
          overflowY: "auto",
        },
        ...sx,
      }}
    >
      <Stack
        direction="row"
        spacing={0}
        sx={{
          backgroundColor: theme.palette.background.paper,
          height: "20px",
          button: {
            color: theme.palette.text.primary,
          },
        }}
      >
        {menuOptions.map((option, index) => (
          <Button
            key={index}
            size="small"
            variant="text"
            onClick={(event) => {
              handleMenuClick(event, option);
            }}
          >
            {option}
          </Button>
        ))}
      </Stack>
      <DockLayoutContext.Provider value={dockLayoutRefState}>
        <DockLayout
          ref={dockLayoutRef}
          defaultLayout={layout}
          style={{
            position: "absolute",
            left: 0,
            top: 20,
            right: 0,
            bottom: 0,
          }}
        />
      </DockLayoutContext.Provider>
      <Menu
        id="tabs-menu"
        anchorEl={anchorEl}
        open={menuOpen === "tabs"}
        onClose={handleMenuClose}
        MenuListProps={{
          "aria-labelledby": "basic-button",
        }}
      >
        <MenuItem
          disabled={
            dockLayoutRef.current && dockLayoutRef.current.find("settings")
              ? true
              : false
          }
          onClick={handleOpenSettings}
        >
          Settings
        </MenuItem>
        <MenuItem
          disabled={
            dockLayoutRef.current && dockLayoutRef.current.find("legends")
              ? true
              : false
          }
          onClick={handleOpenLegends}
        >
          Legends
        </MenuItem>
        <MenuItem
          disabled={
            dockLayoutRef.current &&
            dockLayoutRef.current.find("parameterSpace")
              ? true
              : false
          }
          onClick={handleOpenParameterSpace}
        >
          Parameter Space
        </MenuItem>
        <MenuItem
          disabled={
            dockLayoutRef.current && dockLayoutRef.current.find("violin")
              ? true
              : false
          }
          onClick={handleOpenViolin}
        >
          Violin
        </MenuItem>
      </Menu>
    </Box>
  );
}
