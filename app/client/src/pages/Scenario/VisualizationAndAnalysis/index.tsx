import { Box, Stack, Typography } from "@mui/material";
import Settings from "./Settings";
import Visualization from "./Visualization";

export default () => {
  return (
    <Stack sx={{ mt: 5 }} spacing={2}>
      <Typography variant="h4">Visualization & Analysis</Typography>
      <Box>
        <Typography variant="subtitle1" sx={{ mb: 1 }}>
          Settings
        </Typography>
        <Settings />
      </Box>
      <Box>
        <Typography variant="subtitle1" sx={{ mb: 1 }}>
          Visualization
        </Typography>
        <Visualization />
      </Box>
    </Stack>
  );
};
