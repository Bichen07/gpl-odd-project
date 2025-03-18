import { Container, Typography } from "@mui/material";
import Table from "./Table";

export default function Sessions() {
  return (
    <Container
      sx={{
        pt: 3,
        pb: 3,
        display: "flex",
        flexDirection: "column",
        minHeight: "100vh",
      }}
    >
      <Typography variant="h2">Sessions</Typography>
      <Table sx={{ mt: 3 }} />
    </Container>
  );
}
