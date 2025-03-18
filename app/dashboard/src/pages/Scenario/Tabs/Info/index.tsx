import { Box, SxProps } from "@mui/material";
import Introduction from "./Introduction";

type Props = {
  sx?: SxProps;
};
export default function Report({ sx }: Props) {
  return (
    <Box component="div" sx={sx}>
      <Introduction />
    </Box>
  );
}
