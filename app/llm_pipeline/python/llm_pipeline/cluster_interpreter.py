"""
cluster_interpreter.py — Phase 5: LLM-based Cluster Interpretation

Orchestrates the LLM pipeline for characterizing behavioral clusters:
1. Loads cluster statistics, medoid trial data, BEV snapshots, MFPCA heatmap
2. Constructs multi-modal prompts (text + images)
3. Calls LLM with reflection/review pass
4. Returns structured YAML describing cluster behavior and safety

Adapted from xosc_gen/models/scenario_interpretation.py for cluster analysis.

Usage:
    from llm_pipeline.cluster_interpreter import ClusterInterpreter
    
    interpreter = ClusterInterpreter(
        model="gpt-4o",
        xodr_path="results/map/hct_6.xodr"
    )
    
    result = interpreter.analyze_cluster(
        cluster_id=2,
        cluster_stats={...},
        medoid_trial_id="5951",
        medoid_observations=[...],
        bev_snapshots=[...],
        mfpca_heatmap_path="...",
    )
"""

from __future__ import annotations

import asyncio
import base64
import os
import re
import yaml
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional

from .paths import PROMPT_TEMPLATES_DIR
from langchain_community.callbacks.manager import get_openai_callback
from langchain_core.messages import HumanMessage, SystemMessage

from .llm_factory import (
    DEFAULT_MODEL,
    create_interpretation_llm,
    is_gemini_model,
    normalize_model_name,
)


@dataclass
class ClusterInterpretation:
    """Result of LLM cluster analysis."""
    cluster_id: int
    cluster_label: str
    confidence: str  # "high", "medium", "low"
    behavior_description: str
    safety_assessment: Dict
    parameter_conditions: Dict
    ego_perspective_summary: List[Dict]
    raw_yaml: str  # Full YAML string
    token_usage: Dict  # {"Prompt": int, "Completion": int, "Total": int}
    intra_consistency_score: Optional[int] = None   # 1-10 from Step 7
    intra_notes: Optional[str] = None               # free-text from Step 7


