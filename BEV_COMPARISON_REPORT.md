# BEV Renderer Comparison Report

## Executive Summary

**Status**: ✅ **gpl-odd-project Phase 3 BEV renderer is functionally COMPLETE**

The comparison with `xosc_gen` (senior's project) reveals that both systems render agents correctly with bounding boxes and velocity arrows. The key differences are in **map visualization style**, not in agent rendering.

---

## Side-by-Side Comparison

### xosc_gen (Senior's Project)
**Input Format:**
- CSV file with track data: `{location}_tracks.csv`
- Metadata YAML: `{full_id}.yaml` with agent info
- Pre-processed from real-world datasets (inD, rounD)

**Map Rendering:**
- ✅ Gray-shaded driving lanes (filled polygons)
- ✅ Red reference lines (centerlines)
- ✅ Road/Lane ID labels on the map
- ✅ Black background with high contrast

**Agent Rendering:**
- ✅ Colored bounding boxes (blue for agents, orange for ego)
- ✅ Velocity arrows (green for ego, cyan for agents)
- ✅ Agent ID labels
- ✅ Clear visual distinction between ego and others

**Code Location:** `xosc_gen/scripts/xodr_plot.py`  
**Key Method:** `MapPlotter.plot_map_with_agents()`

---

### gpl-odd-project Phase 3 (Current Implementation)
**Input Format:**
- OpenDRIVE `.xodr` file (e.g., `hct_6.xodr`)
- Trajectory dict: `{agent_name: [{x, y, yaw, width, length, speed}, ...]}`
- Time steps list

**Map Rendering:**
- ✅ Reference lines (red, centerlines)
- ✅ Lane boundaries (gray for driving, lighter for borders)
- ❌ **NO gray-filled driving areas** (just outlines)
- ❌ **NO Road/Lane ID labels on map**
- ✅ White background

**Agent Rendering:**
- ✅ Colored bounding boxes (orange for ego, blue for others)
- ✅ Velocity arrows (dark green for ego, cyan for agents)
- ✅ Agent name labels (e.g., "Ego", "Oncoming")
- ✅ Legend showing color mapping
- ✅ Faded trajectory paths (historical + future)

**Code Location:** `app/analyzer/src/bev_renderer.py`  
**Key Method:** `BevRenderer._render_frame()`

---

## Key Differences

| Feature | xosc_gen | gpl-odd Phase 3 | Impact |
|---------|----------|-----------------|--------|
| **Driving lane shading** | Gray filled polygons | Outline only | **HIGH** - Makes map harder to read |
| **Road/Lane IDs on map** | Yes (red boxes for roads, black for lanes) | No | **MEDIUM** - Less spatial context |
| **Background color** | Black | White | **LOW** - Aesthetic preference |
| **Map data source** | CSV (pre-processed) | OpenDRIVE XML (.xodr) | **NEUTRAL** - Different but valid |
| **Agent bounding boxes** | ✅ Both implement | ✅ Both implement | **SAME** |
| **Velocity arrows** | ✅ Both implement | ✅ Both implement | **SAME** |
| **Trajectory paths** | No | Yes (faded lines) | **LOW** - Nice-to-have |

---

## Recommended Adjustments

### 🎯 Priority 1: Add Lane Shading (Optional, for LLM clarity)

**Why:** Gray-filled driving areas make it easier for LLMs to understand drivable space.

**How:** Modify `BevRenderer._render_frame()` to fill lane polygons between adjacent lane boundaries.

**Complexity:** Medium (requires pairing left/right lane boundaries)

**Benefit:** Improved visual clarity for LLM interpretation

---

### 🎯 Priority 2: Add Road/Lane ID Labels (Optional, for debugging)

**Why:** Helps verify `roadId`/`laneId` ground truth when debugging.

**How:** Add text annotations at lane midpoints (similar to `xodr_plot.py` line 144-151)

**Complexity:** Low

**Benefit:** Easier to cross-reference with CSV data

---

## Visual Quality Assessment

### gpl-odd-project Output (trial_5116_frame_001.jpg):
```
✅ Ego agent clearly visible (orange box at top)
✅ Oncoming agent clearly visible (blue box at bottom-left)
✅ Lane boundaries drawn correctly
✅ Legend present
✅ Title with timestamp
⚠️  Map appears "skeletal" (no filled areas)
```

### xosc_gen Output (07_3100_3500_t_1.92.jpg):
```
✅ Multiple agents with blue boxes
✅ Gray-shaded driving lanes (high contrast)
✅ Reference lines in red
✅ Agent ID numbers visible
✅ Professional, publication-ready appearance
```

---

## Conclusion

### ✅ Phase 3 Implementation Status: **COMPLETE**

**What we have:**
- Functional BEV renderer with agent bounding boxes ✅
- Velocity arrows for moving agents ✅
- Legend and labeling ✅
- Curvature-based key frame selection ✅

**What we DON'T have (compared to xosc_gen):**
- Gray-filled driving lane areas (aesthetic/clarity improvement)
- Road/Lane ID labels on the map (debugging aid)

**Recommendation for Phase 5:**
- **Keep current BEV renderer as-is** for Phase 5 LLM pipeline
- Optionally add lane shading if initial LLM results show confusion about drivable areas
- Current implementation is sufficient for MVP

---

## Code Comparison

### xosc_gen: `_plot_base_map()` (Lane Shading Logic)
```python
# Lines 122-133 in xodr_plot.py
if b1_coords and b2_coords and len(b1_coords[0]) > 1 and len(b2_coords[0]) > 1:
    min_len = min(len(b1_coords[0]), len(b2_coords[0]))
    poly_x = list(b1_coords[0][:min_len]) + list(reversed(b2_coords[0][:min_len]))
    poly_y = list(b1_coords[1][:min_len]) + list(reversed(b2_coords[1][:min_len]))
    plt.fill(poly_x, poly_y, color='gray', alpha=0.35, edgecolor='none')
```

**Key insight:** Fills polygon between adjacent lane boundaries (left and right edges of driving lane)

### gpl-odd-project: `_render_frame()` (Current Implementation)
```python
# Lines 634-675 in bev_renderer.py
for i, (agent, frame) in enumerate(frame_data.items()):
    is_ego = (i == 0)
    col = self.EGO_COLOR if is_ego else self.AGENT_COLOR
    arr_col = self.EGO_ARROW if is_ego else self.AGENT_ARROW

    cx, cy, yaw = frame["x"], frame["y"], frame["yaw"]
    length = frame.get("length", 0) or self.DEFAULT_LENGTH
    width  = frame.get("width",  0) or self.DEFAULT_WIDTH

    # Bounding box
    rect = mpatches.Rectangle(
        (-length / 2, -width / 2), length, width,
        linewidth=1.5, edgecolor=col, facecolor=col, alpha=0.7, zorder=10
    )
    tf = (transforms.Affine2D().rotate(yaw)
          + transforms.Affine2D().translate(cx, cy)
          + ax.transData)
    rect.set_transform(tf)
    ax.add_patch(rect)

    # Velocity arrow
    if speed > 0.5:
        arrow_len = speed * 0.5
        ax.annotate(
            "",
            xy=(cx + arrow_len * math.cos(yaw), cy + arrow_len * math.sin(yaw)),
            xytext=(cx, cy),
            arrowprops=dict(arrowstyle="->", color=arr_col, lw=2),
            zorder=11,
        )
```

**Key insight:** Already correctly implements bounding boxes and arrows! No changes needed for agent rendering.

---

## Final Recommendation

**For Phase 5 (LLM Pipeline):**

✅ **USE CURRENT BEV RENDERER AS-IS**

The current implementation provides all necessary information:
- Agent positions (bounding boxes)
- Agent motion (velocity arrows)
- Spatial context (lane boundaries)
- Temporal context (key frame selection)

**Optional Enhancement (if time permits):**
- Add gray lane shading for improved visual clarity
- Implement in a separate branch: `feature/bev-lane-shading`
- Not blocking for Phase 5 MVP

---

## Next Steps

1. ✅ **Mark Phase 3 as COMPLETE** (current BEV renderer is sufficient)
2. ✅ **Proceed to Phase 5** (LLM Prompt Design)
3. ⏭️ **Defer lane shading** to post-MVP polish
