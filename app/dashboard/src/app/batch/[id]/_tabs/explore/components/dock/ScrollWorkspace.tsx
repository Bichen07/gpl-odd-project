"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Box, Chip, IconButton, Menu, MenuItem, Paper, Stack, Typography } from "@mui/material";
import { DragIndicator, Fullscreen, FullscreenExit } from "@mui/icons-material";
import { useAppSelector } from "../../redux/hooks";
import Controls from "./panels/Controls";
import ParameterSpace from "./panels/ParameterSpace";
import ProjectionSpace from "./panels/ProjectionSpace";
import Replayer from "./panels/Replayer";
import Heatmap from "./panels/Heatmap";
import MissionControl from "./panels/MissionControl";
import ClusteringSelection from "./panels/ClusteringSelection";
import Saves from "./panels/Saves";
import AnalyzeClient from "../../../../analyze/AnalyzeClient";
import type { SavedTrajectoryAnalysis } from "@/app/_shared/graphql/queries/batches";

type PanelId =
  | "saves"
  | "clustering"
  | "filtering"
  | "parameterSpace"
  | "projection"
  | "replayer"
  | "heatmap"
  | "mission"
  | "analysis";

type Region = "row1" | "plots" | "replay" | "analysis";

type PanelBox = { w: number | null; h: number | null };

const PANELS: { id: PanelId; label: string; defaultOn: boolean }[] = [
  { id: "saves", label: "Saves", defaultOn: true },
  { id: "filtering", label: "Filtering", defaultOn: true },
  { id: "clustering", label: "Clustering", defaultOn: true },
  { id: "heatmap", label: "Heatmap", defaultOn: true },
  { id: "parameterSpace", label: "Parameter space", defaultOn: true },
  { id: "projection", label: "Trajectory projection", defaultOn: true },
  { id: "replayer", label: "Replayer", defaultOn: true },
  { id: "analysis", label: "Analysis", defaultOn: true },
  { id: "mission", label: "Mission control", defaultOn: false },
];

const REGIONS: { id: Region; label: string }[] = [
  { id: "row1", label: "Top row" },
  { id: "plots", label: "Plot column" },
  { id: "replay", label: "Replayer column" },
  { id: "analysis", label: "Analysis row" },
];

const DEFAULT_ORDER: Record<Region, PanelId[]> = {
  row1: ["saves", "filtering", "clustering", "heatmap"],
  plots: ["parameterSpace", "projection"],
  replay: ["replayer"],
  analysis: ["analysis", "mission"],
};

const STORAGE_KEY = "gpl-odd-scroll-layout-v3";

// Second row: parameter space + trajectory projection, and the replayer beside them.
const PLOT_ROW_HEIGHT = 720;
const PARAMETER_SPACE_HEIGHT = 360;
const PLOT_GAP = 12;
const ROW1_HEIGHT = 520;
const MIN_PANEL = 140;
const DEFAULT_PLOT_FRACTION = 1 / 4;
// Heatmap takes this many shares of the top row. The other top panels take 1 each.
const HEATMAP_GROW = 2;

function folderFromQuery(k: string, s: string): string | null {
  if (!k || !s) return null;
  return `${k}_cluster_s=${s}`;
}

function defaultVisible(): Record<PanelId, boolean> {
  const visible = {} as Record<PanelId, boolean>;
  for (const panel of PANELS) visible[panel.id] = panel.defaultOn;
  return visible;
}

function defaultBoxes(): Record<PanelId, PanelBox> {
  const boxes = {} as Record<PanelId, PanelBox>;
  for (const panel of PANELS) boxes[panel.id] = { w: null, h: ROW1_HEIGHT };
  boxes.parameterSpace = { w: null, h: PARAMETER_SPACE_HEIGHT };
  boxes.projection = { w: null, h: PLOT_ROW_HEIGHT - PARAMETER_SPACE_HEIGHT - PLOT_GAP };
  boxes.replayer = { w: null, h: PLOT_ROW_HEIGHT };
  boxes.analysis = { w: null, h: null };
  return boxes;
}

