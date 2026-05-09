# Phase 5: LLM Cluster Interpretation — Implementation Guide

## Overview

Phase 5 implements the LLM-based pipeline for automatically characterizing behavioral clusters from simulation data. This is adapted from `xosc_gen`'s interaction detection prompts but focused on cluster-level pattern recognition.

---

## What Was Created

### 1. Prompt Templates (`prompt_templates/`)

| File | Purpose |
|------|---------|
| `cluster_system_prompt.txt` | System role definition for LLM |
| `cluster_interaction_prompt.txt` | Main analysis task with Chain-of-Thought workflow |
| `cluster_reviewer_prompt.txt` | Verification/reflection pass |
| `cluster_common_sense.txt` | Traffic safety principles and behavioral taxonomy |

### 2. Core Module (`src/cluster_interpreter.py`)

**Class:** `ClusterInterpreter`

**Key Method:** `analyze_cluster()`

**Input:**
- Cluster statistics (n_trials, collision_rate, TTC, SPrET, parameter ranges)
- Medoid trial action log (timestamped maneuvers)
- BEV snapshot paths (JPEG images)
- MFPCA heatmap path (PNG image)
- Map description

**Output:** `ClusterInterpretation` dataclass with:
- `cluster_label`: Short name (e.g., "Proactive Yield")
- `behavior_description`: 2-3 sentence explanation
- `safety_assessment`: Risk level, failure mode, collision rate
- `parameter_conditions`: Trigger/safe/risky parameter ranges
- `ego_perspective_summary`: Key events from ego's viewpoint
- `raw_yaml`: Full YAML string
- `token_usage`: OpenAI token counts

---

## How It Works

### Two-Pass Architecture (adapted from xosc_gen)

#### Pass 1: Initial Analysis
1. Load all context: cluster stats, action log, BEV snapshots, MFPCA heatmap
2. Construct multi-modal prompt (text + images)
3. LLM performs step-by-step Chain-of-Thought reasoning
4. Outputs YAML describing cluster behavior

#### Pass 2: Reviewer Verification
1. Takes preliminary YAML from Pass 1
2. Cross-checks every claim against ground-truth data
3. Corrects errors (wrong metrics, unsupported claims, hallucinations)
4. Outputs final, verified YAML

### Chain-of-Thought Workflow (Pass 1)

The LLM is guided through 6 mandatory steps:

1. **Examine Cluster Statistics** → Understand collision rate, TTC, parameters
2. **Analyze Representative Behavior** → Study medoid trial's actions and BEV snapshots
3. **Identify Behavioral Pattern** → Name the cluster's defining strategy
4. **Safety Assessment** → Diagnose failure modes and collision triggers
5. **Parameter Conditions** → Define safe vs. risky parameter ranges
6. **Ego-Perspective Summary** → List 2-4 key events with timestamps

---

## Example Usage

### Standalone Script

```python
from cluster_interpreter import ClusterInterpreter

interpreter = ClusterInterpreter(
    model="gpt-4o",
    xodr_path="alldatasets/resources/xodr/hct_6.xodr",
    temperature=0.1,
)

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
    print(f"Cluster {result.cluster_id}: {result.cluster_label}")
    print(f"Confidence: {result.confidence}")
    print(f"\nBehavior:\n{result.behavior_description}")
    print(f"\nRisk Level: {result.safety_assessment['risk_level']}")
    print(f"Collision Rate: {result.safety_assessment['collision_rate']}")
```

### Integration with analyzer.py (Phase 6)

