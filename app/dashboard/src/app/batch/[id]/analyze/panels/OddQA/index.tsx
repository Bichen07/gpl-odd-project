"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import {
  Alert,
  Box,
  Button,
  Chip,
  CircularProgress,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  IconButton,
  Menu,
  MenuItem,
  Paper,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { MoreHoriz, PushPin, Send, InfoOutlined, History } from "@mui/icons-material";
import type { ChatTurn } from "../../types";
import { useOddChatSync, type ConversationSummary, type TrialAttachment } from "../../../_tabs/explore/components/dock/chatContext";

function exchangeValue(value: string | null | undefined): string {
  const text = (value ?? "").trim();
  if (!text) return "null";
  const stripped = text
    .replace(/^(asked|sent|send)\s*:\s*/i, "")
    .replace(/^(asked|sent|send)\s+/i, "")
    .trim();
  return stripped || "null";
}

// ─── ODD Q&A panel (S5 part 2) ─────────────────────────────────────────────
//
// Thin UI over POST/GET /api/odd-chat, which itself shells out to the exact
// same `python -m llm_pipeline.cli odd-chat` CLI documented in
// implementation_plan.md §7 / §9.1 and app/llm_pipeline/README.md — there is
// intentionally only one place the grounded-chat logic lives. Conversation
// history is NOT component/browser state: every turn is appended by the CLI
// to `odd_chat_log.jsonl` inside the run folder, and this panel simply reads
// it back on mount — so re-opening the dashboard (even in a different
// browser) shows the same history, and the same history is shared with
// anyone asking questions from a terminal.
export default function OddChatPanel({
  batchId,
  folder,
  apiKey,
  model,
  onOpenSetup,
  attachment = null,
  onClearAttachment,
  compact = false,
  reloadToken = 0,
}: {
  batchId: string;
  folder: string;
  apiKey: string;
  model: string;
  onOpenSetup: () => void;
  attachment?: TrialAttachment | null;
  onClearAttachment?: () => void;
  compact?: boolean;
  /** Bumped when the ODD Q&A tab is opened or clicked again. Reloads the newest log. */
  reloadToken?: number;
}) {
  const [history, setHistory] = useState<ChatTurn[]>([]);
  const [conversations, setConversations] = useState<ConversationSummary[]>([]);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [briefingAvailable, setBriefingAvailable] = useState<boolean | null>(null);
  const [missing, setMissing] = useState<string[]>([]);
  const [loadingHistory, setLoadingHistory] = useState(true);
  const [question, setQuestion] = useState("");
  const [asking, setAsking] = useState(false);
  const [askError, setAskError] = useState<string | null>(null);
  const [pendingQuestion, setPendingQuestion] = useState<string | null>(null);
  const [menuAnchor, setMenuAnchor] = useState<HTMLElement | null>(null);
  const [menuConversationId, setMenuConversationId] = useState<string | null>(null);
  const [renameOpen, setRenameOpen] = useState(false);
  const [renameValue, setRenameValue] = useState("");
  const [renameTarget, setRenameTarget] = useState<string | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<string | null>(null);
  const [building, setBuilding] = useState(false);
  const [buildNote, setBuildNote] = useState<string | null>(null);
  const [busyId, setBusyId] = useState<string | null>(null);
  const [showAbout, setShowAbout] = useState(false);
  const [flash, setFlash] = useState(false);
  const [listAnchor, setListAnchor] = useState<HTMLElement | null>(null);
  const logRef = useRef<HTMLDivElement>(null);
  const sync = useOddChatSync();
  const [selectionLabel, setSelectionLabel] = useState<string | null>(null);
  const seen = useRef(0);
  const requestGen = useRef(0);
  const reloading = useRef(false);
  const folderKey = `${batchId}|${folder}`;

  const share = useCallback((
    id: string | null,
    nextHistory: ChatTurn[],
    nextConversations: ConversationSummary[],
    extra: { briefingAvailable: boolean | null; missing: string[]; pendingQuestion: string | null },
  ) => {
    seen.current = sync.publish({
      folderKey,
      conversationId: id,
      history: nextHistory,
      conversations: nextConversations,
      briefingAvailable: extra.briefingAvailable,
      missing: extra.missing,
      pendingQuestion: extra.pendingQuestion,
    });
  }, [folderKey, sync]);

  const loadHistory = useCallback((selectedConversationId?: string | null, opts?: { latest?: boolean }) => {
    const claimed = sync.claim();
    const gen = ++requestGen.current;
    setLoadingHistory(true);
    const query = new URLSearchParams({
      batchId,
      folder,
    });
    if (selectedConversationId) query.set("conversationId", selectedConversationId);
    if (opts?.latest) {
      query.set("latest", "1");
      reloading.current = true;
    }
    fetch(`/api/odd-chat?${query.toString()}`)
      .then((r) => r.json())
      .then((d) => {
        if (gen !== requestGen.current || sync.epochRef.current !== claimed) return;
        const id = d.conversationId ?? selectedConversationId ?? "default";
        const nextHistory = (d.history ?? []) as ChatTurn[];
        const nextConversations = (d.conversations ?? []) as ConversationSummary[];
        const nextMissing = (d.missing ?? []) as string[];
        const available = Boolean(d.briefingAvailable);
        setBriefingAvailable(available);
        setMissing(nextMissing);
        setConversations(nextConversations);
        setConversationId(id);
        setHistory(nextHistory);
        setPendingQuestion(null);
        share(id, nextHistory, nextConversations, {
          briefingAvailable: available,
          missing: nextMissing,
          pendingQuestion: null,
        });
        if (opts?.latest) {
          setFlash(true);
          window.setTimeout(() => setFlash(false), 900);
        }
      })
      .catch(() => {
        if (gen !== requestGen.current || sync.epochRef.current !== claimed) return;
        setBriefingAvailable(false);
      })
      .finally(() => {
        if (opts?.latest && gen === requestGen.current) reloading.current = false;
        if (gen === requestGen.current) setLoadingHistory(false);
      });
  }, [batchId, folder, share, sync]);

  const syncRef = useRef(sync);
  syncRef.current = sync;
  const loadHistoryRef = useRef(loadHistory);
  loadHistoryRef.current = loadHistory;

  useEffect(() => {
    if (reloadToken > 0) {
      loadHistoryRef.current(null, { latest: true });
      return;
    }
    const snap = syncRef.current.snapshot;
    if (snap.folderKey === folderKey && snap.seq > 0) {
      seen.current = snap.seq;
      setConversationId(snap.conversationId);
      setHistory(snap.history);
      setConversations(snap.conversations);
      setBriefingAvailable(snap.briefingAvailable);
      setMissing(snap.missing);
      setPendingQuestion(snap.pendingQuestion);
      setAsking(Boolean(snap.pendingQuestion));
      setLoadingHistory(false);
      return;
    }
    loadHistoryRef.current();
  }, [folderKey, reloadToken]);

  useEffect(() => {
    const snap = sync.snapshot;
    if (reloading.current) return;
    if (snap.folderKey !== folderKey || snap.seq === 0 || snap.seq === seen.current) return;
    seen.current = snap.seq;
    setConversationId(snap.conversationId);
    setHistory(snap.history);
    setConversations(snap.conversations);
    setBriefingAvailable(snap.briefingAvailable);
    setMissing(snap.missing);
    setPendingQuestion(snap.pendingQuestion);
    setAsking(Boolean(snap.pendingQuestion));
    setLoadingHistory(false);
  }, [sync.snapshot, folderKey]);

  useEffect(() => {
    if (logRef.current) logRef.current.scrollTop = logRef.current.scrollHeight;
  }, [history, asking]);

  const attachmentKey = attachment
    ? `${attachment.source}|${attachment.trialIds.join(",")}`
    : "";
  useEffect(() => {
    if (!attachment || attachment.trialIds.length === 0) {
      setSelectionLabel(null);
      return;
    }
    let cancel = false;
    setSelectionLabel(null);
    fetch("/api/conversation-trials", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        batchId: Number(batchId),
        folder,
        trialIds: attachment.trialIds,
        source: attachment.source,
        preview: true,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        if (!cancel && typeof data.label === "string") setSelectionLabel(data.label);
      })
      .catch(() => {
        if (!cancel) setSelectionLabel(null);
      });
    return () => {
      cancel = true;
    };
  }, [attachmentKey, batchId, folder]);

  const menuConversation = conversations.find((conversation) => conversation.id === menuConversationId);

  const closeMenu = () => {
    setMenuAnchor(null);
    setMenuConversationId(null);
  };

  const saveRename = async () => {
    const title = renameValue.replace(/\s+/g, " ").trim();
    const target = renameTarget;
    if (!title || !target || busyId) return;
    setBusyId(target);
    setAskError(null);
    try {
      const res = await fetch("/api/odd-chat", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId: Number(batchId),
          folder,
          conversationId: target,
          title,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      const exists = conversations.some((conversation) => conversation.id === target);
      const next = exists
        ? conversations.map((conversation) =>
            conversation.id === target ? { ...conversation, title } : conversation,
          )
        : [
            {
              id: target,
              title,
              updatedAt: new Date().toISOString(),
              turnCount: history.length,
              pinned: false,
            },
            ...conversations,
          ];
      setConversations(next);
      sync.claim();
      share(conversationId, history, next, {
        briefingAvailable,
        missing,
        pendingQuestion,
      });
      setRenameOpen(false);
      setRenameTarget(null);
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusyId(null);
    }
  };

  const togglePin = async (target: string, pinned: boolean) => {
    setBusyId(target);
    setAskError(null);
    try {
      const res = await fetch("/api/odd-chat", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId: Number(batchId),
          folder,
          conversationId: target,
          pinned,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      await loadHistory(conversationId);
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusyId(null);
    }
  };

  const confirmDelete = async () => {
    const target = deleteTarget;
    if (!target || busyId) return;
    setBusyId(target);
    setAskError(null);
    try {
      const res = await fetch("/api/odd-chat", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId: Number(batchId),
          folder,
          conversationId: target,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      const next = (data.conversations ?? []) as ConversationSummary[];
      setConversations(next);
      setDeleteTarget(null);
      sync.claim();
      if (conversationId === target) {
        if (next[0]) loadHistory(next[0].id);
        else startNewConversation();
      } else {
        share(conversationId, history, next, {
          briefingAvailable,
          missing,
          pendingQuestion: null,
        });
      }
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusyId(null);
    }
  };

  const ask = async () => {
    const q = question.trim();
    if (!q || asking) return;
    const activeConversationId = conversationId ?? "default";
    if (!String(apiKey).trim()) {
      setAskError("Enter the API key in Model setup first.");
      onOpenSetup();
      return;
    }
    setAsking(true);
    setAskError(null);
    setPendingQuestion(q);
    setQuestion("");
    const listedNow = conversations.some((conversation) => conversation.id === activeConversationId)
      ? conversations
      : [
          {
            id: activeConversationId,
            title: "New conversation",
            updatedAt: new Date().toISOString(),
            turnCount: history.length,
            pinned: false,
          },
          ...conversations,
        ];
    sync.claim();
    share(activeConversationId, history, listedNow, {
      briefingAvailable,
      missing,
      pendingQuestion: q,
    });
    try {
      const res = await fetch("/api/odd-chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          batchId: Number(batchId),
          folder,
          conversationId: activeConversationId,
          question: q,
          model,
          apiKey: String(apiKey).trim(),
          attachment: attachment
            ? { trial_ids: attachment.trialIds, source: attachment.source }
            : undefined,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      setQuestion("");
      await loadHistory(activeConversationId);
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
      share(activeConversationId, history, conversations, {
        briefingAvailable,
        missing,
        pendingQuestion: null,
      });
    } finally {
      setAsking(false);
      setPendingQuestion(null);
    }
  };

  const buildFrames = async (trialIds: string[]) => {
    const ids = trialIds.filter((id) => /^\d+$/.test(id));
    if (!ids.length || building) return;
    setBuilding(true);
    setBuildNote(null);
    setAskError(null);
    try {
      const res = await fetch("/api/conversation-trials", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ batchId: Number(batchId), folder, trialIds: ids }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      const failed = (data.trials ?? []).filter((row: { ok?: boolean; error?: string }) => row.ok === false);
      setBuildNote(
        failed.length
          ? failed.map((row: { trial_id?: string; error?: string }) => `${row.trial_id}: ${row.error}`).join(" ")
          : `Stored frames for ${(data.trials ?? []).length} trial(s). Ask again to include a picture.`,
      );
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setBuilding(false);
    }
  };

  const startNewConversation = () => {
    const id =
      typeof globalThis.crypto?.randomUUID === "function"
        ? globalThis.crypto.randomUUID()
        : `conversation-${Date.now()}`;
    const next = [
      {
        id,
        title: "New conversation",
        updatedAt: new Date().toISOString(),
        turnCount: 0,
        pinned: false,
      },
      ...conversations,
    ];
    sync.claim();
    setConversationId(id);
    setHistory([]);
    setConversations(next);
    setAskError(null);
    setPendingQuestion(null);
    share(id, [], next, { briefingAvailable, missing, pendingQuestion: null });
  };

  const listedConversations: ConversationSummary[] =
    conversationId && !conversations.some((conversation) => conversation.id === conversationId)
      ? [
          {
            id: conversationId,
            title: "New conversation",
            updatedAt: new Date().toISOString(),
            turnCount: 0,
            pinned: false,
          },
          ...conversations,
        ]
      : conversations;

  return (
    <Paper
      variant={compact ? "elevation" : "outlined"}
      elevation={0}
      sx={{
        p: compact ? 0 : 2,
        height: compact ? "100%" : undefined,
        display: compact ? "flex" : "block",
        flexDirection: "column",
        bgcolor: compact ? "transparent" : undefined,
        boxShadow: "none",
      }}
    >
      <Stack direction="row" alignItems="center" spacing={0.5} sx={{ mb: compact ? 0.5 : 0 }}>
        {!compact && (
          <Typography variant="h6" sx={{ flex: 1 }}>
            ODD Q&amp;A
          </Typography>
        )}
        {compact && <Box sx={{ flex: 1 }} />}
        <Button
          size="small"
          startIcon={<InfoOutlined />}
          onClick={() => setShowAbout((open) => !open)}
          aria-expanded={showAbout}
        >
          {showAbout ? "Hide" : "About"}
        </Button>
      </Stack>
      {showAbout && (
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Ask a question about this one run. Each turn sends{" "}
          <code>odd_chat_briefing.json</code>. If a fact is only in another file, the model asks
          once for that medoid, pair, trial, summary, or BEV table. Under each answer, asked and send use the same two lines. An empty value is null.
          History below is stored in <code>conversation_log/odd_chat_log.jsonl</code>, so it
          is still here next time this dashboard is opened.
        </Typography>
      )}

      {!compact && (
      <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1.5 }} flexWrap="wrap">
        <Chip size="small" label={`model: ${model}`} variant="outlined" />
        <Chip
          size="small"
          color={apiKey ? "success" : "warning"}
          label={apiKey ? "API key from Model setup" : "no API key — open Model setup"}
          onClick={!apiKey ? onOpenSetup : undefined}
        />
        {!apiKey && (
          <Button size="small" onClick={onOpenSetup}>
            Open Model setup
          </Button>
        )}
      </Stack>
      )}

      <Box sx={{ display: "flex", gap: 1.5, alignItems: "stretch", flex: compact ? 1 : undefined, minHeight: compact ? 0 : undefined }}>
        <Box
          sx={{
            width: 260,
            flexShrink: 0,
            borderRight: "1px solid",
            borderColor: "divider",
            pr: 1,
            display: compact ? "none" : "flex",
            flexDirection: "column",
            gap: 0.5,
          }}
        >
          <Button size="small" variant="outlined" onClick={startNewConversation} sx={{ mb: 0.5 }}>
            New chat
          </Button>
          <Box sx={{ overflowY: "visible", display: "flex", flexDirection: "column", gap: 0.25 }}>
            {listedConversations.map((conversation) => {
              const selected = conversation.id === conversationId;
              return (
                <Box
                  key={conversation.id}
                  sx={{
                    display: "flex",
                    alignItems: "center",
                    borderRadius: 1.5,
                    bgcolor: selected ? "action.selected" : "transparent",
                    "&:hover": { bgcolor: selected ? "action.selected" : "action.hover" },
                  }}
                >
                  {conversation.pinned && (
                    <PushPin sx={{ fontSize: 14, ml: 0.75, color: "text.secondary" }} />
                  )}
                  <Button
                    size="small"
                    onClick={() => loadHistory(conversation.id)}
                    sx={{
                      flex: 1,
                      justifyContent: "flex-start",
                      textTransform: "none",
                      color: "text.primary",
                      minWidth: 0,
                      px: 1,
                    }}
                  >
                    <Typography variant="body2" noWrap>
                      {conversation.title}
                    </Typography>
                  </Button>
                  <IconButton
                    size="small"
                    aria-label={`Actions for ${conversation.title}`}
                    onClick={(event) => {
                      setMenuAnchor(event.currentTarget);
                      setMenuConversationId(conversation.id);
                    }}
                  >
                    <MoreHoriz fontSize="small" />
                  </IconButton>
                </Box>
              );
            })}
          </Box>
        </Box>

        <Box sx={{ flex: 1, minWidth: 0, minHeight: 0, display: "flex", flexDirection: "column" }}>
      {compact && (
        <Stack direction="row" spacing={0.5} alignItems="center" sx={{ mb: 0.5 }}>
          <Button size="small" onClick={startNewConversation}>
            New chat
          </Button>
          <Button
            size="small"
            startIcon={<History />}
            onClick={(event) => setListAnchor(event.currentTarget)}
            aria-label="Conversation history"
            aria-haspopup="menu"
            aria-expanded={Boolean(listAnchor)}
            sx={{ flex: 1, justifyContent: "flex-start", minWidth: 0, textTransform: "none" }}
          >
            <Typography variant="body2" noWrap>
              {listedConversations.find((conversation) => conversation.id === conversationId)?.title ?? "History"}
            </Typography>
          </Button>
          <Menu
            anchorEl={listAnchor}
            open={Boolean(listAnchor)}
            onClose={() => setListAnchor(null)}
            sx={{ zIndex: 1600 }}
            slotProps={{ paper: { sx: { maxHeight: 320, width: 280 } } }}
          >
            {listedConversations.length === 0 && (
              <MenuItem disabled>No conversations yet</MenuItem>
            )}
            {listedConversations.map((conversation) => (
              <MenuItem
                key={conversation.id}
                selected={conversation.id === conversationId}
                onClick={() => {
                  setListAnchor(null);
                  loadHistory(conversation.id);
                }}
              >
                <Stack direction="row" spacing={0.75} alignItems="center" sx={{ minWidth: 0 }}>
                  {conversation.pinned && <PushPin sx={{ fontSize: 14, color: "text.secondary" }} />}
                  <Typography variant="body2" noWrap>
                    {conversation.title}
                  </Typography>
                </Stack>
              </MenuItem>
            ))}
          </Menu>
        </Stack>
      )}
      {loadingHistory ? (
        <Stack alignItems="center" sx={{ py: 2 }}>
          <CircularProgress size={22} />
        </Stack>
      ) : !briefingAvailable ? (
        <Alert severity="info">
          <Typography variant="body2">
            <strong>Not available yet.</strong> Build the briefing first (needs S2 boundary
            export):
          </Typography>
          <Typography variant="body2" component="pre" sx={{ fontSize: "0.78rem", mt: 0.5 }}>
            {`python -m llm_pipeline.cli odd-export --run-dir results/batch${batchId}/${folder}\npython -m llm_pipeline.cli odd-rules --run-dir results/batch${batchId}/${folder}\npython -m llm_pipeline.cli odd-briefing --run-dir results/batch${batchId}/${folder}`}
          </Typography>
        </Alert>
      ) : (
        <>
          {missing.length > 0 && (
            <Alert severity="warning" sx={{ mb: 1 }}>
              <Typography variant="body2">
                Briefing has gaps — the chat will say &ldquo;unknown&rdquo; rather than guess for:{" "}
                {missing.join("; ")}
              </Typography>
            </Alert>
          )}

          <Box
            ref={logRef}
            sx={{
              flex: compact ? 1 : undefined,
              minHeight: compact ? 0 : undefined,
              maxHeight: compact ? "none" : "none",
              overflowY: compact ? "auto" : "visible",
              overflowX: "hidden",
              mb: 1.5,
              bgcolor: "grey.50",
              animation: flash ? "oddQaFlash 0.9s ease" : undefined,
              "@keyframes oddQaFlash": {
                "0%": { backgroundColor: "#fff4cc" },
                "100%": { backgroundColor: "#fafafa" },
              },
              borderRadius: 2,
              px: 1.25,
              py: 1.25,
              display: "flex",
              flexDirection: "column",
              gap: 1.5,
            }}
          >
            {history.length === 0 && !pendingQuestion ? (
              <Typography variant="body2" color="text.secondary" sx={{ m: "auto", textAlign: "center" }}>
                Ask a question about this run.
              </Typography>
            ) : (
              history.map((t, i) => (
                <Stack key={`${t.timestamp ?? "turn"}-${i}`} spacing={1.5} sx={{ width: "100%", minWidth: 0 }}>
                  <Box sx={{ display: "flex", justifyContent: "flex-end" }}>
                    <Box
                      sx={{
                        maxWidth: "85%",
                        minWidth: 0,
                        px: 1.75,
                        py: 1.25,
                        borderRadius: "18px 18px 6px 18px",
                        bgcolor: "primary.main",
                        color: "primary.contrastText",
                      }}
                    >
                      <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", overflowWrap: "anywhere" }}>
                        {t.question}
                      </Typography>
                    </Box>
                  </Box>
                  <Box sx={{ display: "flex", justifyContent: "flex-start" }}>
                    <Box
                      sx={{
                        maxWidth: "85%",
                        minWidth: 0,
                        px: 1.75,
                        py: 1.25,
                        borderRadius: "18px 18px 18px 6px",
                        bgcolor: "background.paper",
                        border: "1px solid",
                        borderColor: "divider",
                      }}
                    >
                      <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", overflowWrap: "anywhere" }}>
                        {t.answer}
                      </Typography>
                      <Typography variant="caption" color="text.secondary" sx={{ display: "block", mt: 1, overflowWrap: "anywhere" }}>
                        asked: {exchangeValue(t.asked)}
                      </Typography>
                      <Typography variant="caption" color="text.secondary" sx={{ display: "block", overflowWrap: "anywhere" }}>
                        send: {exchangeValue(t.sent)}
                      </Typography>
                      {t.dry_run && (
                        <Chip label="dry-run" size="small" color="warning" sx={{ mt: 0.5 }} />
                      )}
                      {(t.images ?? []).length > 0 && (
                        <Stack direction="row" spacing={0.5} sx={{ mt: 1, overflowX: "auto" }}>
                          {(t.images ?? []).map((image) => (
                            <Box key={image.rel} sx={{ width: 140, flexShrink: 0 }}>
                              <Box
                                component="img"
                                alt={image.label || "BEV frame"}
                                src={`/api/run-frame?batchId=${encodeURIComponent(batchId)}&folder=${encodeURIComponent(folder)}&rel=${encodeURIComponent(image.rel)}`}
                                sx={{ width: "100%", borderRadius: 1, display: "block" }}
                              />
                              <Typography variant="caption" color="text.secondary">
                                {image.t != null ? `${image.t} s ` : ""}
                                {image.label}
                              </Typography>
                            </Box>
                          ))}
                        </Stack>
                      )}
                      {(t.images ?? []).length === 0 && (t.build_trial_ids ?? []).length > 0 && (
                        <Button
                          size="small"
                          sx={{ mt: 1 }}
                          disabled={building}
                          onClick={() => void buildFrames(t.build_trial_ids ?? [])}
                        >
                          Build missing frames
                        </Button>
                      )}
                    </Box>
                  </Box>
                </Stack>
              ))
            )}
            {pendingQuestion && (
              <Box sx={{ display: "flex", justifyContent: "flex-end" }}>
                <Box
                  sx={{
                    maxWidth: "75%",
                    px: 1.75,
                    py: 1.25,
                    borderRadius: "18px 18px 6px 18px",
                    bgcolor: "primary.main",
                    color: "primary.contrastText",
                  }}
                >
                  <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
                    {pendingQuestion}
                  </Typography>
                </Box>
              </Box>
            )}
            {asking && (
              <Box sx={{ display: "flex", justifyContent: "flex-start" }}>
                <Box
                  sx={{
                    px: 1.75,
                    py: 1.25,
                    borderRadius: "18px 18px 18px 6px",
                    bgcolor: "background.paper",
                    border: "1px solid",
                    borderColor: "divider",
                  }}
                >
                  <CircularProgress size={16} />
                </Box>
              </Box>
            )}
          </Box>

          {askError && (
            <Alert severity="error" sx={{ mb: 1 }}>
              {askError}
            </Alert>
          )}

          {attachment && (
            <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1 }}>
              <Chip
                label={selectionLabel ?? `${attachment.total} ${attachment.source} trials`}
                onDelete={onClearAttachment}
                size="small"
              />
              <Button size="small" disabled={building} onClick={() => void buildFrames(attachment.trialIds)}>
                {building ? "Building…" : "Build missing frames"}
              </Button>
            </Stack>
          )}
          {buildNote && (
            <Typography variant="caption" color="text.secondary" sx={{ display: "block", mb: 1 }}>
              {buildNote}
            </Typography>
          )}

          <Stack direction="row" spacing={1} alignItems="flex-end">
            <TextField
              fullWidth
              multiline
              maxRows={6}
              placeholder="Message this run"
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter" && !e.shiftKey) {
                  e.preventDefault();
                  void ask();
                }
              }}
              sx={{
                "& .MuiOutlinedInput-root": { borderRadius: 3, bgcolor: "background.paper" },
              }}
            />
            <Button
              variant="contained"
              onClick={() => {
                void ask();
              }}
              disabled={asking || !question.trim() || !apiKey}
              aria-label="Send"
              sx={{ minWidth: 48, height: 48, borderRadius: 3 }}
            >
              {asking ? <CircularProgress size={18} color="inherit" /> : <Send fontSize="small" />}
            </Button>
          </Stack>
          <Typography variant="caption" color="text.secondary" sx={{ mt: 0.5, display: compact ? "none" : "block" }}>
            Uses the model and API key from the Model setup tab (no second key field).
          </Typography>
        </>
      )}
        </Box>
      </Box>

      <Menu anchorEl={menuAnchor} open={Boolean(menuAnchor)} onClose={closeMenu}>
        <MenuItem
          onClick={() => {
            const current = conversations.find((conversation) => conversation.id === menuConversationId);
            setRenameTarget(menuConversationId);
            setRenameValue(current?.title ?? "New conversation");
            setRenameOpen(true);
            closeMenu();
          }}
        >
          Change name
        </MenuItem>
        <MenuItem
          onClick={() => {
            const target = menuConversationId;
            const pinned = Boolean(menuConversation?.pinned);
            closeMenu();
            if (target) void togglePin(target, !pinned);
          }}
        >
          {menuConversation?.pinned ? "Unpin" : "Pin"}
        </MenuItem>
        <MenuItem
          onClick={() => {
            setDeleteTarget(menuConversationId);
            closeMenu();
          }}
        >
          Delete
        </MenuItem>
      </Menu>

      <Dialog open={renameOpen} onClose={() => setRenameOpen(false)} fullWidth maxWidth="xs">
        <DialogTitle>Change name</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            fullWidth
            margin="dense"
            label="Name"
            value={renameValue}
            onChange={(e) => setRenameValue(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                e.preventDefault();
                void saveRename();
              }
            }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setRenameOpen(false)}>Cancel</Button>
          <Button onClick={() => void saveRename()} disabled={!renameValue.trim() || Boolean(busyId)}>
            Save
          </Button>
        </DialogActions>
      </Dialog>

      <Dialog open={Boolean(deleteTarget)} onClose={() => setDeleteTarget(null)}>
        <DialogTitle>Delete this conversation?</DialogTitle>
        <DialogActions>
          <Button onClick={() => setDeleteTarget(null)}>Cancel</Button>
          <Button color="error" onClick={() => void confirmDelete()} disabled={Boolean(busyId)}>
            Delete
          </Button>
        </DialogActions>
      </Dialog>
    </Paper>
  );
}
