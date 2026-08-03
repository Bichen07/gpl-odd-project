/**
 * Read LLM product YAML into the shape formerly provided by *_meta.json.
 */
import fs from "fs";
import { parse } from "yaml";

export function readYamlDoc(
  p: string | null,
): Record<string, unknown> | null {
  if (!p || !fs.existsSync(p)) return null;
  try {
    const doc = parse(fs.readFileSync(p, "utf-8"));
    if (doc && typeof doc === "object" && !Array.isArray(doc)) {
      return doc as Record<string, unknown>;
    }
    return null;
  } catch {
    return null;
  }
}

/**
 * Compatibility wrapper: ``{ parsed: <yaml without llm_meta>, ...llm_meta }``.
 * Lets UI keep reading ``meta.parsed`` / ``meta.token_usage``.
 */
export function metaFromYamlPath(
  p: string | null,
): Record<string, unknown> | null {
  const doc = readYamlDoc(p);
  if (!doc) return null;
  const llmMeta = doc.llm_meta;
  const parsed: Record<string, unknown> = { ...doc };
  delete parsed.llm_meta;
  const out: Record<string, unknown> = { parsed };
  if (llmMeta && typeof llmMeta === "object" && !Array.isArray(llmMeta)) {
    Object.assign(out, llmMeta as Record<string, unknown>);
  }
  return out;
}