function panelsIn(order: Record<Region, PanelId[]>): Set<PanelId> {
  return new Set(Object.values(order).flat());
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

type TunedSizes = {
  param: boolean;
  row: boolean;
  row1: boolean;
  fraction: boolean;
  height: Partial<Record<PanelId, boolean>>;
};

function emptyTuned(): TunedSizes {
  return { param: false, row: false, row1: false, fraction: false, height: {} };
}

const MIN_WIDTH = 100;

export default function ScrollWorkspace({
  batchId,
  saves,
  ego,
  k,
  s,
  section,
}: {
  batchId: string;
  saves: SavedTrajectoryAnalysis;
  ego: string;
  k: string;
  s: string;
  section?: string;
}) {
  const savedFolder = useAppSelector(
    (state) => state.batch.clusterAnalysisByEgo?.[ego]?.folder ?? null,
  );
  const folder = folderFromQuery(k, s) ?? savedFolder;
  const parsed = useMemo(() => {
    const match = folder?.match(/^(\d+)_cluster_s=(.+)$/);
    if (!match) return null;
    return { k: match[1], s: match[2] };
  }, [folder]);

  const [visible, setVisible] = useState(defaultVisible);
  const [order, setOrder] = useState(DEFAULT_ORDER);
  const [mounted, setMounted] = useState<Record<PanelId, boolean>>(defaultVisible);
  const [boxes, setBoxes] = useState(defaultBoxes);
  const [tuned, setTuned] = useState(emptyTuned);
  const [dragParam, setDragParam] = useState(PARAMETER_SPACE_HEIGHT);
  const [dragRow, setDragRow] = useState(PLOT_ROW_HEIGHT);
  const [dragRow1, setDragRow1] = useState(ROW1_HEIGHT);
  const [dragFraction, setDragFraction] = useState(DEFAULT_PLOT_FRACTION);
  const [row1Widths, setRow1Widths] = useState<Partial<Record<PanelId, number>>>({});
  const paramHeight = tuned.param ? dragParam : PARAMETER_SPACE_HEIGHT;
  const rowHeight = tuned.row ? dragRow : PLOT_ROW_HEIGHT;
  const row1Height = tuned.row1 ? dragRow1 : ROW1_HEIGHT;
  const plotFraction = tuned.fraction ? dragFraction : DEFAULT_PLOT_FRACTION;
  const [layoutReady, setLayoutReady] = useState(false);
  const [menuPanel, setMenuPanel] = useState<PanelId | null>(null);
  const [menuAnchor, setMenuAnchor] = useState<HTMLElement | null>(null);
  const midRef = useRef<HTMLDivElement>(null);
  const widthSession = useRef<{
    id: PanelId;
    starts: Partial<Record<PanelId, number>>;
    neighbor?: PanelId;
  } | null>(null);

  useEffect(() => {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) {
        setLayoutReady(true);
        return;
      }
      const saved = JSON.parse(raw) as {
        visible?: Record<PanelId, boolean>;
        order?: Record<Region, PanelId[]>;
        boxes?: Partial<Record<PanelId, PanelBox>>;
        paramHeight?: number;
        rowHeight?: number;
        row1Height?: number;
        plotFraction?: number;
        row1Widths?: Partial<Record<PanelId, number>>;
        tuned?: TunedSizes;
      };
      if (saved.visible) setVisible({ ...defaultVisible(), ...saved.visible });
      if (saved.order) {
        const next = {
          ...DEFAULT_ORDER,
          ...saved.order,
          row1: [...DEFAULT_ORDER.row1],
        };
        const known = panelsIn(next);
        for (const panel of PANELS) {
          if (!known.has(panel.id)) next.analysis = [...next.analysis, panel.id];
        }
        setOrder(next);
        setMounted((prev) => {
          const shown = { ...prev };
          for (const panel of PANELS) {
            if (saved.visible?.[panel.id]) shown[panel.id] = true;
          }
          return shown;
        });
      }
      // Width and height always start from the constants above. A reload does not
      // keep sizes from the last drag.
    } catch {
      /* keep the default rows */
    }
    setLayoutReady(true);
  }, []);

  useEffect(() => {
    if (!layoutReady) return;
    localStorage.setItem(
      STORAGE_KEY,
      JSON.stringify({
        visible,
        order,
        boxes,
        paramHeight,
        rowHeight,
        row1Height,
        plotFraction,
        row1Widths,
        tuned,
      }),
    );
  }, [layoutReady, visible, order, boxes, paramHeight, rowHeight, row1Height, plotFraction, row1Widths, tuned]);

  useEffect(() => {
    if (!section) return;
    document.getElementById("section-analysis")?.scrollIntoView({ behavior: "smooth", block: "start" });
  }, [section, folder]);

  const toggle = (id: PanelId) => {
    setVisible((prev) => ({ ...prev, [id]: !prev[id] }));
    setMounted((prev) => ({ ...prev, [id]: true }));
  };

  const movePanel = (id: PanelId, region: Region, before?: PanelId) => {
    setOrder((prev) => {
      const next: Record<Region, PanelId[]> = {
        row1: prev.row1.filter((item) => item !== id),
        plots: prev.plots.filter((item) => item !== id),
        replay: prev.replay.filter((item) => item !== id),
        analysis: prev.analysis.filter((item) => item !== id),
      };
      const list = next[region];
      const index = before ? list.indexOf(before) : -1;
      if (index >= 0) list.splice(index, 0, id);
      else list.push(id);
      return next;
    });
    setVisible((prev) => ({ ...prev, [id]: true }));
    setMounted((prev) => ({ ...prev, [id]: true }));
  };

  const onDropRegion = (region: Region) => (event: React.DragEvent) => {
    event.preventDefault();
    const id = event.dataTransfer.getData("text/panel-id") as PanelId;
    if (id) movePanel(id, region);
  };

  const resizeColumn = (id: PanelId, dx: number, startWidth: number) => {
    const total = midRef.current?.clientWidth ?? 0;
    const available = Math.max(1, total - PLOT_GAP);
    if (id === "replayer") {
      const nextReplay = clamp(startWidth + dx, 220, available - 180);
      setTuned((prev) => ({ ...prev, fraction: true }));
      setDragFraction((available - nextReplay) / available);
      return;
    }
    const nextPlot = clamp(startWidth + dx, 180, available - 220);
    setTuned((prev) => ({ ...prev, fraction: true }));
    setDragFraction(nextPlot / available);
  };

  const onResizeWidth = (id: PanelId, region: Region | undefined, dx: number, startWidth: number) => {
    if (region === "plots" || (region === "replay" && id === "replayer")) {
      resizeColumn(id, dx, startWidth);
      return;
    }
    if (region === "row1") {
      if (!widthSession.current || widthSession.current.id !== id) {
        const ids = order.row1.filter((pid) => visible[pid]);
        const index = ids.indexOf(id);
        const starts: Partial<Record<PanelId, number>> = {};
        for (const pid of ids) {
          starts[pid] = document.getElementById(`section-${pid}`)?.getBoundingClientRect().width ?? MIN_WIDTH;
        }
        widthSession.current = { id, starts, neighbor: ids[index + 1] };
      }
      const { starts, neighbor } = widthSession.current;
      const startW = starts[id] ?? startWidth;
      let nextW = Math.max(MIN_WIDTH, startWidth + dx);
      let delta = nextW - startW;
      let neighborW = neighbor ? (starts[neighbor] ?? MIN_WIDTH) : undefined;
      if (neighbor && neighborW != null && neighborW - delta < MIN_WIDTH) {
        delta = neighborW - MIN_WIDTH;
        nextW = startW + delta;
        neighborW = MIN_WIDTH;
      } else if (neighbor && neighborW != null) {
        neighborW -= delta;
      }
      setRow1Widths((prev) => {
        const next = { ...prev };
        for (const pid of order.row1) {
          if (starts[pid] != null) next[pid] = starts[pid]!;
        }
        next[id] = nextW;
        if (neighbor && neighborW != null) next[neighbor] = neighborW;
        return next;
      });
      return;
    }
    setBoxes((prev) => ({ ...prev, [id]: { ...prev[id], w: Math.max(MIN_WIDTH, startWidth + dx) } }));
  };

  const endResize = () => {
    widthSession.current = null;
  };

  const onResizeHeight = (id: PanelId, region: Region | undefined, dy: number, startHeight: number) => {
    const next = Math.max(MIN_PANEL, startHeight + dy);
    if (region === "row1") {
      setTuned((prev) => ({ ...prev, row1: true }));
      setDragRow1(next);
      return;
    }
    if (region === "plots" && id === "parameterSpace") {
      const nextParam = Math.max(MIN_PANEL, next);
      const delta = nextParam - startHeight;
      setTuned((prev) => ({ ...prev, param: true, row: true }));
      setDragParam(nextParam);
      setDragRow(Math.max(nextParam + PLOT_GAP + MIN_PANEL, rowHeight + delta));
      return;
    }
    if (region === "plots" && id === "projection") {
      const delta = next - startHeight;
      const nextRow = Math.max(paramHeight + PLOT_GAP + MIN_PANEL, rowHeight + delta);
      const inner0 = Math.max(1, rowHeight - PLOT_GAP);
      const inner1 = nextRow - PLOT_GAP;
      setTuned((prev) => ({ ...prev, row: true, param: true }));
      setDragRow(nextRow);
      setDragParam(clamp((paramHeight / inner0) * inner1, MIN_PANEL, inner1 - MIN_PANEL));
      return;
    }
    if (region === "replay" && id === "replayer") {
      const nextRow = Math.max(paramHeight + PLOT_GAP + MIN_PANEL, next);
      const inner0 = Math.max(1, rowHeight - PLOT_GAP);
      const inner1 = nextRow - PLOT_GAP;
      setTuned((prev) => ({ ...prev, row: true, param: true }));
      setDragRow(nextRow);
      setDragParam(clamp((paramHeight / inner0) * inner1, MIN_PANEL, inner1 - MIN_PANEL));
      return;
    }
    setTuned((prev) => ({ ...prev, height: { ...prev.height, [id]: true } }));
    setBoxes((prev) => ({ ...prev, [id]: { ...prev[id], h: next } }));
  };

  const projectionHeight = Math.max(MIN_PANEL, rowHeight - paramHeight - PLOT_GAP);

  const renderPanel = (id: PanelId) => {
    if (!mounted[id]) return null;
    const region = (Object.keys(order) as Region[]).find((key) => order[key].includes(id));
    const linkedPlot = region === "plots" && (id === "parameterSpace" || id === "projection");
    const linkedReplay = region === "replay" && id === "replayer";
    const height = linkedReplay
      ? undefined
      : linkedPlot
        ? id === "parameterSpace"
          ? paramHeight
          : projectionHeight
        : region === "row1"
          ? row1Height
          : id === "analysis"
            ? undefined
            : tuned.height[id] && boxes[id].h != null
              ? boxes[id].h
              : ROW1_HEIGHT;
    const width = linkedPlot || linkedReplay ? null : boxes[id].w;
    const rowWeight =
      region === "row1" ? (row1Widths[id] ?? (id === "heatmap" ? HEATMAP_GROW : 1)) : 1;
    return (
      <PanelCard
        key={id}
        id={id}
        shown={visible[id]}
        width={region === "row1" ? null : width}
        height={height}
        fillWidth={linkedPlot || linkedReplay || (width == null && region !== "row1")}
        fillHeight={linkedReplay}
        fitContent={id === "analysis"}
        fitRow={region === "row1"}
        flexGrow={rowWeight}
        widthEdge={linkedReplay ? "left" : "right"}
        onDropBefore={(source) => {
          if (region) movePanel(source, region, id);
        }}
        onResizeWidth={(dx, startWidth) => onResizeWidth(id, region, dx, startWidth)}
        onResizeHeight={(dy, startHeight) => onResizeHeight(id, region, dy, startHeight)}
        onResizeEnd={endResize}
      >
        {id === "saves" && <Saves batchId={batchId} saves={saves} />}
        {id === "clustering" && <ClusteringSelection />}
        {id === "filtering" && <Controls />}
        {id === "parameterSpace" && <ParameterSpace />}
        {id === "projection" && <ProjectionSpace />}
        {id === "replayer" && <Replayer />}
        {id === "heatmap" && <Heatmap />}
        {id === "mission" && <MissionControl batchId={batchId} />}
        {id === "analysis" && (
          <Box id="section-analysis">
            {parsed ? (
              <AnalyzeClient
                batchId={batchId}
                ego={ego}
                k={parsed.k}
                s={parsed.s}
                presentation="tabs"
                section={section}
              />
            ) : (
              <Typography color="text.secondary">
                Select a clustering to show the medoid, pairs, and report.
              </Typography>
            )}
          </Box>
        )}
      </PanelCard>
    );
  };

  return (
    <Box sx={{ height: "100%", overflowX: "hidden", overflowY: "auto" }}>
      <Stack
        direction="row"
        spacing={0.5}
        alignItems="center"
        flexWrap="wrap"
        useFlexGap
        sx={{
          position: "sticky",
          top: 0,
          zIndex: 5,
          px: 1.5,
          py: 1,
          bgcolor: "background.paper",
          borderBottom: "1px solid",
          borderColor: "divider",
        }}
      >
        <Typography variant="body2" sx={{ mr: 1 }}>
          Panels
        </Typography>
        {PANELS.map((panel) => (
          <Chip
            key={panel.id}
            size="small"
            draggable
            icon={<DragIndicator />}
            label={panel.label}
            color={visible[panel.id] ? "primary" : "default"}
            variant={visible[panel.id] ? "filled" : "outlined"}
            onClick={(event) => {
              setMenuPanel(panel.id);
              setMenuAnchor(event.currentTarget);
            }}
            onDragStart={(event) => {
              event.dataTransfer.setData("text/panel-id", panel.id);
              event.dataTransfer.effectAllowed = "move";
            }}
          />
        ))}
      </Stack>
      <Menu
        anchorEl={menuAnchor}
        open={Boolean(menuAnchor && menuPanel)}
        onClose={() => setMenuAnchor(null)}
      >
        <MenuItem
          onClick={() => {
            if (menuPanel) toggle(menuPanel);
            setMenuAnchor(null);
          }}
        >
          {menuPanel && visible[menuPanel] ? "Hide" : "Show"}
        </MenuItem>
        {REGIONS.map((region) => (
          <MenuItem
            key={region.id}
            onClick={() => {
              if (menuPanel) movePanel(menuPanel, region.id);
              setMenuAnchor(null);
            }}
          >
            Move to {region.label}
          </MenuItem>
        ))}
      </Menu>

      <Box sx={{ p: 1.5 }}>
        <RegionRow label="Top" direction="row" onDrop={onDropRegion("row1")}>
          {order.row1.map(renderPanel)}
        </RegionRow>
        <Box
          ref={midRef}
          sx={{
            display: "flex",
            gap: `${PLOT_GAP}px`,
            mb: 1.5,
            height: rowHeight,
            alignItems: "stretch",
          }}
        >
          <Box
            onDragOver={(event) => event.preventDefault()}
            onDrop={onDropRegion("plots")}
            sx={{
              flex: `${plotFraction} 1 0`,
              minWidth: 0,
              height: "100%",
              display: "flex",
              flexDirection: "column",
              gap: `${PLOT_GAP}px`,
            }}
          >
            {order.plots.map(renderPanel)}
          </Box>
          <Box
            onDragOver={(event) => event.preventDefault()}
            onDrop={onDropRegion("replay")}
            sx={{
              flex: `${1 - plotFraction} 1 0`,
              minWidth: 0,
              height: "100%",
              display: "flex",
              flexDirection: "column",
            }}
          >
            {order.replay.map(renderPanel)}
          </Box>
        </Box>
        <RegionRow label="Analysis" direction="column" onDrop={onDropRegion("analysis")}>
          {order.analysis.map(renderPanel)}
        </RegionRow>
      </Box>
    </Box>
  );
}

