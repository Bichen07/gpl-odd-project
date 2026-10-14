"use client";

import { useMemo, useState } from "react";
import { Box, Stack, ToggleButton, ToggleButtonGroup, Typography } from "@mui/material";

type Rule = {
  id: string;
  predicate: string;
  predicted: string;
};

type Point = { x: number; y: number; passed: boolean; cluster: number | null };

type ColorMode = "collision" | "cluster";

const CLUSTER_COLORS = ["#1565c0", "#6a1b9a", "#ef6c00", "#00838f", "#c2185b", "#f9a825", "#2e7d32", "#5d4037"];

function clusterColor(id: number | null): string {
  if (id == null) return "#bdbdbd";
  if (id < 0) return "#757575";
  return CLUSTER_COLORS[id % CLUSTER_COLORS.length];
}

function clusterName(id: number | null): string {
  if (id == null) return "outside clustering";
  if (id < 0) return "noise";
  return `C${id}`;
}

type Bounds = { lo: number | null; hi: number | null };

const WIDTH = 760;
const HEIGHT = 460;
const PAD_L = 64;
const PAD_R = 16;
const PAD_T = 16;
const PAD_B = 48;

function parsePredicate(predicate: string, xName: string, yName: string): { x: Bounds; y: Bounds } {
  const bounds: Record<string, Bounds> = {
    [xName]: { lo: null, hi: null },
    [yName]: { lo: null, hi: null },
  };
  for (const part of predicate.split(/\s+AND\s+/)) {
    const match = part.trim().match(/^(.+?)\s*(<=|>=|<|>)\s*(-?\d+(?:\.\d+)?)$/);
    if (!match) continue;
    const name = match[1].trim();
    const op = match[2];
    const value = Number(match[3]);
    const box = bounds[name];
    if (!box || !Number.isFinite(value)) continue;
    if (op === ">" || op === ">=") box.lo = box.lo == null ? value : Math.max(box.lo, value);
    else box.hi = box.hi == null ? value : Math.min(box.hi, value);
  }
  return { x: bounds[xName], y: bounds[yName] };
}

