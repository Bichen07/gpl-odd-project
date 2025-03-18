import "react-toastify/dist/ReactToastify.css";
import { Routes, Route } from "react-router-dom";
import { useMemo } from "react";
import { useAppSelector } from "src/redux/hooks";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import { getDesignTokens } from "./theme";
import { ToastContainer } from "react-toastify";
import CssBaseline from "@mui/material/CssBaseline";
import Scenarios from "src/pages/Scenarios";
import Scenario from "src/pages/Scenario";
import Sessions from "src/pages/Sessions";

function App() {
  const mode = useAppSelector((state) => state.ui.mode);
  const theme = useMemo(() => createTheme(getDesignTokens(mode)), [mode]);

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <ToastContainer theme="colored" style={{ transition: "Bounce" }} />
      <Routes>
        <Route path="" element={<Sessions />} />
        <Route
          path="/:sessionId/batch/:batchId/:tabName?"
          element={<Scenario />}
        />
        <Route path="/:sessionId/:tabName?" element={<Scenarios />} />
      </Routes>
    </ThemeProvider>
  );
}

export default App;