function RegionRow({
  label,
  direction,
  onDrop,
  children,
}: {
  label: string;
  direction: "row" | "column";
  onDrop: (event: React.DragEvent) => void;
  children: React.ReactNode;
}) {
  return (
    <Box
      onDragOver={(event) => event.preventDefault()}
      onDrop={onDrop}
      sx={{
        display: "flex",
        flexDirection: direction,
        alignItems: direction === "row" ? "flex-start" : "stretch",
        gap: 1.5,
        mb: 1.5,
        p: 0.5,
        width: "100%",
        maxWidth: "100%",
        minWidth: 0,
        borderRadius: 1,
        outline: "1px dashed",
        outlineColor: "divider",
        "& > *": direction === "row" ? { minWidth: 0, maxWidth: "100%" } : { minWidth: 0, maxWidth: "100%" },
      }}
    >
      <Typography
        variant="caption"
        color="text.secondary"
        sx={{ position: "absolute", opacity: 0, pointerEvents: "none" }}
      >
        {label}
      </Typography>
      {children}
    </Box>
  );
}

function PanelCard({
  id,
  shown,
  width,
  height,
  fillWidth,
  fillHeight,
  fitContent,
  fitRow,
  flexGrow,
  widthEdge,
  onDropBefore,
  onResizeWidth,
  onResizeHeight,
  onResizeEnd,
  children,
}: {
  id: PanelId;
  shown: boolean;
  width: number | null;
  height?: number;
  fillWidth: boolean;
  fillHeight: boolean;
  fitContent: boolean;
  fitRow: boolean;
  flexGrow: number;
  widthEdge: "left" | "right";
  onDropBefore: (id: PanelId) => void;
  onResizeWidth: (dx: number, startWidth: number) => void;
  onResizeHeight: (dy: number, startHeight: number) => void;
  onResizeEnd: () => void;
  children: React.ReactNode;
}) {
  const label = PANELS.find((panel) => panel.id === id)?.label ?? id;
  const rootRef = useRef<HTMLDivElement>(null);
  const [fullScreen, setFullScreen] = useState(false);
  useEffect(() => {
    if (id !== "replayer") return;
    const onChange = () => setFullScreen(document.fullscreenElement === rootRef.current);
    document.addEventListener("fullscreenchange", onChange);
    return () => document.removeEventListener("fullscreenchange", onChange);
  }, [id]);
  const toggleFullScreen = () => {
    const el = rootRef.current;
    if (!el) return;
    if (document.fullscreenElement === el) {
      void document.exitFullscreen();
      return;
    }
    void el.requestFullscreen();
  };
  const startResize = (event: React.PointerEvent, axis: "x" | "y" | "xy") => {
    event.preventDefault();
    event.stopPropagation();
    const rect = (event.currentTarget as HTMLElement).parentElement!.getBoundingClientRect();
    const startX = event.clientX;
    const startY = event.clientY;
    const startW = rect.width;
    const startH = rect.height;
    const move = (e: PointerEvent) => {
      const dx = e.clientX - startX;
      const dy = e.clientY - startY;
      if (axis !== "y") onResizeWidth(widthEdge === "left" ? -dx : dx, startW);
      if (axis !== "x") onResizeHeight(dy, startH);
    };
    const up = () => {
      window.removeEventListener("pointermove", move);
      window.removeEventListener("pointerup", up);
      document.body.style.cursor = "";
      document.body.style.userSelect = "";
      onResizeEnd();
    };
    document.body.style.userSelect = "none";
    document.body.style.cursor = axis === "x" ? "ew-resize" : axis === "y" ? "ns-resize" : "nwse-resize";
    window.addEventListener("pointermove", move);
    window.addEventListener("pointerup", up);
  };

  return (
    <Paper
      ref={rootRef}
      id={`section-${id}`}
      variant="outlined"
      onDragOver={(event) => event.preventDefault()}
      onDrop={(event) => {
        event.preventDefault();
        event.stopPropagation();
        const source = event.dataTransfer.getData("text/panel-id") as PanelId;
        if (source && source !== id) onDropBefore(source);
      }}
      sx={{
        position: "relative",
        display: shown ? "flex" : "none",
        flexDirection: "column",
        width: fitRow || fillWidth ? undefined : width ?? undefined,
        flex: fitRow
          ? `${Math.max(flexGrow, 1)} 1 0px`
          : fillHeight
            ? "1 1 auto"
            : fillWidth
              ? "1 1 auto"
              : width
                ? `0 0 ${Math.max(MIN_WIDTH, width)}px`
                : `${flexGrow} 1 0px`,
        height: fitContent ? "auto" : fillHeight ? "100%" : height,
        minWidth: 0,
        maxWidth: "100%",
        minHeight: fitContent ? undefined : 0,
        overflow: fitContent ? "visible" : "hidden",
        "&:fullscreen": {
          width: "100%",
          height: "100%",
          bgcolor: "background.paper",
        },
      }}
    >
      <Stack
        direction="row"
        alignItems="center"
        spacing={0.5}
        draggable
        onDragStart={(event) => {
          event.dataTransfer.setData("text/panel-id", id);
          event.dataTransfer.effectAllowed = "move";
        }}
        sx={{ px: 1, py: 0.5, cursor: "grab" }}
      >
        <DragIndicator fontSize="small" color="disabled" />
        <Typography variant="subtitle2" sx={{ flex: 1 }}>
          {label}
        </Typography>
        {id === "replayer" && (
          <IconButton
            size="small"
            aria-label={fullScreen ? "Exit full screen" : "Full screen"}
            draggable={false}
            onPointerDown={(event) => event.stopPropagation()}
            onClick={(event) => {
              event.stopPropagation();
              toggleFullScreen();
            }}
          >
            {fullScreen ? <FullscreenExit fontSize="small" /> : <Fullscreen fontSize="small" />}
          </IconButton>
        )}
      </Stack>
      <Box
        sx={{
          flex: fitContent ? "0 0 auto" : 1,
          minHeight: fitContent ? undefined : 0,
          overflow: fitContent ? "visible" : "auto",
          px: 1,
          pb: 1,
        }}
      >
        {children}
      </Box>
      {widthEdge === "left" ? (
        <Box
          component="button"
          type="button"
          aria-label={`Resize ${label} width`}
          onPointerDown={(event) => startResize(event, "x")}
          sx={edgeSx("left")}
        />
      ) : (
        <Box
          component="button"
          type="button"
          aria-label={`Resize ${label} width`}
          onPointerDown={(event) => startResize(event, "x")}
          sx={edgeSx("right")}
        />
      )}
      {!fitContent && (
      <Box
        component="button"
        type="button"
        aria-label={`Resize ${label} height`}
        onPointerDown={(event) => startResize(event, "y")}
        sx={edgeSx("bottom")}
      />
      )}
      {widthEdge === "right" && !fitContent && (
        <Box
          component="button"
          type="button"
          aria-label={`Resize ${label}`}
          onPointerDown={(event) => startResize(event, "xy")}
          sx={edgeSx("corner")}
        />
      )}
    </Paper>
  );
}

function edgeSx(edge: "left" | "right" | "bottom" | "corner") {
  const base = {
    position: "absolute" as const,
    zIndex: 2,
    touchAction: "none" as const,
    border: 0,
    padding: 0,
    bgcolor: "transparent",
    "&:hover": { bgcolor: "primary.main", opacity: 0.35 },
  };
  if (edge === "left") {
    return { ...base, left: 0, top: 0, bottom: 0, width: 8, cursor: "ew-resize" };
  }
  if (edge === "right") {
    return { ...base, right: 0, top: 0, bottom: 8, width: 8, cursor: "ew-resize" };
  }
  if (edge === "bottom") {
    return { ...base, left: 0, right: 8, bottom: 0, height: 8, cursor: "ns-resize" };
  }
  return { ...base, right: 0, bottom: 0, width: 14, height: 14, cursor: "nwse-resize", zIndex: 3 };
}
