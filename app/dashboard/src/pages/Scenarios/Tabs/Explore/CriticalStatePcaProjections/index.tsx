import { Card, SxProps } from "@mui/material";
import Scatter from "./Scatter";

type Props = {
  sx?: SxProps;
};
export default function CriticalStateProjection({ sx }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <Scatter />
    </Card>
  );
}
