"use client";

import { useEffect, useRef, useState } from "react";
import { useAppDispatch, useAppSelector } from "../../redux/hooks";
import { interactionSlice } from "../../redux/slices/interaction";
import {
  postDocument,
  deleteDocument,
} from "@/app/_shared/graphql/queries/documents";
import { toast } from "react-toastify";
import { getOrCreateUserId } from "@/app/_shared/utils";

const globalData: {
  fileId: string | null;
} = {
  fileId: null,
};

export function InteractionCount({ batchId }: { batchId: string }) {
  const dispatch = useAppDispatch();
  const records = useAppSelector((state) => state.interaction.records);
  const recordsRef = useRef(records); // Ref to hold latest records

  useEffect(() => {
    recordsRef.current = records;
  }, [records]);

  useEffect(() => {
    dispatch(interactionSlice.actions.reset());
  }, []);

  useEffect(() => {
    const intervalId = setInterval(() => {
      const currentRecords = recordsRef.current;
      if (currentRecords.length === 0) return;

      const jsonBlob = new Blob([JSON.stringify(currentRecords)], {
        type: "application/json",
      });

      const form = new FormData();
      const userId = getOrCreateUserId();
      form.append("file", jsonBlob, `interaction-${userId}-${batchId}.json`);

      const uploadDoc = async () => {
        try {
          if (globalData.fileId != null) {
            const response = await deleteDocument(globalData.fileId);
            console.log(response.data);
            console.log("delete interaction document");
          }
          const response = await postDocument(form);
          // @ts-ignore
          globalData.fileId = response.data["doc"].id;
          console.log(response.data);
          console.log("post interaction document");
        } catch (error) {
          console.error(error);
          toast.error(
            "Fail to save interaction file. Cannot upload the json document."
          );
        }
      };

      uploadDoc();
    }, 15000);

    return () => clearInterval(intervalId); // cleanup on unmount
  }, [batchId]);

  return null;
}
