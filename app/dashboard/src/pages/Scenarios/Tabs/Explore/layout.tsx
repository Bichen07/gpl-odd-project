import { LayoutData } from "rc-dock";
import TrajectoryAnalysisMfpca from "./TrajectoryAnalysisMfpca";
import MapTrajectoriesViewer from "./MapTrajectoriesViewer";
import TrajectoryAnalysis from "./TrajectoryAnalysis";
import TrajectoryHeatmap from "./TrajectoryHeatmap";
import SamplingViewer from "./SamplingViewer";

const layout: LayoutData = {
  dockbox: {
    id: "dockbox",
    mode: "vertical",
    children: [
      {
        id: "topDock",
        mode: "horizontal",
        size: 500,
        panelLock: { panelStyle: "main" },
        children: [
          {
            tabs: [
              {
                id: "topLeft",
                title: "Trajectory Analysis",
                content: <TrajectoryAnalysis />,
                closable: false,
              },
            ],
          },
          {
            tabs: [
              {
                id: "topRight",
                title: "Sampling Viewer",
                content: <SamplingViewer />,
                closable: false,
              },
            ],
          },
        ],
      },
      // {
      //   id: "main",
      //   mode: "vertical",
      //   tabs: [],
      //   panelLock: { panelStyle: "main" },
      // },
    ],
  },
  floatbox: {
    id: "floatbox",
    mode: "float",
    children: [],
  },
};

export default layout;
