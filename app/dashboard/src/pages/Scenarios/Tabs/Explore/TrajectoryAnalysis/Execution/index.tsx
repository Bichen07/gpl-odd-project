import { LoadingButton } from "@mui/lab";
import { SxProps } from "@mui/material";
import { useCallback, useContext, useEffect, useState } from "react";
import { toast } from "react-toastify";
import { ClusteringTask, getClustering } from "src/api/services/Clustering";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";
import { DockLayoutContext } from "src/pages/Scenarios/Tabs/Explore/index";
import { getTrajectoryAnalysis } from "src/api/services/TrajectoryAnalysis";

type Props = {
  sx?: SxProps;
  batchIds: string[];
  tasks: ClusteringTask[];
};
export function Execution({ batchIds, sx, tasks }: Props) {
  const dispatch = useAppDispatch();
  const dockLayout = useContext(DockLayoutContext);
  const [loading, setLoading] = useState(false);

  const clusteringResponse = useAppSelector(
    (state) => state.session.clusteringResponse,
  );

  const execute = () => {
    const fetchData = async () => {
      try {
        const newResponse = await getTrajectoryAnalysis({
          batchIds,
          framePeriod: 0.25,
          // framePeriod: 0.25,
          tasks,
        }).then((response) => response.data);
        setLoading(false);
        console.log(newResponse);
        dispatch(
          sessionSlice.actions.setTrajectoryAnalysisResponse(newResponse),
        );
      } catch (error) {
        console.error(error);
        setLoading(false);
        toast.error("Clustering failed!");
      }
    };

    setLoading(true);
    fetchData();
  };

  useEffect(() => {
    if (clusteringResponse === null) {
      return;
    }
    const createNewTabs = () => {
      if (!dockLayout) {
        return;
      }
      // if (!dockLayout.find("clusteringResponse")) {
      //   const newTab: TabData = {
      //     id: "clusteringResponse",
      //     title: "clustering response",
      //     content: <ClusteringResponse isBoundaryDiffMode={false} />,
      //     closable: true,
      //   };
      //   dockLayout.dockMove(newTab, "leftDock", "middle");
      // }
      // if (!dockLayout.find("mfpca")) {
      //   const newTab: TabData = {
      //     id: `mfpca-score-space-${new Date(Date.now()).toISOString()}`,
      //     title: "MFPCA Score Space",
      //     content: <MfpcaScoreSpace />,
      //     closable: true,
      //   };
      //   dockLayout.dockMove(newTab, "float", "middle");
      // }
    };
    createNewTabs();
  }, [clusteringResponse]);

  return (
    <LoadingButton
      variant="contained"
      sx={{ width: "100%", ...sx }}
      onClick={execute}
      loading={loading}
    >
      Analysis
    </LoadingButton>
  );
}
