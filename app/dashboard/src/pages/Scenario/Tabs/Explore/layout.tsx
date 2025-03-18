import { LayoutData } from "rc-dock";

const layout: LayoutData = {
  dockbox: {
    id: "dockbox",
    mode: "horizontal",
    children: [
      {
        id: "leftDock",
        size: 120,
        mode: "vertical",
        tabs: [],
        panelLock: { panelStyle: "main" },
      },
      {
        id: "main",
        mode: "horizontal",
        tabs: [],
        panelLock: { panelStyle: "main" },
      },
    ],
  },
  floatbox: {
    id: "floatbox",
    mode: "float",
    children: [],
  },
};

export default layout;
