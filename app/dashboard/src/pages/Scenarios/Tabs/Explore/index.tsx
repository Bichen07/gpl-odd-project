import "rc-dock/dist/rc-dock.css";
import DockLayout, { TabData } from "rc-dock";
import { useEffect, useRef, useState, createContext } from "react";
import { Box, Button, Menu, MenuItem, Stack } from "@mui/material";
import { SxProps, useTheme } from "@mui/material/styles";
import layout from "./layout";
import Clustering from "./Clustering";
import SamplingViewer from "./SamplingViewer";
import Replayer from "./Replayer";
import ClusteringResponse from "./ClusteringResponse";
import EmbeddingSpace from "./EmbeddingSpace";
import { TimeSeries } from "./TimeSeries";
import ClusterParameterSpaces from "./ClusterParameterSpaces";
import MfpcaScoreSpace from "./MfpcaScoreSpace";
import { MfpcaFpcs } from "./MfpcaFpcs";
import CriticalStateProjection from "./CriticalStatePcaProjections";
import CriticalStatePcsContrubution from "./CriticalStatePcContribution";
import SafetyMarginViolationStateProjection from "./SafetyMarginViolationStatePcaProjections";
import SafetyMarginViolationStateClusteringResponse from "./SafetyMarginViolationStateClusteringResponse";
import { ClusteringMode } from "src/redux/slices/session";
import PcaProjection from "./PcaProjections";
import PcsContrubution from "./PcsContribution";
import TrajectoryAnalysis from "./TrajectoryAnalysis";
import TrajectoryViewer from "./TrajectoryViewer";
import TrajectoryAnalysisMfpca from "./TrajectoryAnalysisMfpca";
import TrajectoryAnalysisClusteringResponse from "./TrajectoryAnalysisClusteringResponse";
import ParameterSpace from "./TrajectoryAnalysisParameterSpace";
import GradientScatter2D from "./GradientScatter2D";
import GradientClusteringResponse from "./GradientClusteringResponse";
import GradientKernelDensity from "./GradientKernelDensity";
import MapTrajectoriesViewer from "./MapTrajectoriesViewer";
import StateAnalysis from "./StateAnalysis";
import StateScope from "./StateScope";
import CaseScope from "./CaseScope";
import VectorField from "./TrajectoryAnalysisParameterSpace/VectorField";
import HeightMap from "./HeightMap";
import TrajectoryHeatmap from "./TrajectoryHeatmap";

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
  const handleOpenClustering = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("settings")) {
      return;
    }
    const newTab: TabData = {
      id: "clustering",
      title: "clustering",
      content: <Clustering />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenSamplingViewer = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("Sampling Viewer")) {
      return;
    }
    const newTab: TabData = {
      id: "samplingViewer",
      title: "sampling viewer",
      content: <SamplingViewer />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topRight", "middle");
    setMenuOpen(null);
  };
  const handleOpenReplayer = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("replayer")) {
      return;
    }
    const newTab: TabData = {
      id: "replayer",
      title: "replayer",
      content: <Replayer />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "rightDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenClusteringResponse = (mode: ClusteringMode) => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find(`${mode}ClusteringResponse`)) {
      return;
    }
    const newTab: TabData = {
      id: `${mode}ClusteringResponse`,
      title: `${mode} clustering response`,
      content: <ClusteringResponse mode={mode} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenEmbeddingSpace = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("embeddingSpace")) {
      return;
    }
    const newTab: TabData = {
      id: "embeddingSpace",
      title: "embedding space",
      content: <EmbeddingSpace />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenTimeSeries = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("timeSeries")) {
      return;
    }
    const newTab: TabData = {
      id: "timeSeries",
      title: "time series",
      content: <TimeSeries />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "rightDock", "top");
    setMenuOpen(null);
  };
  const handleOpenClusterParameterSpaces = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("clusterParameterSpace")) {
      return;
    }
    const newTab: TabData = {
      id: "clusterParameterSpace",
      title: "cluster parameter space",
      content: <ClusterParameterSpaces />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenPcaProjection = (
    mode: Omit<ClusteringMode, "boundaryDiff">,
  ) => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `${mode}-pca-projection-${new Date(Date.now()).toISOString()}`,
      title: `${mode} PCA Projection`,
      content: <PcaProjection mode={mode} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenPcsLoadings = (
    mode: Omit<ClusteringMode, "boundaryDiff">,
  ) => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `${mode}-pcs-loadings-${new Date(Date.now()).toISOString()}`,
      title: `${mode} PCs Loadings`,
      content: <PcsContrubution mode={mode} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenCriticalStatePcaProjection = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `criticalState-pca-projection-${new Date(Date.now()).toISOString()}`,
      title: "Critical State PCA Projection",
      content: <CriticalStateProjection />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenCriticalStatePcsContribution = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `criticalState-pcs-loadings-${new Date(Date.now()).toISOString()}`,
      title: "Critical State PCs Loadings",
      content: <CriticalStatePcsContrubution />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenBoundaryDiffMfpcaScoreSpace = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `boundaryDiff-mfpca-score-space-${new Date(
        Date.now(),
      ).toISOString()}`,
      title: "Boundary Diff MFPCA Score Space",
      content: <MfpcaScoreSpace isBoundaryDiffMode={true} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenFailureScoreSpace = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `boundaryDiff-mfpca-score-space-${new Date(
        Date.now(),
      ).toISOString()}`,
      title: "Failure MFPCA Score Space",
      content: <MfpcaScoreSpace isBoundaryDiffMode={false} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenMfpcaFpcs = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    // if (dockLayoutRef.current.find("mfpcaFpcs")) {
    //   return;
    // }
    const newTab: TabData = {
      id: `failure-mfpcaFpcs-${new Date(Date.now()).toISOString()}`,
      title: "Failure MFPCA FPCs",
      content: <MfpcaFpcs isBoundaryDiffMode={false} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenTrajectoryAnalysis = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "trajectory-analysis",
      title: "Trajectory Analysis",
      content: <TrajectoryAnalysis />,
      // closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenGradientKernelDensitry = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "gradient-kernel-density",
      title: "Gradient Kernel Density",
      content: <GradientKernelDensity />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenGradientClusteringResopnse = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "gradient-clustering-response",
      title: "Gradient Clustering Response",
      content: <GradientClusteringResponse />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenTrajectoryAnalysisClusteringResopnse = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "trajectory-analysis-clustering-response",
      title: "Clustering Results",
      content: <TrajectoryAnalysisClusteringResponse />,
      // closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topLeft", "middle");
    setMenuOpen(null);
  };
  const handleOpenTrajectoryViewer = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "trajectory-viewer",
      title: "Trajectory Viewer",
      content: <TrajectoryViewer />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenTimeSeriesHeatmap = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "timeseries-heatmap",
      title: "Trajectory Heatmap",
      content: <TrajectoryHeatmap />,
      // closable: true,
    };

    dockLayoutRef.current.dockMove(newTab, "topRight", "middle");
    setMenuOpen(null);
  };
  const handleOpenTimeSeriesMfpca = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("timeseries-mfpca")) {
      return;
    }
    const newTab: TabData = {
      id: "timeseries-mfpca",
      title: "MFPCA Space",
      content: <TrajectoryAnalysisMfpca />,
      // closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topLeft", "middle");
    setMenuOpen(null);
  };
  const handleOpenGradientScatter = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "gradient-scatter",
      title: "Gradient Scatter",
      content: <GradientScatter2D />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  // const handleOpenParameterSpace = () => {
  //   if (!dockLayoutRef.current) {
  //     return;
  //   }
  //   const newTab: TabData = {
  //     id: "parameterspace",
  //     title: "ParameterSpace",
  //     content: <TrajectoryAnalysisSamplingViewer />,
  //     // closable: true,
  //   };
  //   dockLayoutRef.current.dockMove(newTab, "topDock", "middle");
  //   setMenuOpen(null);
  // };
  const handleOpenVectorField = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("Parameter Space")) {
      return;
    }
    const newTab: TabData = {
      id: "vector-field",
      title: "Parameter Space",
      content: <ParameterSpace />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topRight", "middle");
    setMenuOpen(null);
    return newTab;
  };
  const handleOpenHeightMap = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `height-map-${Date.now().toString()}`,
      title: "Height Map",
      content: <HeightMap />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topRight", "middle");
    setMenuOpen(null);
  };
  const handleOpenMapTrajectoriesViewer = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "map-traj-viewer",
      title: "Multi-Case Replayer",
      content: <MapTrajectoriesViewer />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "topLeft", "middle");
    setMenuOpen(null);
  };
  const handleOpenStateAnalysis = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "stateAnalysis",
      title: "State Analysis",
      content: <StateAnalysis />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenStateScope = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "statescope",
      title: "State Scope",
      content: <StateScope />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "middle");
    setMenuOpen(null);
  };
  const handleOpenCaseScope = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: "casescope",
      title: "Case Scope",
      content: <CaseScope sx={{ overflow: "hidden" }} />,
      // closable: true,
    };

    dockLayoutRef.current.dockMove(newTab, "topLeft", "middle");
    setMenuOpen(null);
  };
  const handleOpenBoundaryDiffMfpcaFpcs = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    const newTab: TabData = {
      id: `boundaryDiff-mfpcaFpcs-${new Date(Date.now()).toISOString()}`,
      title: "BoundaryDiff MFPCA FPCs",
      content: <MfpcaFpcs isBoundaryDiffMode={true} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "leftDock", "middle");
    setMenuOpen(null);
  };
  const handleOpenBoundaryDifferenceEmbeddingSpace = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("boundaryDifferenceEmbeddingSpace")) {
      return;
    }
    const newTab: TabData = {
      id: "boundaryDifferenceEmbeddingSpace",
      title: "boundary difference embedding space",
      content: <EmbeddingSpace isBoundaryDiffMode={true} />,
      closable: true,
    };
    dockLayoutRef.current.dockMove(newTab, "main", "bottom");
    setMenuOpen(null);
  };
  const handleOpenBoundaryDifferenceClusteringResults = () => {
    if (!dockLayoutRef.current) {
      return;
    }
    if (dockLayoutRef.current.find("boundaryDifferenceClusteringResults")) {
      return;
    }
    const newTab: TabData = {
      id: "boundaryDifferenceClusteringResults",
      title: "boundary difference clustering results",
      content: <ClusteringResponse isBoundaryDiffMode={true} />,
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
    // const casescope = document.getElementById("casescope");
    // if (casescope) {
    //   casescope.style.overflow = "hidden";
    // }
    // handleOpenClustering();
    // handleOpenTrajectoryAnalysis();
    // handleOpenHeightMap();
    // handleOpenSamplingViewer();
    handleOpenTrajectoryAnalysisClusteringResopnse();
    handleOpenTimeSeriesMfpca();
    // handleOpenParameterSpace();
    handleOpenCaseScope();
    const t = handleOpenVectorField();
    handleOpenTimeSeriesHeatmap();
    handleOpenMapTrajectoriesViewer();
    // handleOpenStateAnalysis();
    // handleOpenReplayer();
  }, [dockLayoutRefState]);

  return (
    <Box
      component="div"
      sx={{
        position: "relative",
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        overflowY: "hidden",
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
            top: 0,
            right: 0,
            bottom: 0,
          }}
        />
      </DockLayoutContext.Provider>
    </Box>
  );
}
