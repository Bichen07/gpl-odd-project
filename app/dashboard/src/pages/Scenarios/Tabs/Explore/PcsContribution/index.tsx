import { Card, SxProps } from "@mui/material";
import Plot from "./Plot";
import { ClusteringMode } from "src/redux/slices/session";

type Props = {
  sx?: SxProps;
  mode: Omit<ClusteringMode, "boundaryDiff">;
};
export default function PcsContrubution({ sx, mode }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <Plot mode={mode} />
    </Card>
  );
}