class ClusterInterpreter:
    """
    LLM-based pipeline for characterizing driving behavior clusters.
    
    Args:
        model: LLM id — gemini-* (GOOGLE_API_KEY) or gpt-* (OPENAI_API_KEY);
               default ``gemini-2.5-flash``
        xodr_path: Path to OpenDRIVE map file (for map description)
        temperature: LLM temperature (default 0.1 for consistency)
        prompt_dir: Directory containing prompt templates
        api_key: Optional API key (else GOOGLE_API_KEY / OPENAI_API_KEY from env)
    """
    
    def __init__(
        self,
        model: str = DEFAULT_MODEL,
        xodr_path: Optional[str] = None,
        temperature: float = 0.1,
        prompt_dir: Optional[str] = None,
        api_key: Optional[str] = None,
        prompt_overrides: Optional[Dict[str, str]] = None,
        do_review: bool = True,
    ):
        self.model = normalize_model_name(model)
        self.temperature = temperature
        self.prompt_dir = (
            Path(prompt_dir) if prompt_dir else PROMPT_TEMPLATES_DIR
        )
        self.xodr_path = xodr_path
        # Optional UI-supplied prompt text overrides, keyed:
        #   "system" | "common_sense" | "interaction" | "reviewer".
        # A blank/None value falls back to the on-disk template.
        self.prompt_overrides = {
            k: v for k, v in (prompt_overrides or {}).items() if v
        }
        self.do_review = do_review
        
        self.llm = create_interpretation_llm(
            self.model,
            api_key=api_key,
            temperature=temperature,
        )
        # Reuse one event loop per interpreter — Gemini gRPC breaks if
        # asyncio.run() is called twice (Pass 1 then Pass 2).
        self._loop: Optional[asyncio.AbstractEventLoop] = None

        provider = "Gemini" if is_gemini_model(self.model) else "OpenAI"
        print(
            f"[ClusterInterpreter] Initialized ({provider}) "
            f"model={self.model}, temp={temperature}"
        )
    
    def analyze_cluster(
        self,
        cluster_id: int,
        cluster_stats: Dict,
        medoid_trial_id: str,
        medoid_action_log: str,
        bev_snapshot_paths: List[str],
        mfpca_heatmap_path: Optional[str] = None,
        map_description: Optional[str] = None,
    ) -> Optional[ClusterInterpretation]:
        """Deprecated mega-YAML path — use split_analysis / complete_yaml_prompt."""
        raise RuntimeError(
            "analyze_cluster() mega-YAML path removed. "
            "Use: python -m llm_pipeline.cli cluster-interpret "
            "--products medoid,summary,ic-pairs"
        )

    def _load_prompt(self, filename: str) -> Optional[str]:
        """Load a prompt template file."""
        path = self.prompt_dir / filename
        try:
            return path.read_text(encoding="utf-8")
        except FileNotFoundError:
            print(f"❌ ERROR: Prompt file not found: {path}")
            return None

    def _prompt(self, key: str, filename: str) -> Optional[str]:
        """Return the UI override for *key* if provided, else the on-disk template."""
        override = self.prompt_overrides.get(key)
        if override:
            return override
        return self._load_prompt(filename)

    @staticmethod
    def _safe_format(template: str, **values: str) -> str:
        """Substitute ``{key}`` placeholders without str.format brace-sensitivity.

        User-edited prompts may contain stray ``{`` / ``}`` (e.g. YAML examples)
        that would make ``str.format`` raise; plain replacement avoids that.
        """
        out = template or ""
        for key, val in values.items():
            out = out.replace("{" + key + "}", str(val))
        return out
    
    @staticmethod
    def _fmt_metric(value, fmt: str, unit: str) -> str:
        """Format a numeric metric; use ``n/a`` when value is None or missing."""
        if value is None:
            return f"n/a {unit}".strip()
        try:
            return f"{fmt.format(float(value))} {unit}".strip()
        except (TypeError, ValueError):
            return f"n/a {unit}".strip()

    @staticmethod
    def _snapshot_label(path: str) -> str:
        """Human-readable timestamp+event label parsed from a snapshot filename.

        Snapshots are named like
        ``trial_795_t_20.95_ego_max_deceleration.jpg`` or
        ``trial_795_t_27.71_..._STOPPED.jpg``. The LLM only sees images, so we
        surface the encoded timestamp/event as text to anchor it temporally.
        """
        name = Path(path).name
        m = re.search(r"_t_(\d+(?:\.\d+)?)_(.+?)\.(?:jpe?g|png)$", name, re.I)
        if m:
            ts, event = m.group(1), m.group(2).replace("_", " ").strip()
            return f"t={ts}s — {event}"
        m2 = re.search(r"_t_(\d+(?:\.\d+)?)", name)
        if m2:
            return f"t={m2.group(1)}s"
        return name

    def _format_cluster_stats(self, stats: Dict) -> str:
        """Format cluster statistics for prompt."""
        n = stats.get("n_trials", 0)
        collision_rate = stats.get("collision_rate", 0.0) or 0.0
        param_ranges = stats.get("parameter_ranges", {}) or {}

        lines = [
            f"Number of trials: {n}",
            f"Collision rate (whole cluster): {float(collision_rate):.1f}%",
            f"Mean TTC: {self._fmt_metric(stats.get('mean_ttc'), '{:.2f}', 'seconds')}",
            f"Minimum TTC: {self._fmt_metric(stats.get('min_ttc'), '{:.2f}', 'seconds')}",
            f"Mean SPrET: {self._fmt_metric(stats.get('mean_spret'), '{:.2f}', 'meters')}",
        ]

        # Medoid (the trial shown in the BEV snapshots & action log) outcome.
        # collision_rate above is cluster-wide; this is the single trajectory
        # the snapshots actually depict, so the LLM must not conflate the two.
        medoid_collided = stats.get("medoid_collided")
        if medoid_collided is not None:
            outcome = "COLLISION" if medoid_collided else "no collision (near-miss/safe)"
            lines.append(f"Medoid trial outcome (shown in snapshots): {outcome}")
        crit = stats.get("medoid_critical_time")
        if crit is not None:
            lines.append(
                f"Medoid critical/closest-approach time: t={float(crit):.2f}s "
                "(describe the scenario through this moment)"
            )

        lines += ["", "Parameter ranges:"]

        if not param_ranges:
            lines.append("  (not available for this cluster)")
        for param, bounds in param_ranges.items():
            if not bounds or len(bounds) < 2:
                lines.append(f"  - {param}: n/a")
                continue
            min_val, max_val = bounds[0], bounds[1]
            lines.append(
                f"  - {param}: {self._fmt_metric(min_val, '{:.1f}', '')} to "
                f"{self._fmt_metric(max_val, '{:.1f}', '')}"
            )

        # Intra-cluster variance (Phase A data injected from cluster.json)
        iv = stats.get("intra_variance") or {}
        if iv:
            lines += ["", "Intra-cluster spread (MFPCA embedding space):"]
            lines.append(f"  mean_dist_to_centroid: {iv.get('mean_dist_to_medoid', 'n/a')}")
            lines.append(f"  std_dist_to_centroid:  {iv.get('std_dist_to_medoid', 'n/a')}")
            lines.append(f"  max_dist_to_centroid:  {iv.get('max_dist_to_medoid', 'n/a')}")
            outlier_ids = iv.get("outlier_trial_ids", [])
            outlier_coll = iv.get("outlier_collision", [])
            if outlier_ids:
                pairs = [
                    f"trial {tid} ({'COLLISION' if c else 'no collision'})"
                    for tid, c in zip(outlier_ids, outlier_coll)
                ]
                lines.append(f"  most_atypical_trials: {', '.join(pairs)}")

        # Outlier description text (if a full description was generated for the outlier)
        outlier_desc = stats.get("outlier_description")
        if outlier_desc:
            lines += [
                "",
                "Most atypical cluster member (outlier trial) action log:",
                outlier_desc,
            ]

        return "\n".join(lines)
    
    def _get_map_description(self) -> str:
        """Get or generate map description from OpenDRIVE."""
        # TODO: Implement proper OpenDRIVE parsing or load from cache
        # For now, return a placeholder for HCT intersection
        return """
Map: HCT (Hsinchu) Intersection

The scenario takes place at a T-intersection:
- Road 1 (North approach): Ego vehicle enters from north, turning left (west)
- Road 2 (South approach): Oncoming vehicle enters from south, going straight (north)
- Road 3 (West exit): Both ego and oncoming vehicles target the same exit

Intersection geometry:
- Conflict zone: Center of intersection where left-turn path crosses straight path
- No traffic lights (uncontrolled intersection)
- Multiple lanes on each approach (exact count varies by road)
"""
    
    def _encode_image(self, path: str) -> Optional[str]:
        """Encode image to base64 string."""
        try:
            with open(path, "rb") as f:
                return base64.b64encode(f.read()).decode("utf-8")
        except FileNotFoundError:
            print(f"⚠️  WARNING: Image not found: {path}")
            return None
    
    def _run_initial_analysis(
        self,
        system_prompt: str,
        common_sense: str,
        interaction_prompt: str,
        bev_images: List[str],
        bev_labels: Optional[List[str]],
        heatmap_image: Optional[str],
        map_description: str,
    ) -> tuple[Optional[str], Dict]:
        """Run initial LLM analysis pass."""
        bev_labels = bev_labels or []
        # Construct multi-modal message
        prompt_parts = [
            {"type": "text", "text": "### Traffic Safety Principles & Reference"},
            {"type": "text", "text": common_sense},
            {"type": "text", "text": "### Map Context"},
            {"type": "text", "text": map_description},
        ]
        if heatmap_image:
            prompt_parts.append(
                {"type": "text", "text": "\n### MFPCA Heatmap (Trajectory Variation)"}
            )
            prompt_parts.append(
                {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{heatmap_image}"}}
            )
        prompt_parts.append({
            "type": "text",
            "text": (
                "\n### BEV Snapshots (Medoid Trial)\n"
                "Each snapshot is labelled with its scenario timestamp and the key "
                "event at that moment. Snapshots are ordered chronologically — use "
                "the timestamps to anchor your ego_perspective_summary and make sure "
                "you describe the LATEST snapshots (the final outcome), not only the "
                "early ones."
            ),
        })
        
        for i, b64_img in enumerate(bev_images):
            label = bev_labels[i] if i < len(bev_labels) else f"Snapshot {i+1}"
            prompt_parts.append({"type": "text", "text": f"Snapshot {i+1} — {label}:"})
            prompt_parts.append({"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{b64_img}"}})
        
        prompt_parts.append({"type": "text", "text": f"\n{interaction_prompt}"})
        
        messages = [
            SystemMessage(content=system_prompt),
            HumanMessage(content=prompt_parts),
        ]
        
        # Call LLM
        try:
            response, tokens = self._invoke_messages(messages, timeout=180)
            analysis_result = self._response_to_text(response.content)
        except asyncio.TimeoutError:
            print("❌ ERROR: LLM response timed out after 180 seconds")
            return None, {}
        except Exception as e:
            print(f"❌ ERROR: LLM call failed: {e}")
            return None, {}
        
        extracted = self._extract_yaml_block(analysis_result)
        if not re.search(r"```(?:yaml|YAML)", analysis_result, re.I):
            print("⚠️  WARNING: No ```yaml fence in response; running YAML extraction follow-up...")
            extracted, extra_tokens = self._run_yaml_extraction_pass(
                messages, analysis_result
            )
            tokens = {k: tokens.get(k, 0) + extra_tokens.get(k, 0) for k in set(tokens) | set(extra_tokens)}
        return extracted, tokens
    
    def _run_yaml_extraction_pass(
        self,
        prior_messages: list,
        prior_analysis: str,
    ) -> tuple[Optional[str], Dict]:
        """Pass 3 (fallback): model produced CoT but no YAML fence.

        Send a brief follow-up in the same conversation asking the model to
        emit only the final YAML block.  This is cheap (no images) and is
        highly reliable for models that output prose instead of a fenced block.
        """
        follow_up_text = (
            "Your analysis above is excellent. "
            "Now please output ONLY the final YAML report as a single fenced "
            "```yaml ... ``` code block — no additional prose, no Chain of Thought. "
            "Use exactly the schema specified in the Final Output Instructions, "
            "including all required top-level keys "
            "(cluster_id, cluster_label, confidence, behavior_description, "
            "safety_assessment, parameter_conditions, ego_perspective_summary). "
            "The ego_perspective_summary MUST have 10-15 timestamped events "
            "spanning the FULL scenario timeline."
        )
        messages_ext = list(prior_messages) + [
            {"role": "assistant", "content": prior_analysis},
            HumanMessage(content=follow_up_text),
        ]
        try:
            response, tokens = self._invoke_messages(messages_ext, timeout=120)
            follow_text = self._response_to_text(response.content)
            extracted = self._extract_yaml_block(follow_text)
            if re.search(r"```(?:yaml|YAML)", follow_text, re.I):
                print("✅ YAML extraction follow-up succeeded")
            else:
                print("⚠️  WARNING: YAML extraction follow-up also produced no fence; best-effort")
            return extracted, tokens
        except Exception as e:
            print(f"❌ ERROR: YAML extraction follow-up failed: {e}")
            return self._extract_yaml_block(prior_analysis), {}

    def _run_reviewer_pass(
        self,
        stats_text: str,
        medoid_action_log: str,
        preliminary_yaml: str,
        reviewer_prompt_template: str,
    ) -> tuple[Optional[str], Dict]:
        """Run reviewer verification pass."""
        # Use the passed-in template (which already honours UI overrides) for the
        # system part too, instead of re-reading the file from disk.
        reviewer_system = (reviewer_prompt_template or "").split("<Your Task>")[0]
        reviewer_prompt = self._safe_format(
            reviewer_prompt_template,
            cluster_stats=stats_text,
            agent_actions_log=medoid_action_log,
            preliminary_yaml=preliminary_yaml,
        )
        
        messages = [
            SystemMessage(content=reviewer_system),
            HumanMessage(content=reviewer_prompt),
        ]
        
        try:
            response, tokens = self._invoke_messages(messages, timeout=120)
            review_result = self._response_to_text(response.content)
        except asyncio.TimeoutError:
            print("❌ ERROR: Reviewer LLM response timed out")
            return None, {}
        except Exception as e:
            print(f"❌ ERROR: Reviewer LLM call failed: {e}")
            return None, {}
        
        return self._extract_yaml_block(review_result), tokens

    @staticmethod
    def _extract_yaml_block(text: str) -> str:
        """Pull YAML from a fenced block or from bare report keys.

        Models often emit a long Chain-of-Thought before the YAML, sometimes in
        a ``yaml``/``yml``/un-tagged fence and sometimes unfenced. Strategy:
        1. Prefer the **last** fenced block that looks like a report
           (cluster_* / trial_id / clusters:); else the last fence.
        2. Otherwise slice from the first top-level report key.
        """
        text = (text or "").strip()
        if not text:
            return ""

        fences = [
            f.strip()
            for f in re.findall(r"```(?:ya?ml)?\s*([\s\S]*?)```", text, re.IGNORECASE)
            if f.strip()
        ]
        report_markers = (
            "cluster_label:",
            "cluster_id:",
            "trial_id:",
            "clusters:",
            "param_dist:",
            "motive_summary:",
            "contrast_explanation:",
            "numeric_digest_ref:",
        )
        if fences:
            yaml_like = [
                f for f in fences if any(m in f for m in report_markers)
            ]
            return (yaml_like or fences)[-1]

        m = re.search(
            r"(?m)^\s*(?:cluster_id|cluster_label|trial_id|clusters|param_dist)\s*:",
            text,
        )
        if m:
            return text[m.start() :].strip()
        # Last-ditch: strip a leading fence if present
        if text.startswith("```"):
            inner = re.sub(r"^```(?:ya?ml)?\s*", "", text, flags=re.I)
            inner = re.sub(r"\s*```\s*$", "", inner)
            return inner.strip()
        return text

    def _parse_interpretation_yaml(self, raw: str) -> Optional[Dict]:
        """Parse cluster interpretation YAML with a second-chance extractor."""
        for candidate in (raw, self._extract_yaml_block(raw)):
            if not candidate:
                continue
            parsed = self._safe_load_yaml_dict(candidate)
            if parsed is not None:
                return parsed
        print(f"❌ ERROR: Failed to parse final YAML (first 120 chars): {raw[:120]!r}")
        return None

    @staticmethod
    def _safe_load_yaml_dict(text: str) -> Optional[Dict]:
        """Load YAML dict; on truncation errors, drop incomplete trailing lines."""
        if not text or not text.strip():
            return None
        body = text.strip()
        # Drop an unclosed leading fence remnant
        if body.startswith("```"):
            body = re.sub(r"^```(?:ya?ml)?\s*", "", body, flags=re.I)
            body = re.sub(r"\s*```\s*$", "", body)
        attempts = [body]
        # Progressive repair for cut-off generations
        lines = body.splitlines()
        while lines:
            # Drop obviously incomplete last line (unclosed quote / mid-scalar)
            last = lines[-1].rstrip()
            if (
                last.count('"') % 2 == 1
                or last.count("'") % 2 == 1
                or last.endswith((":", "-", ",", ">", "|"))
                or (last.lstrip().startswith("- ") and len(last.strip()) < 4)
            ):
                lines = lines[:-1]
                attempts.append("\n".join(lines))
                continue
            break
        # Also try chopping from the end a few times
        for n in range(1, min(12, len(lines))):
            attempts.append("\n".join(lines[:-n]))
        seen = set()
        for cand in attempts:
            if not cand or cand in seen:
                continue
            seen.add(cand)
            try:
                parsed = yaml.safe_load(cand)
                if isinstance(parsed, dict) and parsed:
                    return parsed
            except yaml.YAMLError:
                continue
        return None

    def _ensure_loop(self) -> asyncio.AbstractEventLoop:
        if self._loop is None or self._loop.is_closed():
            self._loop = asyncio.new_event_loop()
            asyncio.set_event_loop(self._loop)
        return self._loop

    def _run_async(self, coro):
        return self._ensure_loop().run_until_complete(coro)

    @staticmethod
    def _response_to_text(content) -> str:
        if content is None:
            return ""
        if isinstance(content, str):
            return content
        if isinstance(content, list):
            parts = []
            for block in content:
                if isinstance(block, str):
                    parts.append(block)
                elif isinstance(block, dict):
                    parts.append(block.get("text") or block.get("content") or "")
                else:
                    parts.append(getattr(block, "text", None) or str(block))
            return "".join(str(p) for p in parts if p)
        return str(content)

    def _invoke_messages(self, messages, timeout: int = 180):
        """Invoke LLM with timeout; return (response, token_usage dict)."""
        async def _run():
            return await self.llm.ainvoke(messages)

        if is_gemini_model(self.model):
            response = self._run_async(asyncio.wait_for(_run(), timeout=timeout))
            meta = getattr(response, "usage_metadata", None) or {}
            tokens = {
                "Prompt": int(meta.get("input_tokens", 0) or 0),
                "Completion": int(meta.get("output_tokens", 0) or 0),
                "Total": int(meta.get("total_tokens", 0) or 0),
            }
            return response, tokens

        with get_openai_callback() as cb:
            response = self._run_async(asyncio.wait_for(_run(), timeout=timeout))
            return response, {
                "Prompt": cb.prompt_tokens,
                "Completion": cb.completion_tokens,
                "Total": cb.total_tokens,
            }

    async def _async_invoke_llm(self, llm, messages):
        """Async wrapper for LLM invocation."""
        return await llm.ainvoke(messages)

    def complete_yaml_prompt(
        self,
        user_prompt: str,
        *,
        system_prompt: Optional[str] = None,
        bev_snapshot_paths: Optional[List[str]] = None,
        section_title: str = "BEV Snapshots",
    ) -> tuple[Optional[str], Dict, Optional[Dict]]:
        """Single multimodal/text call → YAML string + tokens + parsed dict."""
        system = system_prompt or (
            "You are an expert AV safety analyst. Follow the task exactly. "
            "End with a single ```yaml fenced block matching the required schema."
        )
        bev_snapshot_paths = bev_snapshot_paths or []
        parts: List[Dict] = [{"type": "text", "text": user_prompt}]
        if bev_snapshot_paths:
            parts.append({"type": "text", "text": f"\n### {section_title}"})
            for p in bev_snapshot_paths:
                img = self._encode_image(p)
                if not img:
                    continue
                parts.append({"type": "text", "text": self._snapshot_label(p)})
                mime = "image/png" if p.lower().endswith(".png") else "image/jpeg"
                parts.append({
                    "type": "image_url",
                    "image_url": {"url": f"data:{mime};base64,{img}"},
                })
        messages = [
            SystemMessage(content=system),
            HumanMessage(content=parts),
        ]
        try:
            response, tokens = self._invoke_messages(messages, timeout=180)
            text = self._response_to_text(response.content)
        except Exception as e:
            print(f"❌ ERROR: complete_yaml_prompt failed: {e}")
            return None, {}, None
        raw = self._extract_yaml_block(text)
        if not (raw and (":" in raw)):
            ext, ext_tok = self._run_yaml_extraction_pass(messages, text)
            for k, v in (ext_tok or {}).items():
                tokens[k] = tokens.get(k, 0) + int(v or 0)
            raw = ext or raw
        parsed = self._parse_interpretation_yaml(raw) if raw else None
        return raw, tokens, parsed


