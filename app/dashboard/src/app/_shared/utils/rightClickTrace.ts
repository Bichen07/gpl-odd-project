/**
 * Shared right-click handler for Parameter / Projection scatterplots.
 * Sets the Replayer camera-follow trial; selects the point if it was not
 * already selected. Ignores background clicks and right-drag.
 */

export type TraceSelectDispatch = {
  setReplayerTraceTrialId: (trialId: string) => void;
  selectTrialIfNeeded: (trialId: string) => void;
};

export function createRightClickTraceHandlers(args: {
  canvas: HTMLCanvasElement | null;
  findNearestTrialId: (clientX: number, clientY: number) => string | null;
  isTrialSelected: (trialId: string) => boolean;
  onTrace: (trialId: string) => void;
  onSelectUnselected: (trialId: string) => void;
  /** Movement threshold in px² before a gesture is treated as a drag. */
  clickDistSq?: number;
}) {
  const clickDistSq = args.clickDistSq ?? 25;
  let rightDown: { x: number; y: number } | null = null;

  const onMouseDown = (event: MouseEvent) => {
    if (event.button !== 2) return;
    // Prevent browser context menu / default drag behaviour on the canvas.
    event.preventDefault();
    rightDown = { x: event.clientX, y: event.clientY };
  };

  const onContextMenu = (event: MouseEvent) => {
    event.preventDefault();
  };

  const onMouseUp = (event: MouseEvent) => {
    if (event.button !== 2) return;
    const start = rightDown;
    rightDown = null;
    if (start == null) return;
    const dx = event.clientX - start.x;
    const dy = event.clientY - start.y;
    if (dx * dx + dy * dy >= clickDistSq) {
      // Right-drag: do nothing.
      return;
    }
    const trialId = args.findNearestTrialId(event.clientX, event.clientY);
    if (trialId == null) {
      // Background: do nothing.
      return;
    }
    // Set camera-follow first so a subsequent select won't clear it
    // (selection will include this trialId).
    args.onTrace(trialId);
    if (!args.isTrialSelected(trialId)) {
      args.onSelectUnselected(trialId);
    }
  };

  const canvas = args.canvas;
  canvas?.addEventListener("mousedown", onMouseDown, { passive: false });
  canvas?.addEventListener("contextmenu", onContextMenu);
  window.addEventListener("mouseup", onMouseUp, { passive: true });

  return () => {
    canvas?.removeEventListener("mousedown", onMouseDown);
    canvas?.removeEventListener("contextmenu", onContextMenu);
    window.removeEventListener("mouseup", onMouseUp);
  };
}
