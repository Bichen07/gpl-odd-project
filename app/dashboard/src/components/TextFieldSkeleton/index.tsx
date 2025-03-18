import { Box, Skeleton, SxProps } from "@mui/material";

type Props = {
  sx?: SxProps;
};
export default ({ sx }: Props) => (
  <Box sx={sx}>
    <Skeleton animation="wave" width="60%" height="20px" />
    <Skeleton
      variant="rectangular"
      animation="wave"
      width={100}
      height={40}
      sx={{ mt: "5px" }}
    />
  </Box>
);
