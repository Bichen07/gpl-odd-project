import { Box, CircularProgress, Stack, Typography } from "@mui/material";

export default () => {
  return (
    <Box
      sx={{
        height: "100vh",
        width: "100vw",
        backgroundColor: "background.default",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <Stack justifyContent="center" alignItems="center" spacing={2}>
        <CircularProgress />
        <Typography color="primary.main" fontWeight={700}>
          Loading...
        </Typography>
      </Stack>
    </Box>
  );
};
