import { CircularProgress, Stack, Typography } from "@mui/material";

export function Loader() {
  return (
    <Stack
      justifyContent="center"
      alignItems="center"
      spacing={2}
      sx={{
        position: "absolute",
        zIndex: 100,
        top: 0,
        left: 0,
        width: "100%",
        height: "100%",
        // backgroundColor: "divider",
      }}
    >
      <CircularProgress />
      <Typography color="primary.main" fontWeight={700}>
        Loading...
      </Typography>
    </Stack>
  );
}
