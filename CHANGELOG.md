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

**Next steps (Phase 2)**: Add `get_cluster_medoids()` and `get_medoid_observations()` helpers.

Last updated: 2026-04-28
