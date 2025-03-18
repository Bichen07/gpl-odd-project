import "react-toastify/dist/ReactToastify.css";
import { Routes, Route } from "react-router-dom";
import { useMemo } from "react";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import { getDesignTokens } from "./theme";
import { ToastContainer, toast } from "react-toastify";
import CssBaseline from "@mui/material/CssBaseline";
import { useQuery } from "@tanstack/react-query";
import ClientService from "./axios/services/Client";
import LoadingOverlay from "./components/LoadingOverlay";
import { setOptions, setSelectedId } from "./redux/slices/client";
import { Client } from "payload/payload-types";
import Scenarios from "src/pages/Scenarios";
import Scenario from "src/pages/Scenario";

function App() {
  const dispatch = useAppDispatch();
  const mode = useAppSelector((state) => state.colorMode.mode);
  const theme = useMemo(() => createTheme(getDesignTokens(mode)), [mode]);

  const { isLoading, isError, data, error } = useQuery({
    queryKey: ["clients"],
    queryFn: () => ClientService.getClients().then((response) => response.data),
  });

  if (isError) {
    toast.error(error.message);
  }

  if (isLoading || isError) {
    return <LoadingOverlay />;
  }

  if (data) {
    const newOptions: { [id: string]: Client } = {};
    let newSelectedId = null;
    for (const doc of data.docs) {
      newOptions[doc.id] = doc;
      if (newSelectedId === null) {
        newSelectedId = doc.id;
      }
    }
    dispatch(setOptions(newOptions));
    dispatch(setSelectedId(newSelectedId));
  }

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <ToastContainer theme="colored" style={{ transition: "Bounce" }} />
      <Routes>
        <Route path="scenarios" element={<Scenarios />} />
        <Route path="scenarios/:id" element={<Scenario />} />
      </Routes>
    </ThemeProvider>
  );
}

export default App;
