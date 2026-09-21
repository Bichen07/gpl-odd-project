"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import {
  Alert,
  Box,
  Button,
  Chip,
  CircularProgress,
  Divider,
  FormControl,
  InputLabel,
  MenuItem,
  Paper,
  Select,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import type { ChatTurn } from "../../types";

type ConversationSummary = {
  id: string;
  title: string;
  updatedAt: string;
  turnCount: number;
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
  }, [history]);

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

  return (
    <Paper variant="outlined" sx={{ p: 2 }}>
      <Typography variant="h6" gutterBottom>
        ODD Q&amp;A
      </Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
        Ask a question about this one run (e.g. &ldquo;What is the weakness of this AV
        system?&rdquo;, &ldquo;Which condition leads to high failure probability?&rdquo;,
        &ldquo;Why keep these clusters separate?&rdquo;). Answers are grounded only in this
        run&rsquo;s deterministic stats + LLM-authored cluster/pair products (
        <code>odd_chat_briefing.json</code>) — never invented. History below is stored in{" "}
        <code>odd_chat_log.jsonl</code> in the run folder, so it is still here next time this
        dashboard is opened (by anyone), and is shared with the same command run from a terminal.
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

      <Stack direction="row" spacing={1} alignItems="center" sx={{ mb: 1.5 }} flexWrap="wrap">
        <Button size="small" variant="outlined" onClick={startNewConversation}>
          New conversation
        </Button>
        <FormControl size="small" sx={{ minWidth: 280 }}>
          <InputLabel id="odd-conversation-label">Conversation</InputLabel>
          <Select
            labelId="odd-conversation-label"
            value={conversationId ?? ""}
            label="Conversation"
            onChange={(e) => loadHistory(e.target.value)}
          >
            {conversationId &&
              !conversations.some((conversation) => conversation.id === conversationId) && (
                <MenuItem value={conversationId}>New conversation (unsaved)</MenuItem>
              )}
            {conversations.map((conversation) => (
              <MenuItem key={conversation.id} value={conversation.id}>
                {conversation.title} ({conversation.turnCount} {conversation.turnCount === 1 ? "turn" : "turns"})
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </Stack>

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
              maxHeight: 380,
              overflowY: "auto",
              mb: 2,
              border: "1px solid",
              borderColor: "divider",
              borderRadius: 1,
              p: 1.5,
            }}
          >
            {history.length === 0 ? (
              <Typography variant="body2" color="text.secondary">
                No questions asked yet for this run.
              </Typography>
            ) : (
              history.map((t, i) => (
                <Box key={i} sx={{ mb: 2 }}>
                  <Typography variant="subtitle2">You: {t.question}</Typography>
                  <Typography variant="body2" sx={{ whiteSpace: "pre-wrap", mt: 0.5 }}>
                    {t.answer}
                  </Typography>
                  <Stack direction="row" spacing={0.5} flexWrap="wrap" sx={{ mt: 0.5 }}>
                    {(t.citations ?? []).map((c, j) => (
                      <Chip key={j} label={c} size="small" variant="outlined" />
                    ))}
                    {t.dry_run && (
                      <Chip label="dry-run (no API key)" size="small" color="warning" />
                    )}
                    <Chip label={t.model} size="small" variant="outlined" />
                  </Stack>
                  {i < history.length - 1 && <Divider sx={{ mt: 1.5 }} />}
                </Box>
              ))
            )}
          </Box>

          {askError && (
            <Alert severity="error" sx={{ mb: 1 }}>
              {askError}
            </Alert>
          )}

          <Stack direction="row" spacing={1}>
            <TextField
              size="small"
              fullWidth
              placeholder='e.g. "Which scenario should we test next?"'
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter" && !e.shiftKey) {
                  e.preventDefault();
                  ask();
                }
              }}
            />
            <Button
              variant="contained"
              onClick={ask}
              disabled={asking || !question.trim() || !apiKey}
            >
              {asking ? <CircularProgress size={18} /> : "Ask"}
            </Button>
          </Stack>
          <Typography variant="caption" color="text.secondary" sx={{ mt: 0.5, display: "block" }}>
            Uses the model and API key from the Model setup tab (no second key field).
          </Typography>
        </>
      )}
    </Paper>
  );
}
