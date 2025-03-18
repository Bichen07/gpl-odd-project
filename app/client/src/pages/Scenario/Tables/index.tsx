import { Box, Stack, Typography } from "@mui/material";
import Observations from "./Observations";

export default () => {
  return (
    <Stack sx={{ mt: 5 }} spacing={2}>
      <Typography variant="h4">Tables</Typography>
      <Box>
        <Typography variant="subtitle1" sx={{ mb: 1 }}>
          Trials
        </Typography>
        <Observations />
      </Box>
      <Box>
        <Typography variant="subtitle1" sx={{ mb: 1 }}>
          Observations
        </Typography>
        <Observations />
      </Box>
    </Stack>
  );
};
