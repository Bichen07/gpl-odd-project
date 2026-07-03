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
        """
        Run LLM analysis on a single cluster.
        
        Args:
            cluster_id: Cluster label (e.g., 0, 1, 2)
            cluster_stats: Dict with keys:
                - n_trials: int
                - collision_rate: float (0-100)
                - mean_ttc: float
                - min_ttc: float
                - mean_spret: float
                - parameter_ranges: Dict (e.g., {"oncoming_speed": [50, 70]})
            medoid_trial_id: Trial ID of cluster medoid
            medoid_action_log: Formatted action log string for medoid trial
            bev_snapshot_paths: List of BEV image paths (JPG)
            mfpca_heatmap_path: Path to MFPCA heatmap image (PNG)
            map_description: Optional map description text
        
        Returns:
            ClusterInterpretation or None if analysis fails
        """
        print(f"\n{'='*60}")
        print(f"[ClusterInterpreter] Analyzing Cluster {cluster_id}")
        print(f"[ClusterInterpreter] Medoid trial: {medoid_trial_id}")
        print(f"{'='*60}")
        
        # Load prompts (UI override wins over the on-disk template)
        system_prompt = self._prompt("system", "cluster_system_prompt.txt")
        common_sense = self._prompt("common_sense", "cluster_common_sense.txt")
        interaction_prompt_template = self._prompt("interaction", "cluster_interaction_prompt.txt")
        reviewer_prompt_template = self._prompt("reviewer", "cluster_reviewer_prompt.txt")
        
        if not all([system_prompt, common_sense, interaction_prompt_template]):
            print("❌ ERROR: Failed to load prompt templates")
            return None
        
        # Format cluster statistics
        stats_text = self._format_cluster_stats(cluster_stats)
        
        # Get map description
        if map_description is None:
            map_description = self._get_map_description()
        
        # Format main prompt (tolerant of user-edited prompts with stray braces)
        interaction_prompt = self._safe_format(
            interaction_prompt_template,
            cluster_stats=stats_text,
            agent_actions_log=medoid_action_log,
            map_description=map_description,
        )
        
        # Encode images. The MFPCA heatmap is OPTIONAL — if no genuine
        # trajectory-variation image exists we omit it rather than feeding a
        # duplicate BEV frame mislabeled as a heatmap.
        bev_images = [self._encode_image(p) for p in bev_snapshot_paths]
        heatmap_image = self._encode_image(mfpca_heatmap_path) if mfpca_heatmap_path else None
        print(
            f"[ClusterInterpreter] Encoding {len(bev_snapshot_paths)} BEV snapshots"
            + (" + variation heatmap..." if heatmap_image else " (no heatmap)...")
        )

        if not all(bev_images):
            print("❌ ERROR: Failed to encode BEV images")
            return None
        
        # --- PASS 1: Initial analysis ---
        print("[ClusterInterpreter] Pass 1: Initial cluster analysis...")
        bev_labels = [self._snapshot_label(p) for p in bev_snapshot_paths]
        initial_yaml, initial_tokens = self._run_initial_analysis(
            system_prompt=system_prompt,
            common_sense=common_sense,
            interaction_prompt=interaction_prompt,
            bev_images=bev_images,
            bev_labels=bev_labels,
            heatmap_image=heatmap_image,
            map_description=map_description,
        )
        
        if not initial_yaml:
            print("❌ ERROR: Initial analysis failed")
            return None
        
        print(f"✅ Initial analysis complete: {initial_tokens['Total']} tokens")
        
        # --- PASS 2: Reviewer verification (optional) ---
        review_tokens = {"Prompt": 0, "Completion": 0, "Total": 0}
        if not self.do_review:
            print("[ClusterInterpreter] Review pass disabled — using initial analysis")
            final_yaml = initial_yaml
        else:
            print("[ClusterInterpreter] Pass 2: Reviewer verification...")
            final_yaml, review_tokens = self._run_reviewer_pass(
                stats_text=stats_text,
                medoid_action_log=medoid_action_log,
                preliminary_yaml=initial_yaml,
                reviewer_prompt_template=reviewer_prompt_template,
            )
            if not final_yaml:
                print("⚠️  WARNING: Reviewer pass failed, using initial analysis")
                final_yaml = initial_yaml
                review_tokens = {"Prompt": 0, "Completion": 0, "Total": 0}
            else:
                print(f"✅ Reviewer pass complete: {review_tokens['Total']} tokens")
        
        # Parse YAML (tolerate prose wrapper or missing ```yaml fence).
        # The reviewer (Pass 2) frequently returns a long Chain-of-Thought audit
        # and omits / truncates the final ```yaml block. In that case fall back
        # to the Pass-1 baseline rather than discarding a good analysis.
        parsed = self._parse_interpretation_yaml(final_yaml)
        if parsed is None and self.do_review and final_yaml is not initial_yaml:
            print(
                "⚠️  WARNING: Reviewer output was not valid YAML — "
                "falling back to Pass 1 baseline analysis"
            )
            parsed = self._parse_interpretation_yaml(initial_yaml)
            if parsed is not None:
                final_yaml = initial_yaml
        if parsed is None:
            return None
        
        # Total token usage
        total_tokens = {
            "Prompt": initial_tokens["Prompt"] + review_tokens["Prompt"],
            "Completion": initial_tokens["Completion"] + review_tokens["Completion"],
            "Total": initial_tokens["Total"] + review_tokens["Total"],
        }
        
        result = ClusterInterpretation(
            cluster_id=cluster_id,
            cluster_label=parsed.get("cluster_label", "Unknown"),
            confidence=parsed.get("confidence", "medium"),
            behavior_description=parsed.get("behavior_description", ""),
            safety_assessment=parsed.get("safety_assessment", {}),
            parameter_conditions=parsed.get("parameter_conditions", {}),
            ego_perspective_summary=parsed.get("ego_perspective_summary", []),
            raw_yaml=final_yaml,
            token_usage=total_tokens,
        )
        
        print(f"\n[ClusterInterpreter] ✅ Analysis complete for Cluster {cluster_id}")
        print(f"    Label: \"{result.cluster_label}\"")
        print(f"    Confidence: {result.confidence}")
        print(f"    Total tokens: {total_tokens['Total']}")
        
        return result
    
    # ------------------------------------------------------------------
    # Private helpers
    # ------------------------------------------------------------------
    
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
            print("⚠️  WARNING: No ```yaml fence in response; extracted best-effort YAML")
        return extracted, tokens
    
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
        """Pull YAML from a fenced block or from bare cluster_* keys.

        Models often emit a long Chain-of-Thought before the YAML, sometimes in
        a ``yaml``/``yml``/un-tagged fence and sometimes unfenced. Strategy:
        1. Prefer the **last** fenced block that looks like the report
           (contains ``cluster_label:``/``cluster_id:``); else the last fence.
        2. Otherwise slice from the **first** top-level ``cluster_id:`` /
           ``cluster_label:`` line (column 0) to the end.
        """
        text = (text or "").strip()
        if not text:
            return ""

        fences = [
            f.strip()
            for f in re.findall(r"```(?:ya?ml)?\s*([\s\S]*?)```", text, re.IGNORECASE)
            if f.strip()
        ]
        if fences:
            yaml_like = [
                f for f in fences if ("cluster_label:" in f or "cluster_id:" in f)
            ]
            return (yaml_like or fences)[-1]

        m = re.search(r"(?m)^\s*(?:cluster_id|cluster_label)\s*:", text)
        if m:
            return text[m.start() :].strip()
        return text

    def _parse_interpretation_yaml(self, raw: str) -> Optional[Dict]:
        """Parse cluster interpretation YAML with a second-chance extractor."""
        for candidate in (raw, self._extract_yaml_block(raw)):
            if not candidate:
                continue
            try:
                parsed = yaml.safe_load(candidate)
                if isinstance(parsed, dict):
                    return parsed
            except yaml.YAMLError:
                continue
        print(f"❌ ERROR: Failed to parse final YAML (first 120 chars): {raw[:120]!r}")
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
