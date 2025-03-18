import {
  Box,
  CircularProgress,
  IconButton,
  Slider,
  Stack,
  Typography,
} from "@mui/material";
import { Canvas } from "@react-three/fiber";
import { Vector3 } from "three";
import { CanvasContent } from "./CanvasContent";
import { useEffect, useRef, useState } from "react";
import { PlayArrow, Stop } from "@mui/icons-material";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import { sessionSlice } from "src/redux/slices/session";

export type ReplayerInterfaceElements = {
  timeTypography: HTMLElement | null;
  timeSlider: HTMLElement | null;
};

export default function Replayer() {
  const dispatch = useAppDispatch();
  const timeTypographyRef = useRef<HTMLDivElement>(null);
  const timeSliderRef = useRef<HTMLDivElement>(null);

  const selectedTrialIds = useAppSelector(
    (state) => state.session.selectedTrialIds,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );
  const replayerDuration = useAppSelector(
    (state) => state.session.replayerDuration,
  );

  const [loading, setLoading] = useState(false);
  const [paused, setPaused] = useState(false);
  const [replayerInterfaceElements, setReplayerInterfaceElements] =
    useState<ReplayerInterfaceElements>({
      timeTypography: null,
      timeSlider: null,
    });
  const [timeTypographyElement, setTimeTypographyElement] =
    useState<HTMLDivElement | null>(null);

  useEffect(() => {
    if (timeTypographyRef.current && timeSliderRef) {
      setTimeTypographyElement(timeTypographyRef.current);
      setReplayerInterfaceElements({
        timeTypography: timeTypographyRef.current,
        timeSlider: timeSliderRef.current,
      });
    }
  }, [timeTypographyRef.current, timeSliderRef.current]);

  useEffect(() => {
    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.code === "Space") {
        setPaused((prev) => !prev);
      }
    };
    window.addEventListener("keydown", handleKeyPress);
    return () => {
      window.removeEventListener("keydown", handleKeyPress);
    };
  }, []);

  return (
    <Box
      component="div"
      sx={{
        width: "100%",
        height: "100%",
        position: "relative",
        overflowX: "hidden",
      }}
    >
      <Stack
        sx={{ position: "absolute", bottom: 0, zIndex: 100, width: "100%" }}
      >
        <Slider
          ref={timeSliderRef}
          size="small"
          defaultValue={0}
          sx={{ width: "99%", p: 0 }}
          step={0.001}
          max={99.999}
          onChange={(event: any, value) => {
            const message = event.detail?.message;
            if (message !== "auto-updated" && trajectoryAnalysis != null) {
              let maxDuration = 0;
              for (const trialId of selectedTrialIds) {
                const trajectory = trajectoryAnalysis.trajectories[trialId];
                const duration = trajectory[trajectory.length - 1]["time"];
                maxDuration = Math.max(maxDuration, duration);
              }
              dispatch(
                sessionSlice.actions.setClipTimeManualOverride(
                  ((value as number) / 100) * maxDuration,
                ),
              );
            } else if (message !== "auto-updated") {
              let maxDuration = replayerDuration;
              // console.log(maxDuration);
              dispatch(
                sessionSlice.actions.setClipTimeManualOverride(
                  ((value as number) / 100) * maxDuration,
                ),
              );
            }
          }}
        />
        <Stack direction="row" alignItems="center">
          <IconButton
            size="small"
            onClick={() => (!loading ? setPaused((prev) => !prev) : null)}
          >
            {paused ? <PlayArrow /> : <Stop />}
          </IconButton>
          <Typography
            fontWeight="bold"
            ref={timeTypographyRef}
            id="rep-clip-time-typography"
            sx={{ pl: 0.5 }}
          >
            0
          </Typography>
        </Stack>
      </Stack>
      <Box
        component="div"
        sx={{
          position: "relative",
          width: "100%",
          height: "100%",
        }}
      >
        <Canvas
          camera={{
            up: [0, 0, 1],
            position: new Vector3(0, 0, 25),
          }}
          style={{
            filter: loading ? "blur(2px)" : "none",
          }}
        >
          <CanvasContent
            loading={loading}
            setLoading={setLoading}
            paused={paused}
            timeTypographyElement={timeTypographyElement}
            replayerInterfaceElements={replayerInterfaceElements}
          />
        </Canvas>
      </Box>
      {loading ? (
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
          }}
        >
          <CircularProgress />
          <Typography color="primary.main" fontWeight={700}>
            Loading...
          </Typography>
        </Stack>
      ) : null}
    </Box>
  );
}
