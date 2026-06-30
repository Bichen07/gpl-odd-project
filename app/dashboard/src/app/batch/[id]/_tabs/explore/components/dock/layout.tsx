import { LayoutData } from "rc-dock";
import Heatmap from "./panels/Heatmap";
import Replayer from "./panels/Replayer";
import ClusteringSelection from "./panels/ClusteringSelection";
import Controls from "./panels/Controls";
import ProjectionSpace from "./panels/ProjectionSpace";
import ParameterSpace from "./panels/ParameterSpace";
import Legends from "./panels/Legends";
import MissionControl from "./panels/MissionControl";

const layout: LayoutData = {
  dockbox: {
    id: "dockbox",
    mode: "horizontal",
    children: [
      {
        id: "miscDock",
        mode: "vertical",
        size: 50,
        children: [
          {
            id: "1-misc-top",
            tabs: [
              {
                id: "controls",
                title: "Filtering",
                content: <Controls />,
              },
              {
                id: "clusteringSelection",
                title: "Clustering Selection",
                content: <ClusteringSelection />,
              },
              {
                id: "legends",
                title: "Legends",
                content: <Legends />,
              },
              {
                id: "missionControl",
                title: "🚀 Mission Control",
                content: <MissionControl />,
                // Keep WebSocket + run state when maximizing another panel (rc-dock otherwise unmounts).
                cached: true,
              },
            ],
          },
        ],
        panelLock: { panelStyle: "top" },
      },
      {
        id: "parameterSpaceDock",
        mode: "vertical",
        size: 90,
        children: [
          {
            id: "2-space-top",
            tabs: [
              {
                id: "parameterSpace",
                title: "Parameter Space",
                content: <ParameterSpace />,
              },
            ],
          },
          {
            id: "2-space-down",
            tabs: [
              // {
              //   id: "parameterSpace",
              //   title: "Parameter Space",
              //   content: <ParameterSpace />,
              // },
              {
                id: "projectionSpace",
                title: "Trajectory Projection",
                content: <ProjectionSpace />,
              },
            ],
          },
        ],
      },
      // {
      //   id: "projectionSpaceDeck",
      //   mode: "vertical",
      //   size: 90,
      //   children: [
      //     {
      //       id: "3-space-top",
      //       tabs: [
      //         {
      //           id: "projectionSpace",
      //           title: "Trajectory Projection",
      //           content: <ProjectionSpace />,
      //         },
      //       ],
      //     },
      //   ],
      // },
      {
        id: "replayDock",
        mode: "vertical",
        size: 40,
        children: [
          {
            id: "4-middle-panel",
            tabs: [
              {
                id: "replayer",
                title: "Replayer",
                content: <Replayer />,
                cached: true,
              },
            ],
          },
        ],
      },
      {
        id: "heatmapDock",
        mode: "vertical",
        children: [
          {
            id: "right-panel",
            tabs: [
              {
                id: "heatmap",
                title: "Heatmap",
                content: <Heatmap />,
                cached: true,
              },
            ],
            panelLock: { panelStyle: "right" },
          },
        ],
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