export default function RuleBoundaryPlot({
  xName,
  yName,
  points,
  rules,
}: {
  xName: string;
  yName: string;
  points: Point[];
  rules: Rule[];
}) {
  const [activeId, setActiveId] = useState<string | null>(
    rules.find((rule) => rule.predicted === "collision")?.id ?? rules[0]?.id ?? null,
  );
  const [colorMode, setColorMode] = useState<ColorMode>("collision");

  const legend = useMemo(() => {
    const seen = new Set<string>();
    const items: Array<{ id: number | null; label: string; color: string }> = [];
    const ids = [...new Set(points.map((point) => point.cluster))].sort((a, b) => {
      if (a == null) return 1;
      if (b == null) return -1;
      return a - b;
    });
    for (const id of ids) {
      const label = clusterName(id);
      if (seen.has(label)) continue;
      seen.add(label);
      items.push({ id, label, color: clusterColor(id) });
    }
    return items;
  }, [points]);

  const layout = useMemo(() => {
    const xs = points.map((point) => point.x);
    const ys = points.map((point) => point.y);
    for (const rule of rules) {
      const box = parsePredicate(rule.predicate, xName, yName);
      if (box.x.lo != null) xs.push(box.x.lo);
      if (box.x.hi != null) xs.push(box.x.hi);
      if (box.y.lo != null) ys.push(box.y.lo);
      if (box.y.hi != null) ys.push(box.y.hi);
    }
    const xMin0 = Math.min(...xs);
    const xMax0 = Math.max(...xs);
    const yMin0 = Math.min(...ys);
    const yMax0 = Math.max(...ys);
    const xPad = (xMax0 - xMin0) * 0.04 || 0.1;
    const yPad = (yMax0 - yMin0) * 0.04 || 0.1;
    const xMin = xMin0 - xPad;
    const xMax = xMax0 + xPad;
    const yMin = yMin0 - yPad;
    const yMax = yMax0 + yPad;
    const sx = (value: number) =>
      PAD_L + ((value - xMin) / (xMax - xMin)) * (WIDTH - PAD_L - PAD_R);
    const sy = (value: number) =>
      PAD_T + ((yMax - value) / (yMax - yMin)) * (HEIGHT - PAD_T - PAD_B);
    const regions = rules.map((rule) => {
      const box = parsePredicate(rule.predicate, xName, yName);
      const x0 = sx(box.x.lo ?? xMin);
      const x1 = sx(box.x.hi ?? xMax);
      const y0 = sy(box.y.hi ?? yMax);
      const y1 = sy(box.y.lo ?? yMin);
      return {
        ...rule,
        x: Math.min(x0, x1),
        y: Math.min(y0, y1),
        w: Math.abs(x1 - x0),
        h: Math.abs(y1 - y0),
      };
    });
    return { sx, sy, xMin, xMax, yMin, yMax, regions };
  }, [points, rules, xName, yName]);

  const active = layout.regions.find((region) => region.id === activeId) ?? layout.regions[0];
  const ticks = 4;
  const xTicks = Array.from({ length: ticks + 1 }, (_, i) => layout.xMin + ((layout.xMax - layout.xMin) * i) / ticks);
  const yTicks = Array.from({ length: ticks + 1 }, (_, i) => layout.yMin + ((layout.yMax - layout.yMin) * i) / ticks);

  const showCollision = colorMode === "collision";

  return (
    <Stack spacing={1} sx={{ mt: 1, mb: 2 }}>
      <Stack direction="row" spacing={1} alignItems="center" flexWrap="wrap" useFlexGap>
        <ToggleButtonGroup
          exclusive
          size="small"
          value={colorMode}
          onChange={(_event, value: ColorMode | null) => {
            if (value) setColorMode(value);
          }}
          aria-label="Point color"
        >
          <ToggleButton value="collision">Collision</ToggleButton>
          <ToggleButton value="cluster">Cluster</ToggleButton>
        </ToggleButtonGroup>
        <Typography variant="body2" component="code" sx={{ fontSize: "0.85rem" }}>
          {active ? `${active.id}: ${active.predicate} → ${active.predicted}` : "No rule"}
        </Typography>
      </Stack>
      <Box sx={{ width: "100%", overflowX: "auto" }}>
        <svg
          viewBox={`0 0 ${WIDTH} ${HEIGHT}`}
          width="100%"
          role="img"
          aria-label="Parameter space with rule boundaries"
          style={{ maxWidth: 760, background: "#fafafa", border: "1px solid #e0e0e0", borderRadius: 4 }}
        >
          {layout.regions.map((region) => {
            const collision = region.predicted === "collision";
            const selected = region.id === active?.id;
            return (
              <rect
                key={region.id}
                x={region.x}
                y={region.y}
                width={region.w}
                height={region.h}
                fill={showCollision ? (collision ? "rgba(198,40,40,0.10)" : "rgba(27,127,78,0.10)") : "transparent"}
                stroke={showCollision ? (collision ? "#c62828" : "#1b7f4e") : "#757575"}
                strokeWidth={selected ? 2.5 : 1}
                style={{ cursor: "pointer" }}
                onClick={() => setActiveId(region.id)}
              >
                <title>{`${region.id}: ${region.predicate} → ${region.predicted}`}</title>
              </rect>
            );
          })}
          {points.map((point, index) => (
            <circle
              key={index}
              cx={layout.sx(point.x)}
              cy={layout.sy(point.y)}
              r={2.1}
              fill={showCollision ? (point.passed ? "#1b7f4e" : "#c62828") : clusterColor(point.cluster)}
              fillOpacity={0.55}
              pointerEvents="none"
            />
          ))}
          {layout.regions.map((region) => (
            <text
              key={`${region.id}-label`}
              x={region.x + 6}
              y={region.y + 14}
              fontSize={11}
              fill={showCollision ? (region.predicted === "collision" ? "#8e1b1b" : "#145c32") : "#424242"}
              style={{ cursor: "pointer" }}
              onClick={() => setActiveId(region.id)}
            >
              {region.id}
            </text>
          ))}
          <line x1={PAD_L} y1={HEIGHT - PAD_B} x2={WIDTH - PAD_R} y2={HEIGHT - PAD_B} stroke="#616161" />
          <line x1={PAD_L} y1={PAD_T} x2={PAD_L} y2={HEIGHT - PAD_B} stroke="#616161" />
          {xTicks.map((tick) => (
            <text key={`x-${tick}`} x={layout.sx(tick)} y={HEIGHT - PAD_B + 16} fontSize={10} textAnchor="middle" fill="#424242">
              {tick.toFixed(2)}
            </text>
          ))}
          {yTicks.map((tick) => (
            <text key={`y-${tick}`} x={PAD_L - 6} y={layout.sy(tick) + 3} fontSize={10} textAnchor="end" fill="#424242">
              {tick.toFixed(2)}
            </text>
          ))}
          <text x={(PAD_L + WIDTH - PAD_R) / 2} y={HEIGHT - 8} fontSize={12} textAnchor="middle" fill="#212121">
            {xName}
          </text>
          <text
            x={16}
            y={(PAD_T + HEIGHT - PAD_B) / 2}
            fontSize={12}
            textAnchor="middle"
            fill="#212121"
            transform={`rotate(-90 16 ${(PAD_T + HEIGHT - PAD_B) / 2})`}
          >
            {yName}
          </text>
        </svg>
      </Box>
      {showCollision ? (
        <Stack direction="row" spacing={2}>
          <Typography variant="caption" color="text.secondary">
            Green point: safe trial. Red point: collision trial.
          </Typography>
          <Typography variant="caption" color="text.secondary">
            Each box is one rule. Click a box to read its predicate.
          </Typography>
        </Stack>
      ) : (
        <Stack direction="row" spacing={1.5} flexWrap="wrap" useFlexGap alignItems="center">
          {legend.map((item) => (
            <Stack key={item.label} direction="row" spacing={0.5} alignItems="center">
              <Box sx={{ width: 10, height: 10, borderRadius: "50%", bgcolor: item.color }} />
              <Typography variant="caption" color="text.secondary">
                {item.label}
              </Typography>
            </Stack>
          ))}
          <Typography variant="caption" color="text.secondary">
            Cluster ids from the selected clustering. Boxes stay the CART rules.
          </Typography>
        </Stack>
      )}
    </Stack>
  );
}
