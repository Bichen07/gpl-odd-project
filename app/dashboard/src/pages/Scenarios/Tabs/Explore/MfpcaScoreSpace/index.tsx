import { Card, SxProps } from "@mui/material";
import Scatter from "./Scatter";

type Props = {
  sx?: SxProps;
  isBoundaryDiffMode?: boolean;
};
export default function MfpcaScoreSpace({ sx, isBoundaryDiffMode }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <Scatter isBoundaryDiffMode={isBoundaryDiffMode} />
    </Card>
  );
}
