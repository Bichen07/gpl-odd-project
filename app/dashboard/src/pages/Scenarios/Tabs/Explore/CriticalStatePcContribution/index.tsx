import { Card, SxProps } from "@mui/material";
import Plot from "./Plot";

type Props = {
  sx?: SxProps;
};
export default function CriticalStatePcsContrubution({ sx }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <Plot />
    </Card>
  );
}
