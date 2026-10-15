"use client";

import { useEffect, useRef, useState } from "react";
import { Box, Fab, IconButton, Paper, Stack, TextField, Typography } from "@mui/material";
import { Chat, Key } from "@mui/icons-material";
import OddQA from "../../../../analyze/panels/OddQA";
import { TRIAL_DRAG_TYPE, useChatUi, type TrialAttachment } from "./chatContext";

type Corner = "br" | "bl" | "tr" | "tl";

const FRAME_KEY = "gpl-odd-chat-frame";
const MIN_W = 280;
const MIN_H = 320;

function snapCorner(x: number, y: number): Corner {
  const right = x > window.innerWidth / 2;
  const bottom = y > window.innerHeight / 2;
  if (bottom && right) return "br";
  if (bottom) return "bl";
  if (right) return "tr";
  return "tl";
}

function cornerSx(corner: Corner, offset: number) {
  const edge = 24;
  if (corner === "br") return { right: edge, bottom: offset, left: "auto", top: "auto" };
  if (corner === "bl") return { left: edge, bottom: offset, right: "auto", top: "auto" };
  if (corner === "tr") return { right: edge, top: offset, left: "auto", bottom: "auto" };
  return { left: edge, top: offset, right: "auto", bottom: "auto" };
}

export default function ChatDrawer({
  batchId,
  folder,
}: {
  batchId: string;
  folder: string | null;
}) {
  const chat = useChatUi();
  const [apiKey, setApiKey] = useState("");
  const [showKey, setShowKey] = useState(false);
  const [over, setOver] = useState(false);
  const [corner, setCorner] = useState<Corner>("br");
  const [size, setSize] = useState({ w: 380, h: 520 });
  const [dragPos, setDragPos] = useState<{ x: number; y: number } | null>(null);
  const [ready, setReady] = useState(false);
  const [viewport, setViewport] = useState({ w: 1280, h: 800 });
  const suppressClick = useRef(false);

  useEffect(() => {
    const read = () => setViewport({ w: window.innerWidth, h: window.innerHeight });
    read();
    window.addEventListener("resize", read);
    return () => window.removeEventListener("resize", read);
  }, []);

  useEffect(() => {
    try {
      const raw = localStorage.getItem(FRAME_KEY);
      if (raw) {
        const saved = JSON.parse(raw) as { corner?: Corner; w?: number; h?: number };
        if (saved.corner === "br" || saved.corner === "bl" || saved.corner === "tr" || saved.corner === "tl") {
          setCorner(saved.corner);
        }
        if (typeof saved.w === "number" && typeof saved.h === "number") {
          setSize({ w: Math.max(MIN_W, saved.w), h: Math.max(MIN_H, saved.h) });
        }
      }
    } catch {
      /* keep the bottom-right default */
    }
    setReady(true);
  }, []);

  useEffect(() => {
    if (!ready) return;
    localStorage.setItem(FRAME_KEY, JSON.stringify({ corner, w: size.w, h: size.h }));
  }, [ready, corner, size]);

  const takeDrop = (event: React.DragEvent) => {
    event.preventDefault();
    const raw = event.dataTransfer.getData(TRIAL_DRAG_TYPE);
    setOver(false);
    if (!raw) return;
    try {
      const parsed = JSON.parse(raw) as TrialAttachment;
      if (Array.isArray(parsed.trialIds) && parsed.trialIds.length > 0) {
        chat.setAttachment(parsed);
        chat.setOpen(true);
      }
    } catch {
      /* not a selection chip */
    }
  };

  const dragButton = (event: React.PointerEvent) => {
    event.preventDefault();
    const startX = event.clientX;
    const startY = event.clientY;
    let moved = false;
    const move = (e: PointerEvent) => {
      if (Math.hypot(e.clientX - startX, e.clientY - startY) > 4) moved = true;
      if (moved) setDragPos({ x: e.clientX, y: e.clientY });
    };
    const up = (e: PointerEvent) => {
      window.removeEventListener("pointermove", move);
      window.removeEventListener("pointerup", up);
      if (moved) {
        suppressClick.current = true;
        setCorner(snapCorner(e.clientX, e.clientY));
        setDragPos(null);
      }
    };
    window.addEventListener("pointermove", move);
    window.addEventListener("pointerup", up);
  };

  const startResize = (event: React.PointerEvent, axis: "x" | "y" | "xy") => {
    event.preventDefault();
    event.stopPropagation();
    const startX = event.clientX;
    const startY = event.clientY;
    const startW = size.w;
    const startH = size.h;
    const growLeft = corner === "br" || corner === "tr";
    const growUp = corner === "br" || corner === "bl";
    const move = (e: PointerEvent) => {
      const dx = e.clientX - startX;
      const dy = e.clientY - startY;
      setSize({
        w: axis === "y"
          ? startW
          : Math.min(window.innerWidth - 48, Math.max(MIN_W, growLeft ? startW - dx : startW + dx)),
        h: axis === "x"
          ? startH
          : Math.min(window.innerHeight - 120, Math.max(MIN_H, growUp ? startH - dy : startH + dy)),
      });
    };
    const up = () => {
      window.removeEventListener("pointermove", move);
      window.removeEventListener("pointerup", up);
    };
    window.addEventListener("pointermove", move);
    window.addEventListener("pointerup", up);
  };

  const widthEdge = corner === "br" || corner === "tr" ? "left" : "right";
  const heightEdge = corner === "br" || corner === "bl" ? "top" : "bottom";
  const boxW = Math.min(size.w, Math.max(MIN_W, viewport.w - 48));
  const boxH = Math.min(size.h, Math.max(MIN_H, viewport.h - 120));

  return (
    <>
      <Fab
        color="primary"
        aria-label="Open conversation. Drag to another corner."
        onPointerDown={dragButton}
        onClick={() => {
          if (suppressClick.current) {
            suppressClick.current = false;
            return;
          }
          chat.setOpen(!chat.open);
        }}
        sx={{
          position: "fixed",
          zIndex: 1400,
          cursor: "grab",
          ...(dragPos
            ? { left: dragPos.x - 28, top: dragPos.y - 28, right: "auto", bottom: "auto" }
            : cornerSx(corner, 24)),
        }}
      >
        <Chat />
      </Fab>
      {chat.open && (
        <Paper
          elevation={8}
          onDragOver={(event) => {
            event.preventDefault();
            setOver(true);
          }}
          onDragLeave={() => setOver(false)}
          onDrop={takeDrop}
          sx={{
            position: "fixed",
            ...cornerSx(corner, 88),
            width: boxW,
            height: boxH,
            maxWidth: "calc(100vw - 32px)",
            zIndex: 1400,
            display: "flex",
            flexDirection: "column",
            overflow: "hidden",
            outline: over ? "2px solid" : "none",
            outlineColor: "primary.main",
          }}
        >
          <Stack direction="row" alignItems="center" spacing={0.5} sx={{ px: 1.5, py: 0.75, borderBottom: "1px solid", borderColor: "divider" }}>
            <Typography variant="subtitle2" sx={{ flex: 1 }}>
              Conversation
            </Typography>
            <IconButton size="small" aria-label="API key" onClick={() => setShowKey((open) => !open)}>
              <Key fontSize="small" />
            </IconButton>
          </Stack>
          {showKey && (
            <TextField
              size="small"
              type="password"
              label="API key"
              value={apiKey}
              onChange={(event) => setApiKey(event.target.value)}
              autoComplete="off"
              sx={{ m: 1 }}
            />
          )}
          <Box sx={{ flex: 1, minHeight: 0, display: "flex", flexDirection: "column", px: 1, pb: 1 }}>
            {folder ? (
              <OddQA
                batchId={batchId}
                folder={folder}
                apiKey={apiKey}
                model="gemini-2.5-flash"
                onOpenSetup={() => setShowKey(true)}
                attachment={chat.attachment}
                onClearAttachment={() => chat.setAttachment(null)}
                compact
              />
            ) : (
              <Typography variant="body2" color="text.secondary" sx={{ p: 1 }}>
                Select a clustering to open its conversation.
              </Typography>
            )}
          </Box>
          <Box
            onPointerDown={(event) => startResize(event, "x")}
            sx={{
              position: "absolute",
              top: 0,
              bottom: 0,
              width: 8,
              cursor: "ew-resize",
              ...(widthEdge === "left" ? { left: 0 } : { right: 0 }),
            }}
          />
          <Box
            onPointerDown={(event) => startResize(event, "y")}
            sx={{
              position: "absolute",
              left: 0,
              right: 0,
              height: 8,
              cursor: "ns-resize",
              ...(heightEdge === "top" ? { top: 0 } : { bottom: 0 }),
            }}
          />
          <Box
            onPointerDown={(event) => startResize(event, "xy")}
            sx={{
              position: "absolute",
              width: 14,
              height: 14,
              cursor: corner === "br" || corner === "tl" ? "nesw-resize" : "nwse-resize",
              ...(widthEdge === "left" ? { left: 0 } : { right: 0 }),
              ...(heightEdge === "top" ? { top: 0 } : { bottom: 0 }),
            }}
          />
        </Paper>
      )}
    </>
  );
}
