import { Card, CardContent, SxProps } from "@mui/material";
import Scatter from "./Scatter";

type Props = {
  sx?: SxProps;
  isBoundaryDiffMode?: boolean;
};
export default function EmbeddingSpace({ sx, isBoundaryDiffMode }: Props) {
  return (
    <Card
      elevation={0}
      sx={{ backgroundColor: "background.default", height: "100%", ...sx }}
    >
      <CardContent
        sx={{
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "space-between",
          p: 0,
        }}
      >
        <Scatter isBoundaryDiffMode={isBoundaryDiffMode} />
      </CardContent>
    </Card>
  );
}
