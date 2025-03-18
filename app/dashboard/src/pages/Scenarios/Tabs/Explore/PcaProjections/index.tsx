import { Card, SxProps } from "@mui/material";
import Scatter from "./Scatter";
import { ClusteringMode } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
  mode: Omit<ClusteringMode, "boundaryDiff">;
};
export default function PcaProjection({ sx, mode }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <Scatter mode={mode} />
    </Card>
  );
}