# Example usage
if __name__ == "__main__":
    # Demo: analyze cluster 1
    interpreter = ClusterInterpreter(model="gpt-4o")
    
    result = interpreter.analyze_cluster(
        cluster_id=1,
        cluster_stats={
            "n_trials": 127,
            "collision_rate": 2.4,
            "mean_ttc": 2.8,
            "min_ttc": 0.9,
            "mean_spret": 12.5,
            "parameter_ranges": {
                "oncoming_speed": [50.0, 70.0],
                "start_delay": [0.5, 2.0],
            },
        },
        medoid_trial_id="5951",
        medoid_action_log="""
Time=0.0s: Ego approaches intersection
Time=1.5s: Ego detects oncoming vehicle
Time=2.2s: Ego begins moderate deceleration
Time=4.0s: Ego reaches near-stop (speed < 1 m/s)
Time=5.5s: Ego accelerates after oncoming vehicle clears
""",
        bev_snapshot_paths=[
            "bev_output/dataset1/3clusters/cluster_1/trial_5951_frame_000.jpg",
            "bev_output/dataset1/3clusters/cluster_1/trial_5951_frame_001.jpg",
            "bev_output/dataset1/3clusters/cluster_1/trial_5951_frame_002.jpg",
        ],
        mfpca_heatmap_path="alldatasets/dataset1/mfpca_heatmap_cluster1.png",
    )
    
    if result:
        print(f"\n{'='*60}")
        print(f"Cluster {result.cluster_id}: {result.cluster_label}")
        print(f"{'='*60}")
        print(result.raw_yaml)
