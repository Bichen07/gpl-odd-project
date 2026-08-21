# AI Implementation Blueprint & Technical Architecture

## High-Level Summary
The system provides a deterministic, auditable pipeline for discovering and explaining candidate safety/behavioral frontiers in scenario parameter space without circular dependency on LLM assertions. The overall workflow adheres strictly to the frozen medoid and pair analysis contracts while adding aggregation, boundary extraction, parameter rules, and grounded discussion.

---

## Current Architecture & State

### 1. Data Integrity & Provenance Rules
- **Provenance Separation**: Raw scenario telemetry and deterministic analyzer outputs (provenances A and B) form the source of truth for numeric metrics, collision rates, and parameter ranges.
- **LLM Decoupling**: LLM narrative summaries and contrast explanations (provenances C and D) provide behavioral interpretation and are strictly consumed as-is without inventing metrics.
- **No Refactor of Frozen Layers**: Medoid trial analysis, parameter-space pair analysis, and common-sense dictionaries remain unmodified.

### 2. Delivered Components
- **Cluster Summary Verification (S0)**: Validated existing cluster and pair artifacts on benchmark runs.
- **Run Report DTO & API (S1)**: Created `GET /api/cluster-run-report` to aggregate run statistics, cluster risk rankings, medoid motives, pair outcome flips, and clustering quality indicators into a single payload.
- **Run Report UI (S1)**: Integrated the 4th tab in [AnalyzeClient.tsx](file:///home/carlos11/Downloads/code/LAB/gpl-odd-project/app/dashboard/src/app/batch/[id]/analyze/AnalyzeClient.tsx) presenting:
  - Header with run metadata and quality/selection scores.
  - Risk table sorted by collision rate with navigation to cluster views.
  - Behavioral failure mode distribution based on medoid motives.
  - Matched-parameter pair contrast evidence with outcome flip indicators.
  - Clustering quality and merge/split recommendations.
  - Automated next test recommendations based on unanalyzed failure regions.

---

## Upcoming Implementation Roadmap

### S2 — Boundary Export
- Implement deterministic kNN boundary extraction across scenario parameter space matching existing filter semantics.
- Output structured `odd_boundary_export.json` containing boundary trial IDs, parameter coordinates, and pass/fail edge transitions.

### S3 — Parameter Rule Extraction
- Train shallow decision trees (CART, depth $\le 3$) on scenario parameter space across all trials.
- Generate human-auditable predicates with precision, support, and boundary coverage stored in `odd_parameter_rules.json`.

### S4 — Boundary & Pair Correlation
- Map parameter-space pairs to extracted boundary trials using trial ID matching to correlate behavioral contrasts with global boundary regions.

### S5 — Grounded ODD Q&A
- Generate a compact run briefing (`odd_chat_briefing.json`) combining cluster cards, rules, boundary statistics, and pair summaries.
- Implement `POST /api/odd-chat` to serve grounded interactive consultations with explicit citations and fallback responses for missing data.
