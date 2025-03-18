import chroma from "chroma-js";
import { CameraControls, Svg } from "@react-three/drei";
import { useEffect, useMemo, useRef, useState } from "react";
import { Euler, Quaternion, Vector3 } from "three";
import _ from "lodash";
import {
  AnimationClip,
  VectorKeyframeTrack,
  QuaternionKeyframeTrack,
} from "three";
import { CarAnimation } from "./CarAnimation";
import { useAppDispatch, useAppSelector } from "src/redux/hooks";
import {
  getTrajectoryFromTrial,
  TrajectoryResponseData,
} from "src/api/services/Trials";
import MapSvg from "src/assets/map.svg";
import { toast } from "react-toastify";
import { ReplayerInterfaceElements } from "..";
import { sessionSlice } from "src/redux/slices/session";

type Props = {
  loading: boolean;
  paused: boolean;
  setLoading: React.Dispatch<React.SetStateAction<boolean>>;
  timeTypographyElement: HTMLDivElement | null;
  replayerInterfaceElements: ReplayerInterfaceElements;
};
export function CanvasContent({
  loading,
  setLoading,
  paused,
  timeTypographyElement,
  replayerInterfaceElements,
}: Props) {
  const dispatch = useAppDispatch();

  const controlRef = useRef<CameraControls>(null);
  const replayerTrajectoryQuery = useAppSelector(
    (state) => state.session.replayerTrajectoryQuery,
  );
  const selectedTrialIds = useAppSelector(
    (state) => state.session.selectedTrialIds,
  );
  const trajectoryAnalysis = useAppSelector(
    (state) => state.session.trajectoryAnalysisResponse,
  );

  const [trajectories, setTrajectories] = useState<
    | {
      [trialId: string]: TrajectoryResponseData;
    }
    | undefined
  >(undefined);
  const [clips, setClips] = useState<{ [actor: string]: AnimationClip }>({});
  const [actorSize, setActorSize] = useState<{
    [actor: string]: { width: number; length: number };
  }>({});
  const [actorColors, setActorColors] = useState<{
    [actor: string]: string;
  }>({});

  const firstTraj = useMemo(() => {
    if (trajectories == null || Object.keys(trajectories).length === 0) {
      return null;
    }
    return Object.values(trajectories)[0];
  }, [trajectories]);

  useEffect(() => {
    if (replayerTrajectoryQuery == null) {
      return;
    }
    const fetchData = async () => {
      setLoading(true);
      try {
        const updated: typeof trajectories = {};

        // const trajData = await getTrajectoryFromTrial(
        //   replayerTrajectoryQuery.trialId,
        //   replayerTrajectoryQuery,
        // ).then((response) => response.data);
        // updated[replayerTrajectoryQuery.trialId] = trajData;
        // console.log(updated);

        // const trajData = await getTrajectoryFromTrial(
        //   "67692bfaffce4b092acb26cf",
        //   replayerTrajectoryQuery,
        // ).then((response) => response.data);
        // updated["676914a7ffce4b092ac1d08a"] = trajData;
        // const trajPairData = await getTrajectoryFromTrial(
        //   "6769c5b6ffce4b092a13f9bc",
        //   replayerTrajectoryQuery,
        // ).then((response) => response.data);
        // updated["67691f22ffce4b092ac57106"] = trajPairData;

        const trajData = await getTrajectoryFromTrial(
          "67693d1cffce4b092ad2036a",
          replayerTrajectoryQuery,
        ).then((response) => response.data);
        updated["676914a7ffce4b092ac1d08a"] = trajData;
        const trajPairData = await getTrajectoryFromTrial(
          "676963a6ffce4b092ae1cded",
          replayerTrajectoryQuery,
        ).then((response) => response.data);
        updated["67691f22ffce4b092ac57106"] = trajPairData;

        console.log(updated);

        setTrajectories(updated);
        dispatch(sessionSlice.actions.setClipTimeManualOverride(0));
        dispatch(
          sessionSlice.actions.setReplayerDuration(
            trajData.time[trajData.time.length - 1],
          ),
        );
      } catch (error) {
        toast.error("Failed to fetch trajectory data.");
        setLoading(false);
      }
    };
    fetchData();
  }, [replayerTrajectoryQuery]);

  useEffect(() => {
    if (!trajectoryAnalysis || !selectedTrialIds) {
      return;
    }
    const fetchData = async () => {
      setLoading(true);
      try {
        const updated: typeof trajectories = {};
        const query = {
          duration: -1,
          index: 0,
          framePeriod: 0.1,
          standardized: true,
        };
        for (const trialId of selectedTrialIds) {
          const trajData = await getTrajectoryFromTrial(trialId, query).then(
            (response) => response.data,
          );
          updated[trialId] = trajData;
        }
        setTrajectories(updated);
        dispatch(sessionSlice.actions.setClipTimeManualOverride(0));
        setLoading(false);
      } catch (error) {
        toast.error("Failed to fetch trajectory data.");
        setLoading(false);
      }
    };
    fetchData();
  }, [selectedTrialIds, trajectoryAnalysis]);

  useEffect(() => {
    if (
      trajectories == null ||
      !loading ||
      Object.keys(trajectories).length < 1
    ) {
      return;
    }

    if (controlRef.current && firstTraj != null) {
      controlRef.current.rotateAzimuthTo(firstTraj.anchor.h - 3.14 / 2);
      controlRef.current.rotatePolarTo(-3.14);
    }

    const newActorSize: typeof actorSize = {};
    for (const [agentName, agentTraj] of Object.entries(
      firstTraj?.trajectory ?? {},
    ) ?? []) {
      if (agentName === "Ego") {
        newActorSize["Ego"] = { width: 2.2, length: 5.17 };
      } else {
        newActorSize[agentName ?? ""] = {
          width: agentTraj[0].width ?? 0,
          length: agentTraj[0].length ?? 0,
        };
      }
    }
    setActorSize(newActorSize);

    const result: { [name: string]: string } = { Ego: "blue" };
    for (const [index, agentName] of (
      Object.keys(firstTraj?.trajectory ?? {}).filter(
        (name) => name !== "Ego",
      ) ?? []
    ).entries()) {
      result[agentName] = chroma("red").css();
    }
    setActorColors(result);

    const newClips: { [actor: string]: AnimationClip } = {};
    for (const [trialId, trajectoryItem] of Object.entries(trajectories)) {
      for (const [actorName, actorTraj] of Object.entries(
        trajectoryItem.trajectory,
      )) {
        const positions: number[] = [];
        const quaternions: number[] = [];
        let times: number[] = [];

        for (let i = 0; i < trajectoryItem.time.length; i++) {
          if (
            actorTraj[i].globalX === null ||
            actorTraj[i].globalY === null ||
            actorTraj[i].x === null ||
            actorTraj[i].y === null ||
            actorTraj[i].yaw === null
          ) {
            continue;
          }
          times.push(trajectoryItem.time[i]);

          if (trialId !== Object.keys(trajectories)[0]) {
            const mainTraj = Object.values(trajectories)[0];
            const newPosition = new Vector3(
              actorTraj[i].globalX - mainTraj.anchor.x,
              actorTraj[i].globalY - mainTraj.anchor.y,
              0.0,
            ).applyAxisAngle(new Vector3(0, 0, 1), -mainTraj.anchor.h);
            const newYaw =
              actorTraj[i].yaw + trajectoryItem.anchor.h - mainTraj.anchor.h;

            positions.push(newPosition.x);
            positions.push(newPosition.y);
            positions.push(0.01);

            const quaternion = new Quaternion().setFromEuler(
              new Euler(0.0, 0.0, newYaw),
            );
            quaternions.push(...quaternion.toArray());
          } else {
            positions.push(actorTraj[i].x);
            positions.push(actorTraj[i].y);
            positions.push(0.0);
            const quaternion = new Quaternion().setFromEuler(
              new Euler(0.0, 0.0, actorTraj[i].yaw),
            );
            quaternions.push(...quaternion.toArray());
          }
        }

        times = times.map((t) => t - times[0]);
        const positionKeyframeTrack = new VectorKeyframeTrack(
          ".position",
          times,
          positions,
        );
        const quaternionKeyframeTrack = new QuaternionKeyframeTrack(
          ".quaternion",
          times,
          quaternions,
        );
        const clipName = trialId + "-" + actorName;
        const moveClip = new AnimationClip(`${clipName}`, -1, [
          positionKeyframeTrack,
          quaternionKeyframeTrack,
        ]);
        newClips[clipName] = moveClip;
      }
    }
    setClips(newClips);
  }, [trajectories]);

  useEffect(() => {
    setLoading(false);
  }, [clips]);

  return (
    <>
      <Svg
        src={MapSvg}
        scale={new Vector3(1, -1, 1)}
        position={
          new Vector3(
            -(firstTraj ? firstTraj.anchor.x : 0),
            -(firstTraj ? firstTraj.anchor.y : 0),
            -1.0,
          )
        }
      />
      <ambientLight />
      <directionalLight />
      <CameraControls ref={controlRef} />
      <axesHelper />
      <group rotation={new Euler(0, 0, firstTraj ? firstTraj.anchor.h : 0)}>
        {Object.entries(clips).map(([clipName, actorClip], i) => {
          // if (trajectoryAnalysis == null) {
          //   return null;
          // }
          const splits = clipName.split("-");
          const trialId = splits[0];
          const actorName = splits[1];
          const color = chroma(actorColors[actorName])
            .brighten(1 + i * 0.3)
            .hex();

          // const trialTrajectory = trajectoryAnalysis.trajectories[trialId];
          // const duration = trialTrajectory[trialTrajectory.length - 1]["time"];

          return (
            <CarAnimation
              duration={actorClip.duration}
              paused={paused}
              key={clipName}
              clip={actorClip}
              size={actorSize[actorName]}
              color={color}
              timeTypographyElement={timeTypographyElement}
              replayerInterfaceElements={replayerInterfaceElements}
            />
          );
        })}
      </group>
    </>
  );
}