```python
# In app/analyzer/src/controller.py, after clustering() completes:

from app.llm_pipeline.src.cluster_interpreter import ClusterInterpreter

interpreter = ClusterInterpreter(model="gpt-4o")

for cluster_id, medoid_trial_id in cluster_medoids.items():
    # Get cluster statistics from MFPCA result
    cluster_stats = compute_cluster_statistics(cluster_id, mfpca_result)
    
    # Get medoid action log from SimLabeller
    action_log = generate_action_log(medoid_trial_id)
    
    # Get BEV snapshots (already generated in Phase 3)
    bev_paths = glob(f"bev_output/dataset1/cluster_{cluster_id}/*.jpg")
    
    # Get MFPCA heatmap (already exists)
    heatmap_path = f"alldatasets/dataset1/mfpca_heatmap_cluster{cluster_id}.png"
    
    # Run analysis
    interpretation = interpreter.analyze_cluster(
        cluster_id=cluster_id,
        cluster_stats=cluster_stats,
        medoid_trial_id=medoid_trial_id,
        medoid_action_log=action_log,
        bev_snapshot_paths=bev_paths,
        mfpca_heatmap_path=heatmap_path,
    )
    
    # Save to Payload
    save_cluster_interpretation(interpretation)
```

---

## Prompt Engineering Notes

### Key Differences from xosc_gen

| Aspect | xosc_gen | Phase 5 (gpl-odd) |
|--------|----------|-------------------|
| **Goal** | Detect pairwise interactions | Characterize cluster patterns |
| **Input Scale** | Single trial | Cluster of trials (medoid representative) |
| **Output** | List of interactions with partner agents | Cluster label + behavior description |
| **Safety Focus** | Interaction types (YCP, DK, P) | Failure modes + parameter sensitivity |
| **New Context** | N/A | Cluster statistics + MFPCA heatmap |

### Prompt Design Principles

1. **Chain-of-Thought (CoT) is mandatory**: Forces systematic reasoning, reduces hallucinations
2. **Multi-modal evidence**: Text (action log) + Images (BEV + heatmap) + Stats
3. **Reflection pass**: Reviewer catches errors before final output
4. **YAML output format**: Structured, machine-parseable
5. **Ego-centric perspective**: Focuses on ego's decision-making process

---

## Token Usage Estimates

Based on xosc_gen experience:

- **Pass 1 (Initial analysis):** ~10,000-15,000 tokens
  - Prompt: ~8,000 (includes 3-5 BEV images + heatmap)
  - Completion: ~2,000-5,000 (Chain-of-Thought + YAML)

- **Pass 2 (Reviewer):** ~5,000-8,000 tokens
  - Prompt: ~3,000 (preliminary YAML + action log)
  - Completion: ~2,000-5,000 (corrections + final YAML)

**Total per cluster:** ~15,000-23,000 tokens (~$0.20-$0.35 with GPT-4o pricing)

For 3 clusters: ~$0.60-$1.05 per batch

---

## Testing

### Unit Test (TODO for Phase 6)

```python
# tests/test_cluster_interpreter.py

def test_cluster_interpretation_format():
    """Test that output YAML has required fields."""
    interpreter = ClusterInterpreter()
    result = interpreter.analyze_cluster(...)
    
    assert result.cluster_label
    assert result.confidence in ["low", "medium", "high"]
    assert result.behavior_description
    assert "risk_level" in result.safety_assessment
    assert "collision_rate" in result.safety_assessment
    assert len(result.ego_perspective_summary) >= 2
```

### Manual Validation

1. Run on dataset1 cluster 1 (known "proactive yield" pattern)
2. Check if LLM correctly identifies:
   - Early deceleration (t=2-3s)
   - Low collision rate
   - Parameter sensitivity (oncoming speed threshold)
3. Verify YAML is valid and parseable

---

## Next Steps (Phase 6)

1. **Create `compute_cluster_statistics()` helper** to extract stats from MFPCA result
2. **Integrate with `controller.py`** to run after clustering completes
3. **Save interpretations to Payload** as Document uploads
4. **Update dashboard** to display cluster labels alongside heatmaps
5. **Add CLI command:** `python -m app.llm_pipeline.cli cluster-interpret --batch-id 1`

---

## References

- **xosc_gen source:** `xosc_gen/models/scenario_interpretation.py`
- **Prompt templates:** `xosc_gen/memos/interaction_prompt.txt`, `system_prompt_reviewer.txt`
- **Integration plan:** `cluster_interpreter_integration_plan.md` Phase 5 section
