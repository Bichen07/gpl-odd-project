# CHANGELOG

All notable changes to this project will be documented in this file.

## [Unreleased]

### Fixed
- **roadId ground truth bug** in `app/analyzer/src/controller.py:1583–1607`
  - The `replayerTrajectories` construction was hard-coding `roadId = 0` and using a fragile `int(item["roadId"]) == item["roadId"]` check.
  - This caused `roadId` to be lost in `heatmap.zip` / `trajectories.json` even though esmini and Payload Observations had correct values (e.g. 51, 152).
  - **Fix**: Replaced hard-coded default with safe fallback to previous frame's valid `roadId`. Added `math` import and better NaN/TypeError handling.
  - This is **Phase 1** of the Cluster Interpreter integration plan.
  - See: `cluster_interpreter_integration_plan.md` for full trace.

### Added
- `CHANGELOG.md` to record short-term changes locally (in addition to git commits).

### Testing
- A unit test will be added in the next commit (`test_roadid_preservation.py`) that:
  - Mocks a trajectory with mixed integer/float/NaN roadId values.
  - Verifies that valid roadIds are preserved across frames.
  - Will be expanded to run against real esmini CSV data.

---

## [Phase 2] feature/cluster-medoid — 2026-04-29

### Added
- `TrajectoryAnalysisController.get_cluster_medoids(X_rep, trial_ids, cluster_labels)`:
  Selects the medoid trial for each cluster by finding the point closest (L2)
  to the cluster centroid in MFPCA score space. Noise points (label -1) excluded.
  Returns `{cluster_label (int): trial_id (str)}`.
- `TrajectoryAnalysisController.get_medoid_observations(trial_id)`:
  Fetches raw Observations directly from Payload CMS, bypassing the broken
  `replayerTrajectories` path. Returns authoritative esmini `egoRoadId`,
  `egoLaneId` values. Returns `[]` on API error.
- `test_cluster_medoid.py`: 9 unit tests (medoid correctness, noise exclusion,
  string type safety, 3-cluster geometry, Payload mock).
- `HOW_TO_RUN.md`: Full developer guide — services, test commands,
  branch strategy, per-phase result visibility.

**Next steps (Phase 3)**: Build `bev_renderer.py` to produce top-down map
snapshots of the medoid trial for LLM visual input.

Last updated: 2026-04-29
