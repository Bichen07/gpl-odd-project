"""
cluster_interpreter.py — Phase 5: LLM-based Cluster Interpretation

Orchestrates the LLM pipeline for characterizing behavioral clusters:
1. Loads cluster statistics, medoid trial data, BEV snapshots, MFPCA heatmap
2. Constructs multi-modal prompts (text + images)
3. Calls LLM with reflection/review pass
4. Returns structured YAML describing cluster behavior and safety

Adapted from xosc_gen/models/scenario_interpretation.py for cluster analysis.

Usage:
    from cluster_interpreter import ClusterInterpreter
    
    interpreter = ClusterInterpreter(
        model="gpt-4o",
        xodr_path="alldatasets/resources/xodr/hct_6.xodr"
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

from langchain_community.callbacks.manager import get_openai_callback
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_openai import ChatOpenAI


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
        model: OpenAI model ID (default "gpt-4o")
        xodr_path: Path to OpenDRIVE map file (for map description)
        temperature: LLM temperature (default 0.1 for consistency)
        prompt_dir: Directory containing prompt templates
    """
    
    def __init__(
        self,
        model: str = "gpt-4o",
        xodr_path: Optional[str] = None,
        temperature: float = 0.1,
        prompt_dir: str = "app/llm_pipeline/prompt_templates",
    ):
        self.model = model
        self.temperature = temperature
        self.prompt_dir = Path(prompt_dir)
        self.xodr_path = xodr_path
        
        # Initialize LLM
        self.llm = ChatOpenAI(
            model=model,
            temperature=temperature,
            max_tokens=4096,
        )
        
        print(f"[ClusterInterpreter] Initialized with model={model}, temp={temperature}")
    
    def analyze_cluster(
        self,
        cluster_id: int,
        cluster_stats: Dict,
        medoid_trial_id: str,
        medoid_action_log: str,
        bev_snapshot_paths: List[str],
        mfpca_heatmap_path: str,
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
        
        # Load prompts
        system_prompt = self._load_prompt("cluster_system_prompt.txt")
        common_sense = self._load_prompt("cluster_common_sense.txt")
        interaction_prompt_template = self._load_prompt("cluster_interaction_prompt.txt")
        reviewer_prompt_template = self._load_prompt("cluster_reviewer_prompt.txt")
        
        if not all([system_prompt, common_sense, interaction_prompt_template]):
            print("❌ ERROR: Failed to load prompt templates")
            return None
        
        # Format cluster statistics
        stats_text = self._format_cluster_stats(cluster_stats)
        
        # Get map description
        if map_description is None:
            map_description = self._get_map_description()
        
        # Format main prompt
        interaction_prompt = interaction_prompt_template.format(
            cluster_stats=stats_text,
            agent_actions_log=medoid_action_log,
            map_description=map_description,
        )
        
        # Encode images
        print(f"[ClusterInterpreter] Encoding {len(bev_snapshot_paths)} BEV snapshots + MFPCA heatmap...")
        bev_images = [self._encode_image(p) for p in bev_snapshot_paths]
        heatmap_image = self._encode_image(mfpca_heatmap_path)
        
        if not all(bev_images) or not heatmap_image:
            print("❌ ERROR: Failed to encode images")
            return None
        
        # --- PASS 1: Initial analysis ---
        print("[ClusterInterpreter] Pass 1: Initial cluster analysis...")
        initial_yaml, initial_tokens = self._run_initial_analysis(
            system_prompt=system_prompt,
            common_sense=common_sense,
            interaction_prompt=interaction_prompt,
            bev_images=bev_images,
            heatmap_image=heatmap_image,
            map_description=map_description,
        )
        
        if not initial_yaml:
            print("❌ ERROR: Initial analysis failed")
            return None
        
        print(f"✅ Initial analysis complete: {initial_tokens['Total']} tokens")
        
        # --- PASS 2: Reviewer verification ---
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
        
        # Parse YAML
        try:
            parsed = yaml.safe_load(final_yaml)
        except yaml.YAMLError as e:
            print(f"❌ ERROR: Failed to parse final YAML: {e}")
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
    
    def _format_cluster_stats(self, stats: Dict) -> str:
        """Format cluster statistics for prompt."""
        n = stats.get("n_trials", 0)
        collision_rate = stats.get("collision_rate", 0.0)
        mean_ttc = stats.get("mean_ttc", 0.0)
        min_ttc = stats.get("min_ttc", 0.0)
        mean_spret = stats.get("mean_spret", 0.0)
        param_ranges = stats.get("parameter_ranges", {})
        
        lines = [
            f"Number of trials: {n}",
            f"Collision rate: {collision_rate:.1f}%",
            f"Mean TTC: {mean_ttc:.2f} seconds",
            f"Minimum TTC: {min_ttc:.2f} seconds",
            f"Mean SPrET: {mean_spret:.2f} meters",
            "",
            "Parameter ranges:",
        ]
        
        for param, (min_val, max_val) in param_ranges.items():
            lines.append(f"  - {param}: {min_val:.1f} to {max_val:.1f}")
        
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
        heatmap_image: str,
        map_description: str,
    ) -> tuple[Optional[str], Dict]:
        """Run initial LLM analysis pass."""
        # Construct multi-modal message
        prompt_parts = [
            {"type": "text", "text": "### Traffic Safety Principles & Reference"},
            {"type": "text", "text": common_sense},
            {"type": "text", "text": "### Map Context"},
            {"type": "text", "text": map_description},
            {"type": "text", "text": "\n### MFPCA Heatmap (Trajectory Variation)"},
            {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{heatmap_image}"}},
            {"type": "text", "text": "\n### BEV Snapshots (Medoid Trial)"},
        ]
        
        for i, b64_img in enumerate(bev_images):
            prompt_parts.append({"type": "text", "text": f"Snapshot {i+1}:"})
            prompt_parts.append({"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{b64_img}"}})
        
        prompt_parts.append({"type": "text", "text": f"\n{interaction_prompt}"})
        
        messages = [
            SystemMessage(content=system_prompt),
            HumanMessage(content=prompt_parts),
        ]
        
        # Call LLM
        try:
            with get_openai_callback() as cb:
                response = asyncio.run(asyncio.wait_for(
                    self._async_invoke_llm(self.llm, messages),
                    timeout=180
                ))
                analysis_result = response.content
                tokens = {
                    "Prompt": cb.prompt_tokens,
                    "Completion": cb.completion_tokens,
                    "Total": cb.total_tokens,
                }
        except asyncio.TimeoutError:
            print("❌ ERROR: LLM response timed out after 180 seconds")
            return None, {}
        except Exception as e:
            print(f"❌ ERROR: LLM call failed: {e}")
            return None, {}
        
        # Extract YAML from markdown code block
        yaml_match = re.search(r"```yaml\s*([\s\S]*?)\s*```", analysis_result)
        if yaml_match:
            return yaml_match.group(1).strip(), tokens
        else:
            print("⚠️  WARNING: No YAML block found in response, using raw output")
            return analysis_result.strip(), tokens
    
    def _run_reviewer_pass(
        self,
        stats_text: str,
        medoid_action_log: str,
        preliminary_yaml: str,
        reviewer_prompt_template: str,
    ) -> tuple[Optional[str], Dict]:
        """Run reviewer verification pass."""
        reviewer_system = self._load_prompt("cluster_reviewer_prompt.txt").split("<Your Task>")[0]
        reviewer_prompt = reviewer_prompt_template.format(
            cluster_stats=stats_text,
            agent_actions_log=medoid_action_log,
            preliminary_yaml=preliminary_yaml,
        )
        
        messages = [
            SystemMessage(content=reviewer_system),
            HumanMessage(content=reviewer_prompt),
        ]
        
        try:
            with get_openai_callback() as cb:
                response = asyncio.run(asyncio.wait_for(
                    self._async_invoke_llm(self.llm, messages),
                    timeout=120
                ))
                review_result = response.content
                tokens = {
                    "Prompt": cb.prompt_tokens,
                    "Completion": cb.completion_tokens,
                    "Total": cb.total_tokens,
                }
        except asyncio.TimeoutError:
            print("❌ ERROR: Reviewer LLM response timed out")
            return None, {}
        except Exception as e:
            print(f"❌ ERROR: Reviewer LLM call failed: {e}")
            return None, {}
        
        # Extract YAML
        yaml_match = re.search(r"```yaml\s*([\s\S]*?)\s*```", review_result)
        if yaml_match:
            return yaml_match.group(1).strip(), tokens
        else:
            return review_result.strip(), tokens
    
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
