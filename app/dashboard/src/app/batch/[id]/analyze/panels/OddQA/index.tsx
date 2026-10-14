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
import { MoreHoriz, PushPin, Send } from "@mui/icons-material";
import type { ChatTurn } from "../../types";

function requestedLabel(requested: ChatTurn["requested"]): string | null {
  if (!requested?.need) return null;
  if (requested.need === "medoid") return `asked medoid cluster ${requested.cluster}`;
  if (requested.need === "pair") return `asked pair ${requested.folder}`;
  if (requested.need === "trial") return `asked trial ${requested.trial_id}`;
  return `asked ${requested.need}`;
}

type ConversationSummary = {
  id: string;
  title: string;
  updatedAt: string;
  turnCount: number;
  pinned?: boolean;
};

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
}: {
  batchId: string;
  folder: string;
  apiKey: string;
  model: string;
  onOpenSetup: () => void;
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
  const [busyId, setBusyId] = useState<string | null>(null);
  const logRef = useRef<HTMLDivElement>(null);

  const loadHistory = useCallback((selectedConversationId?: string | null) => {
    setLoadingHistory(true);
    const query = new URLSearchParams({
      batchId,
      folder,
    });
    if (selectedConversationId) query.set("conversationId", selectedConversationId);
    fetch(`/api/odd-chat?${query.toString()}`)
      .then((r) => r.json())
      .then((d) => {
        setBriefingAvailable(Boolean(d.briefingAvailable));
        setMissing(d.missing ?? []);
        setConversations(d.conversations ?? []);
        setConversationId(d.conversationId ?? selectedConversationId ?? "default");
        setHistory(d.history ?? []);
      })
      .catch(() => setBriefingAvailable(false))
      .finally(() => setLoadingHistory(false));
  }, [batchId, folder]);

  useEffect(() => {
    loadHistory();
  }, [loadHistory]);

  useEffect(() => {
    if (logRef.current) logRef.current.scrollTop = logRef.current.scrollHeight;
  }, [history, asking]);

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
      setConversations((prev) => {
        const exists = prev.some((conversation) => conversation.id === target);
        if (!exists) {
          return [
            {
              id: target,
              title,
              updatedAt: new Date().toISOString(),
              turnCount: history.length,
              pinned: false,
            },
            ...prev,
          ];
        }
        return prev.map((conversation) =>
          conversation.id === target ? { ...conversation, title } : conversation,
        );
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
      if (conversationId === target) {
        if (next[0]) loadHistory(next[0].id);
        else startNewConversation();
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
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);
      setQuestion("");
      await loadHistory(activeConversationId);
    } catch (e) {
      setAskError(e instanceof Error ? e.message : String(e));
    } finally {
      setAsking(false);
      setPendingQuestion(null);
    }
  };

  const startNewConversation = () => {
    const id =
      typeof globalThis.crypto?.randomUUID === "function"
        ? globalThis.crypto.randomUUID()
        : `conversation-${Date.now()}`;
    setConversationId(id);
    setHistory([]);
    setAskError(null);
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
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        ODD Q&amp;A
      </Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
        Ask a question about this one run. Each turn sends a short index from{" "}
        <code>odd_chat_briefing.json</code>. If a fact is only in a file, the model asks
        once for that medoid, pair, trial, summary, or BEV table. The chips under the answer say what was asked and what was sent.
        History below is stored in <code>conversation_log/odd_chat_log.jsonl</code>, so it
        is still here next time this dashboard is opened.
      </Typography>

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

      <Box sx={{ display: "flex", gap: 1.5, alignItems: "stretch", minHeight: 480 }}>
        <Box
          sx={{
            width: 260,
            flexShrink: 0,
            borderRight: "1px solid",
            borderColor: "divider",
            pr: 1,
            display: "flex",
            flexDirection: "column",
            gap: 0.5,
          }}
        >
          <Button size="small" variant="outlined" onClick={startNewConversation} sx={{ mb: 0.5 }}>
            New chat
          </Button>
          <Box sx={{ overflowY: "auto", maxHeight: 560, display: "flex", flexDirection: "column", gap: 0.25 }}>
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

        <Box sx={{ flex: 1, minWidth: 0 }}>
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
              minHeight: 360,
              maxHeight: 520,
              overflowY: "auto",
              mb: 1.5,
              bgcolor: "grey.50",
              borderRadius: 2,
              px: 2,
              py: 2,
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
                <Stack key={`${t.timestamp ?? "turn"}-${i}`} spacing={1.5}>
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
                        {t.question}
                      </Typography>
                    </Box>
                  </Box>
                  <Box sx={{ display: "flex", justifyContent: "flex-start" }}>
                    <Box
                      sx={{
                        maxWidth: "75%",
                        px: 1.75,
                        py: 1.25,
                        borderRadius: "18px 18px 18px 6px",
                        bgcolor: "background.paper",
                        border: "1px solid",
                        borderColor: "divider",
                      }}
                    >
                      <Typography variant="body2" sx={{ whiteSpace: "pre-wrap" }}>
                        {t.answer}
                      </Typography>
                      <Stack spacing={0.5} alignItems="flex-start" sx={{ mt: 1 }}>
                        {t.asked && (
                          <Chip label={t.asked} size="small" color="info" variant="outlined" />
                        )}
                        {t.sent && (
                          <Chip label={t.sent} size="small" variant="outlined" />
                        )}
                        {!t.asked && requestedLabel(t.requested) && (
                          <Chip label={requestedLabel(t.requested)} size="small" color="info" variant="outlined" />
                        )}
                        {!t.asked && (t.citations ?? []).map((c, j) => (
                          <Chip key={j} label={c} size="small" variant="outlined" />
                        ))}
                        {t.dry_run && (
                          <Chip label="dry-run" size="small" color="warning" />
                        )}
                      </Stack>
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
          <Typography variant="caption" color="text.secondary" sx={{ mt: 0.5, display: "block" }}>
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
