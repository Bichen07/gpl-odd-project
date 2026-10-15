"use client";

import { createContext, useCallback, useContext, useRef, useState, type ReactNode } from "react";
import type { ChatTurn } from "../../../../analyze/types";

export type TrialAttachment = {
  trialIds: string[];
  source: "lasso" | "boundary" | "filter";
  total: number;
};

export const TRIAL_DRAG_TYPE = "application/x-trial-selection";

type ChatUi = {
  open: boolean;
  setOpen: (open: boolean) => void;
  attachment: TrialAttachment | null;
  setAttachment: (attachment: TrialAttachment | null) => void;
};

export const ChatUiContext = createContext<ChatUi>({
  open: false,
  setOpen: () => {},
  attachment: null,
  setAttachment: () => {},
});

export function useChatUi(): ChatUi {
  return useContext(ChatUiContext);
}

export type ConversationSummary = {
  id: string;
  title: string;
  updatedAt: string;
  turnCount: number;
  pinned?: boolean;
};

export type OddChatSnapshot = {
  folderKey: string;
  conversationId: string | null;
  history: ChatTurn[];
  conversations: ConversationSummary[];
  briefingAvailable: boolean | null;
  missing: string[];
  pendingQuestion: string | null;
  seq: number;
};

type OddChatSyncApi = {
  snapshot: OddChatSnapshot;
  publish: (next: Omit<OddChatSnapshot, "seq">) => number;
  claim: () => number;
  epochRef: { current: number };
};

const EMPTY_SNAPSHOT: OddChatSnapshot = {
  folderKey: "",
  conversationId: null,
  history: [],
  conversations: [],
  briefingAvailable: null,
  missing: [],
  pendingQuestion: null,
  seq: 0,
};

const OddChatSyncContext = createContext<OddChatSyncApi>({
  snapshot: EMPTY_SNAPSHOT,
  publish: () => 0,
  claim: () => 0,
  epochRef: { current: 0 },
});

export function OddChatSyncProvider({ children }: { children: ReactNode }) {
  const [snapshot, setSnapshot] = useState<OddChatSnapshot>(EMPTY_SNAPSHOT);
  const epochRef = useRef(0);

  const claim = useCallback(() => {
    epochRef.current += 1;
    return epochRef.current;
  }, []);

  const publish = useCallback((next: Omit<OddChatSnapshot, "seq">) => {
    epochRef.current += 1;
    const seq = epochRef.current;
    setSnapshot({ ...next, seq });
    return seq;
  }, []);

  return (
    <OddChatSyncContext.Provider value={{ snapshot, publish, claim, epochRef }}>
      {children}
    </OddChatSyncContext.Provider>
  );
}

export function useOddChatSync(): OddChatSyncApi {
  return useContext(OddChatSyncContext);
}
