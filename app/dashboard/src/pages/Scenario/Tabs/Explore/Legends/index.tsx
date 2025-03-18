import { Stack, SxProps } from "@mui/material";
import Output from "./Output";

type Props = {
  sx?: SxProps;
};
export default ({ sx }: Props) => {
  return (
    <Stack
      direction="row"
      flexWrap="wrap"
      sx={{ width: "100%", height: "100%", ...sx }}
      columnGap={1}
    >
      <Output sx={{ width: "100%", flex: 1, flexGrow: 1 }} />
    </Stack>
  );
};
