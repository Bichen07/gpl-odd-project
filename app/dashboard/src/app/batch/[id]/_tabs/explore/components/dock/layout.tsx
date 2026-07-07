import { LayoutData, PanelData, DockContext } from "rc-dock";
import Heatmap from "./panels/Heatmap";
import Replayer from "./panels/Replayer";
import ClusteringSelection from "./panels/ClusteringSelection";
import Controls from "./panels/Controls";
import ProjectionSpace from "./panels/ProjectionSpace";
import ParameterSpace from "./panels/ParameterSpace";
import Legends from "./panels/Legends";
import MissionControl from "./panels/MissionControl";
import ScatterplotControlsHelp from "@/app/_shared/components/ScatterplotControlsHelp";

// Renders the tab-bar extra content for the scatterplot panels: the shared "?"
// controls-help button followed by the native maximize/restore button.
//
// rc-dock renders the default maximize button only when a panel has NO custom
// `panelExtra`. Because we set `panelLock.panelExtra`, that default button is
// suppressed, so we have to render it ourselves (identical markup + behaviour)
// right after the help button — keeping the fullscreen toggle every other panel
// has. `context` is always supplied by rc-dock at call time; it's typed
// optional only so the function stays assignable to `PanelLock.panelExtra`.
const renderScatterplotHelp = (
  panel: PanelData,
  context?: DockContext,
): React.ReactElement => {
  const title =
    panel.activeId === "parameterSpace"
      ? "Parameter Space controls"
      : panel.activeId === "projectionSpace"
        ? "Trajectory Projection controls"
        : null;
  if (title == null) {
    return <span />;
  }
  const isMaximized = panel.parent?.mode === "maximize";
  return (
    <>
      <ScatterplotControlsHelp title={title} />
      <div
        className={isMaximized ? "dock-panel-min-btn" : "dock-panel-max-btn"}
        onClick={() => context?.dockMove(panel, null, "maximize")}
      />
    </>
  );
};

const layout: LayoutData = {
  dockbox: {
    id: "dockbox",
    mode: "horizontal",
    children: [
      {
        id: "miscDock",
        mode: "vertical",
        size: 120,
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
        size: 200,
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
            panelLock: { panelExtra: renderScatterplotHelp },
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
            panelLock: { panelExtra: renderScatterplotHelp },
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
        size: 250,
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
