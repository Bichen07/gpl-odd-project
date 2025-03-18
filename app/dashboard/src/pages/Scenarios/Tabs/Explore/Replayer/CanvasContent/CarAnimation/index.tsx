import { useFrame } from "@react-three/fiber";
import { useEffect, useMemo, useRef, useState } from "react";
import { AnimationClip, Mesh, AnimationMixer } from "three";
import _ from "lodash";
import { ReplayerInterfaceElements } from "../..";
import { useAppSelector } from "src/redux/hooks";

const timeSliderUpdateEvent = new CustomEvent("input", {
  bubbles: true,
  detail: {
    message: "auto-updated",
  },
});

type Props = {
  clip?: AnimationClip;
  color?: string;
  size?: { width: number; length: number };
  duration: number;
  paused: boolean;
  timeTypographyElement: HTMLDivElement | null;
  replayerInterfaceElements: ReplayerInterfaceElements;
};
export function CarAnimation({
  clip,
  size,
  color,
  duration,
  timeTypographyElement,
  paused,
  replayerInterfaceElements,
}: Props) {
  const meshRef = useRef<Mesh>(null);
  const clipTimeManualOverride = useAppSelector(
    (state) => state.session.clipTimeManualOverride,
  );
  const [manualSetupCompleted, setManualSetupCompleted] = useState(true);

  const mixer = useMemo(() => {
    if (!meshRef.current || !clip) {
      return undefined;
    }
    const mixer = new AnimationMixer(meshRef.current);
    mixer.clipAction(clip).play();
    return mixer;
  }, [meshRef.current, clip]);

  useEffect(() => {
    setManualSetupCompleted(false);
  }, [clipTimeManualOverride]);

  useFrame((_state, delta) => {
    if (!mixer) {
      return;
    }
    if (!paused) {
      mixer.update(delta);
    }
    if (mixer.time > duration) {
      mixer.setTime(0);
    }
    if (timeTypographyElement) {
      timeTypographyElement.innerText = mixer.time.toFixed(3);
    }
    if (replayerInterfaceElements.timeSlider) {
      const inputElement =
        replayerInterfaceElements.timeSlider.querySelector("input");
      if (inputElement) {
        inputElement.value = ((mixer.time / duration) * 100).toString();
        inputElement.dispatchEvent(timeSliderUpdateEvent);
      }
    }
    if (!manualSetupCompleted) {
      if (clipTimeManualOverride !== null) {
        mixer.setTime(clipTimeManualOverride);
      }
      setManualSetupCompleted(true);
    }
  });

  return (
    <mesh ref={meshRef}>
      <boxGeometry
        args={[size ? size.length : 0.0, size ? size.width : 0.0, 1.8]}
      />
      <meshToonMaterial color={color} transparent opacity={0.5} />
    </mesh>
  );
}
