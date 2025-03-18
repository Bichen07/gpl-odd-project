import { Box, SxProps } from "@mui/material";
import PassRate from "./PassRate";
import TrialTable from "./TrialTable";
import Progress from "./Progress";

type Props = {
  sx?: SxProps;
};
export default function Info({ sx }: Props) {
  return (
    <Box component="div" sx={{ marginTop: 2, marginBottom: 2, ...sx }}>
      <Progress />
      <PassRate sx={{ marginTop: 2 }} />
      <TrialTable sx={{ mt: 2 }} />
    </Box>
  );
}
