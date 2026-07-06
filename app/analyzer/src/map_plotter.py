"""
map_plotter.py — xosc_gen MapPlotter (vendored from xosc_gen/scripts/xodr_plot.py).

Renders OpenDRIVE lane geometry from an esmini *odrplot* tracks CSV
(``*_tracks.csv``) with optional agent bounding boxes at a timestamp.
"""
from __future__ import annotations

import csv
import io
import math
import os
from dataclasses import dataclass
from typing import List, Optional, Set, Tuple

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import pandas as pd
import yaml

try:
    from PIL import Image
except ImportError:  # pragma: no cover
    Image = None  # type: ignore


def _coerce_highlight_road_ids(highlight_road_ids_list) -> Set[str]:
    """Accept list, comma-separated str, or iterable of road ids (xosc_gen compat)."""
    if not highlight_road_ids_list:
        return set()
    if isinstance(highlight_road_ids_list, str):
        parts = [p.strip() for p in highlight_road_ids_list.split(",") if p.strip()]
        return {str(p) for p in parts}
    return {str(r_id) for r_id in highlight_road_ids_list}


def _rotated_box_vertices(
    center_x: float,
    center_y: float,
    heading_deg: float,
    length: float,
    width: float,
) -> List[Tuple[float, float]]:
    """Corner vertices of an oriented vehicle rectangle in world coordinates."""
    hl, hw = length / 2.0, width / 2.0
    rad = math.radians(heading_deg)
    cos_h, sin_h = math.cos(rad), math.sin(rad)
    verts: List[Tuple[float, float]] = []
    for lx, ly in ((-hl, -hw), (hl, -hw), (hl, hw), (-hl, hw)):
        verts.append(
            (
                center_x + lx * cos_h - ly * sin_h,
                center_y + lx * sin_h + ly * cos_h,
            )
        )
    return verts


@dataclass(frozen=True)
class BevTypography:
    """Font sizes (matplotlib pt) for BEV labels and snapshot corner overlays."""

    road_label_size: float = 5.6
    lane_label_size: float = 5.6
    road_label_plain_size: float = 4.8
    agent_id_fontsize: float = 6.0
    info_fontsize: float = 8.0
    scope_fontsize: float = 7.0
    title_fontsize: float = 7.0


DEFAULT_BEV_TYPOGRAPHY = BevTypography()

_SCALE_BAR_N_TICKS = 6
# Scale bar must be wider than 1/6 of the full output image (figure width).
_SCALE_BAR_MIN_WIDTH_FRAC = 1.0 / 6.0
_SCALE_TIERS_M = (5.0, 10.0, 25.0, 50.0, 100.0, 200.0)


def _map_length_real(scope_bounds: Tuple[float, float, float, float]) -> float:
    xmin, xmax, ymin, ymax = scope_bounds
    return max(float(xmax - xmin), float(ymax - ymin))


def _target_scale_meters(map_length_real: float) -> float:
    """Pick a round scale-bar length (m) from visible map span."""
    if map_length_real <= 30:
        return 5.0
    if map_length_real <= 60:
        return 10.0
    if map_length_real <= 125:
        return 25.0
    if map_length_real <= 300:
        return 50.0
    if map_length_real <= 600:
        return 100.0
    return 200.0


def _scale_bar_layout(
    map_length_real: float,
    target_real: float,
    content_frac: float,
) -> Tuple[float, float]:
    """Return (target_real, bar_width_fig) with bar wider than 1/6 of image."""
    if map_length_real <= 0:
        return target_real, _SCALE_BAR_MIN_WIDTH_FRAC

    tiers = _SCALE_TIERS_M
    try:
        tier_idx = tiers.index(target_real)
    except ValueError:
        tier_idx = 0

    while tier_idx < len(tiers):
        target_real = tiers[tier_idx]
        bar_width_fig = (target_real / map_length_real) * content_frac
        if bar_width_fig >= _SCALE_BAR_MIN_WIDTH_FRAC:
            return target_real, bar_width_fig
        tier_idx += 1

    # Fallback: span the full map content width.
    return map_length_real, content_frac


def _format_meters_label(value: float) -> str:
    if abs(value - round(value)) < 1e-6:
        return str(int(round(value)))
    return f"{value:.1f}"


class MapPlotter:
    """Visualize road network from odrplot ``*_tracks.csv`` + optional agents."""

    _DEFAULT_OUTPUT_DPI = 100

    def _begin_figure(
        self,
        output_px: Optional[int],
        white_border_frac: float,
    ):
        """Create a square figure; optional white margin around the map axes."""
        if output_px:
            dpi = self._DEFAULT_OUTPUT_DPI
            fig_w = output_px / dpi
            fig = plt.figure(figsize=(fig_w, fig_w), dpi=dpi, facecolor="white")
            if white_border_frac > 0:
                content_frac = 1.0 / (1.0 + 2.0 * white_border_frac)
                margin = white_border_frac * content_frac
                ax = fig.add_axes(
                    [margin, margin, content_frac, content_frac],
                    facecolor="white",
                )
            else:
                ax = fig.add_axes([0, 0, 1, 1], facecolor="white")
            plt.sca(ax)
            return fig
        plt.figure(1)
        plt.clf()
        plt.gcf().set_facecolor("white")
        return plt.gcf()

    @staticmethod
    def _content_frac(white_border_frac: float) -> float:
        if white_border_frac > 0:
            return 1.0 / (1.0 + 2.0 * white_border_frac)
        return 1.0

    @staticmethod
    def _meters_per_pixel(
        scope_bounds: Tuple[float, float, float, float],
        output_px: int,
        white_border_frac: float,
    ) -> float:
        """Meters per pixel on the map axes (equal aspect, limiting span fills content area)."""
        xmin, xmax, ymin, ymax = scope_bounds
        display_span_m = max(float(xmax - xmin), float(ymax - ymin))
        if output_px <= 0 or display_span_m <= 0:
            return 1.0
        content_frac = MapPlotter._content_frac(white_border_frac)
        map_content_px = output_px * content_frac
        return display_span_m / map_content_px

    def _plot_scale_bar(
        self,
        fig,
        scope_bounds: Tuple[float, float, float, float],
        output_px: int,
        white_border_frac: float,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
    ) -> None:
        """Bottom-left scale bar: graphic width matches ``target_real`` metres on-map."""
        map_length_real = _map_length_real(scope_bounds)
        content_frac = self._content_frac(white_border_frac)
        target_real = _target_scale_meters(map_length_real)
        target_real, bar_width_fig = _scale_bar_layout(
            map_length_real, target_real, content_frac
        )

        n_ticks = _SCALE_BAR_N_TICKS
        n_intervals = n_ticks - 1
        step_m = target_real / n_intervals

        x0, y0 = 0.02, 0.028
        bar_h = 0.010

        for i in range(n_intervals):
            seg_x0 = x0 + (i / n_intervals) * bar_width_fig
            seg_w = bar_width_fig / n_intervals
            face = "#222222" if i % 2 == 0 else "white"
            fig.add_artist(
                mpatches.Rectangle(
                    (seg_x0, y0),
                    seg_w,
                    bar_h,
                    transform=fig.transFigure,
                    facecolor=face,
                    edgecolor="#222222",
                    linewidth=0.6,
                    zorder=31,
                    clip_on=False,
                )
            )

        label_y = y0 - 0.006
        for i in range(n_ticks):
            tx = x0 + (i / n_intervals) * bar_width_fig
            value_m = step_m * i
            fig.text(
                tx,
                label_y,
                _format_meters_label(value_m),
                transform=fig.transFigure,
                fontsize=typography.scope_fontsize,
                ha="center",
                va="top",
                color="#222222",
                zorder=32,
                clip_on=False,
            )

        fig.text(
            x0 + bar_width_fig + 0.012,
            y0 + bar_h * 0.15,
            "m",
            transform=fig.transFigure,
            fontsize=typography.scope_fontsize,
            ha="left",
            va="bottom",
            color="#222222",
            zorder=32,
            clip_on=False,
        )

    def _plot_snapshot_overlays(
        self,
        fig,
        legend_lines: List[str],
        time_label: Optional[str],
        scope_bounds: Optional[Tuple[float, float, float, float]],
        output_px: int,
        white_border_frac: float = 0.0,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
    ) -> None:
        """Corner annotations for LLM snapshots (figure coords, white margin)."""
        overlay_bbox = dict(
            boxstyle="round,pad=0.25",
            facecolor="white",
            edgecolor="#666666",
            alpha=0.92,
        )
        if legend_lines:
            fig.text(
                0.01,
                0.99,
                "\n".join(legend_lines),
                transform=fig.transFigure,
                fontsize=typography.info_fontsize,
                va="top",
                ha="left",
                family="monospace",
                bbox=overlay_bbox,
                zorder=30,
            )
        if time_label:
            fig.text(
                0.99,
                0.99,
                time_label,
                transform=fig.transFigure,
                fontsize=typography.info_fontsize,
                va="top",
                ha="right",
                color="#222222",
                bbox=overlay_bbox,
                zorder=30,
            )
        if scope_bounds is not None:
            self._plot_scale_bar(
                fig,
                scope_bounds,
                output_px,
                white_border_frac,
                typography=typography,
            )

    def plot_empty_map(
        self,
        csv_file_path: str,
        output_file: str,
        highlight_road_ids_list: Optional[List] = None,
        view_bounds: Optional[Tuple[float, float, float, float]] = None,
        figure_title: Optional[str] = None,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
        output_px: Optional[int] = None,
    ) -> None:
        """Map only (xosc_gen ``plot_empty_map`` style) with road/lane ID labels."""
        self.render_scene(
            csv_file_path,
            output_file,
            highlight_road_ids_list=highlight_road_ids_list,
            view_bounds=view_bounds,
            draw_labels=True,
            typography=typography,
            figure_title=figure_title,
            output_px=output_px,
        )

    def plot_map_with_agents(
        self,
        csv_file_path: str,
        output_file: str,
        tracks_csv_path: str,
        metadata_yaml_path: str,
        timestamp: float,
        highlight_road_ids_list: Optional[List] = None,
        ego_id: Optional[int] = None,
        heading_in_degrees: bool = True,
        view_bounds: Optional[Tuple[float, float, float, float]] = None,
        draw_trajectory_trails: bool = True,
        draw_labels: bool = False,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
        output_px: Optional[int] = None,
        white_border_frac: float = 0.0,
        time_label: Optional[str] = None,
        scope_bounds: Optional[Tuple[float, float, float, float]] = None,
        figure_title: Optional[str] = None,
    ) -> None:
        """Snapshot at ``timestamp`` — map styling without road/lane ID labels."""
        self.render_scene(
            csv_file_path,
            output_file,
            highlight_road_ids_list=highlight_road_ids_list,
            view_bounds=view_bounds,
            draw_labels=draw_labels,
            typography=typography,
            output_px=output_px,
            white_border_frac=white_border_frac,
            time_label=time_label,
            scope_bounds=scope_bounds,
            tracks_csv_path=tracks_csv_path,
            metadata_yaml_path=metadata_yaml_path,
            timestamp=timestamp,
            ego_id=ego_id,
            heading_in_degrees=heading_in_degrees,
            draw_trajectory_trails=draw_trajectory_trails,
            figure_title=figure_title,
        )

    def render_scene(
        self,
        map_csv_path: str,
        output_file: str,
        *,
        highlight_road_ids_list: Optional[List] = None,
        view_bounds: Optional[Tuple[float, float, float, float]] = None,
        draw_labels: bool = True,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
        tracks_csv_path: Optional[str] = None,
        metadata_yaml_path: Optional[str] = None,
        timestamp: Optional[float] = None,
        ego_id: Optional[int] = None,
        heading_in_degrees: bool = True,
        draw_trajectory_trails: bool = False,
        figure_title: Optional[str] = None,
        time_label: Optional[str] = None,
        scope_bounds: Optional[Tuple[float, float, float, float]] = None,
        output_px: Optional[int] = None,
        white_border_frac: float = 0.0,
    ) -> None:
        """Single render path for empty-map overviews and agent snapshots."""
        fig = self._begin_figure(output_px, white_border_frac)
        (
            all_lanes_info,
            processed_roads_data,
            road_id_text_plot_info,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            lane_id_text_plot_info,
        ) = self._parse_and_process_map_data(map_csv_path)
        highlight_road_ids = _coerce_highlight_road_ids(highlight_road_ids_list)
        highlighting_active = bool(highlight_road_ids)
        self._plot_base_map(
            all_lanes_info,
            processed_roads_data,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            highlighting_active,
            highlight_road_ids,
        )
        if draw_labels:
            self._plot_text_labels(
                road_id_text_plot_info,
                lane_id_text_plot_info,
                highlighting_active,
                highlight_road_ids,
                typography=typography,
            )
        if (
            draw_trajectory_trails
            and tracks_csv_path
            and metadata_yaml_path
            and timestamp is not None
        ):
            self._plot_trajectory_trails(
                tracks_csv_path,
                metadata_yaml_path,
                timestamp,
                ego_id=ego_id,
            )
        legend_lines: List[str] = []
        if tracks_csv_path and metadata_yaml_path and timestamp is not None:
            legend_lines = self._plot_agents(
                tracks_csv_path,
                metadata_yaml_path,
                timestamp,
                ego_id=ego_id,
                heading_in_degrees=heading_in_degrees,
                typography=typography,
            )
        if view_bounds is not None:
            xmin, xmax, ymin, ymax = view_bounds
            plt.xlim(xmin, xmax)
            plt.ylim(ymin, ymax)

        effective_scope = scope_bounds if scope_bounds is not None else view_bounds
        use_corner_overlays = output_px is not None and (
            legend_lines or time_label or effective_scope is not None
        )
        if use_corner_overlays:
            self._plot_snapshot_overlays(
                fig,
                legend_lines,
                time_label,
                effective_scope,
                output_px,
                white_border_frac=white_border_frac,
                typography=typography,
            )
        elif legend_lines:
            self._plot_agent_id_legend(legend_lines, typography=typography)

        if figure_title and not time_label:
            if output_px and white_border_frac > 0:
                fig.text(
                    0.5,
                    0.995,
                    figure_title,
                    transform=fig.transFigure,
                    fontsize=typography.title_fontsize,
                    ha="center",
                    va="top",
                    color="#222222",
                    zorder=30,
                    clip_on=False,
                )
            else:
                ax = plt.gca()
                ax.text(
                    0.5,
                    0.98,
                    figure_title,
                    transform=ax.transAxes,
                    fontsize=typography.title_fontsize,
                    ha="center",
                    va="top",
                    color="#222222",
                    zorder=20,
                    clip_on=True,
                )
        self._finalize_and_save_plot(
            output_file,
            save_as_grayscale=False,
            output_px=output_px,
        )

    def _parse_and_process_map_data(self, csv_file_path: str):
        with open(csv_file_path) as f:
            reader = csv.reader(f, skipinitialspace=True)
            positions = list(reader)
        all_lanes_info, current_lane_data_ptr = [], None
        for pos in positions:
            if not pos:
                continue
            if pos[0] == "lane":
                ltype = "driving"
                if pos[3] == "0":
                    ltype = "ref"
                elif len(pos) > 4 and pos[4] == "no-driving":
                    ltype = "border"
                new_lane_entry = {
                    "road_id": pos[1],
                    "lane_section": pos[2],
                    "lane_id_str": pos[3],
                    "type": ltype,
                    "x": [],
                    "y": [],
                    "z": [],
                    "h": [],
                }
                try:
                    new_lane_entry["lane_id_int"] = int(pos[3])
                except ValueError:
                    new_lane_entry["lane_id_int"] = None
                all_lanes_info.append(new_lane_entry)
                current_lane_data_ptr = new_lane_entry
            elif current_lane_data_ptr:
                try:
                    current_lane_data_ptr["x"].append(float(pos[0]))
                    current_lane_data_ptr["y"].append(float(pos[1]))
                    current_lane_data_ptr["z"].append(float(pos[2]))
                    current_lane_data_ptr["h"].append(float(pos[3]))
                except (ValueError, IndexError):
                    pass
        (
            processed_roads_data,
            road_id_text_plot_info,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            lane_id_text_plot_info,
        ) = ([], [], [], [], [])
        processed_roads_data = {}
        road_id_text_plot_info = []
        road_start_dots_plot_info = []
        lane_section_dots_coords = []
        lane_id_text_plot_info = []
        for lane_info_entry in all_lanes_info:
            r_id = lane_info_entry["road_id"]
            ls_idx = lane_info_entry["lane_section"]
            l_id_int = lane_info_entry.get("lane_id_int")
            if l_id_int is None and lane_info_entry["lane_id_str"] == "0":
                l_id_int = 0
                lane_info_entry["lane_id_int"] = 0
            processed_roads_data.setdefault(r_id, {}).setdefault(ls_idx, {})[l_id_int] = (
                lane_info_entry
            )
            if lane_info_entry["type"] == "driving" and len(lane_info_entry["x"]) > 0:
                idx = len(lane_info_entry["x"]) // 2
                lane_id_text_plot_info.append(
                    {
                        "text": lane_info_entry["lane_id_str"],
                        "x": lane_info_entry["x"][idx],
                        "y": lane_info_entry["y"][idx],
                        "road_id": r_id,
                    }
                )
        for r_id_iter, sections_data in processed_roads_data.items():
            if "0" in sections_data and 0 in sections_data["0"]:
                ref_lane = sections_data["0"][0]
                if ref_lane["type"] == "ref" and len(ref_lane["x"]) > 0:
                    idx = len(ref_lane["x"]) // 3
                    h_val = ref_lane["h"][idx]
                    text_x_val = ref_lane["x"][idx] + 0.7 * math.sin(h_val)
                    text_y_val = ref_lane["y"][idx] - 0.7 * math.cos(h_val)
                    road_id_text_plot_info.append(
                        {"text": r_id_iter, "x": text_x_val, "y": text_y_val}
                    )
                    if len(ref_lane["x"]) > 1:
                        arrow_dx_val = ref_lane["x"][1] - ref_lane["x"][0]
                        arrow_dy_val = ref_lane["y"][1] - ref_lane["y"][0]
                    else:
                        arrow_dx_val, arrow_dy_val = 0, 0
                    road_start_dots_plot_info.append(
                        {
                            "road_id": r_id_iter,
                            "x": ref_lane["x"][0],
                            "y": ref_lane["y"][0],
                            "dx": arrow_dx_val,
                            "dy": arrow_dy_val,
                        }
                    )
        for lane_info_entry in all_lanes_info:
            if lane_info_entry["type"] == "ref" and len(lane_info_entry["x"]) > 0:
                lane_section_dots_coords.append(
                    {
                        "road_id": lane_info_entry["road_id"],
                        "x": lane_info_entry["x"][-1],
                        "y": lane_info_entry["y"][-1],
                    }
                )
        return (
            all_lanes_info,
            processed_roads_data,
            road_id_text_plot_info,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            lane_id_text_plot_info,
        )

    def _plot_base_map(
        self,
        all_lanes_info,
        processed_roads_data,
        road_start_dots_plot_info,
        lane_section_dots_coords,
        highlighting_active,
        highlight_road_ids: Set[str],
    ) -> None:
        del lane_section_dots_coords  # unused in xosc_gen default

        # Pass 1: draw explicit border polylines (shoulder/parking/border-typed lanes).
        for lane_info in all_lanes_info:
            if lane_info["type"] == "border" and len(lane_info["x"]) > 0:
                plt.plot(
                    lane_info["x"],
                    lane_info["y"],
                    linewidth=1.0,
                    color="#AAAAAA",
                )

        # Pass 2: junction connector roads often have ONLY driving lanes — no shoulder.
        # odrplot writes each lane's OUTER boundary as its polyline, so the outermost
        # driving lane on each side IS the road border. Draw it gray when no explicit
        # border lane exists on that side.
        for r_id, sections_data in processed_roads_data.items():
            for ls_idx, lanes_in_section in sections_data.items():
                lane_ids = [lid for lid in lanes_in_section if lid is not None]
                pos_ids = [lid for lid in lane_ids if lid > 0]
                neg_ids = [lid for lid in lane_ids if lid < 0]

                pos_has_border = any(
                    lanes_in_section[lid]["type"] == "border" for lid in pos_ids
                )
                neg_has_border = any(
                    lanes_in_section[lid]["type"] == "border" for lid in neg_ids
                )

                if not pos_has_border and pos_ids:
                    outer = lanes_in_section[max(pos_ids)]
                    if outer["type"] == "driving" and len(outer["x"]) > 0:
                        plt.plot(outer["x"], outer["y"], linewidth=1.0, color="#AAAAAA")

                if not neg_has_border and neg_ids:
                    outer = lanes_in_section[min(neg_ids)]
                    if outer["type"] == "driving" and len(outer["x"]) > 0:
                        plt.plot(outer["x"], outer["y"], linewidth=1.0, color="#AAAAAA")

        for lane_info in all_lanes_info:
            if highlighting_active and lane_info["road_id"] not in highlight_road_ids:
                continue
            if lane_info["type"] == "ref" and len(lane_info["x"]) > 0:
                plt.plot(lane_info["x"], lane_info["y"], linewidth=2.0, color="#BB5555")

        for lane_info in all_lanes_info:
            if lane_info["type"] != "driving" or len(lane_info["x"]) < 2:
                continue
            r_id = lane_info["road_id"]
            ls_idx = lane_info["lane_section"]
            l_id_int = lane_info.get("lane_id_int")
            if r_id not in highlight_road_ids:
                continue
            lanes_in_section = processed_roads_data.get(r_id, {}).get(ls_idx, {})
            b1_coords, b2_coords = None, None
            if l_id_int is not None and l_id_int > 0:
                if l_id_int - 1 in lanes_in_section:
                    b1_coords = (
                        lanes_in_section[l_id_int - 1]["x"],
                        lanes_in_section[l_id_int - 1]["y"],
                    )
                if l_id_int + 1 in lanes_in_section:
                    b2_coords = (
                        lanes_in_section[l_id_int + 1]["x"],
                        lanes_in_section[l_id_int + 1]["y"],
                    )
            elif l_id_int is not None and l_id_int < 0:
                if l_id_int + 1 in lanes_in_section:
                    b1_coords = (
                        lanes_in_section[l_id_int + 1]["x"],
                        lanes_in_section[l_id_int + 1]["y"],
                    )
                if l_id_int - 1 in lanes_in_section:
                    b2_coords = (
                        lanes_in_section[l_id_int - 1]["x"],
                        lanes_in_section[l_id_int - 1]["y"],
                    )
            if (
                b1_coords
                and b2_coords
                and len(b1_coords[0]) > 1
                and len(b2_coords[0]) > 1
            ):
                min_len = min(len(b1_coords[0]), len(b2_coords[0]))
                poly_x = list(b1_coords[0][:min_len]) + list(
                    reversed(b2_coords[0][:min_len])
                )
                poly_y = list(b1_coords[1][:min_len]) + list(
                    reversed(b2_coords[1][:min_len])
                )
                plt.fill(
                    poly_x,
                    poly_y,
                    color="gray",
                    alpha=0.35,
                    edgecolor="none",
                )

        for info in road_start_dots_plot_info:
            if highlighting_active and info["road_id"] not in highlight_road_ids:
                continue
            if not (info["dx"] == 0 and info["dy"] == 0):
                plt.arrow(
                    info["x"],
                    info["y"],
                    info["dx"],
                    info["dy"],
                    width=0.1,
                    head_width=1.0,
                    head_length=1.5,
                    color="#BB5555",
                    length_includes_head=True,
                )

    def _plot_text_labels(
        self,
        road_id_text_plot_info,
        lane_id_text_plot_info,
        highlighting_active,
        highlight_road_ids: Set[str],
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
    ) -> None:
        lane_pad = 0.15 * (typography.lane_label_size / 7.0)
        road_pad = 0.3 * (typography.road_label_size / 7.0)
        lane_bbox = dict(
            boxstyle=f"round,pad={lane_pad:.3f}",
            fc="black",
            ec="none",
            alpha=0.7,
        )
        road_bbox = dict(
            boxstyle=f"round,pad={road_pad:.3f}",
            fc="red",
            ec="darkred",
            alpha=0.7,
        )
        for info in lane_id_text_plot_info:
            if highlighting_active and info["road_id"] not in highlight_road_ids:
                continue
            plt.text(
                info["x"],
                info["y"],
                info["text"],
                size=typography.lane_label_size,
                color="white",
                ha="center",
                va="center",
                bbox=lane_bbox,
            )
        for info in road_id_text_plot_info:
            road_id_str = info["text"]
            if highlighting_active:
                if road_id_str in highlight_road_ids:
                    plt.text(
                        info["x"],
                        info["y"],
                        road_id_str,
                        size=typography.road_label_size,
                        color="white",
                        fontweight="bold",
                        ha="center",
                        va="center",
                        bbox=road_bbox,
                    )
            else:
                plt.text(
                    info["x"],
                    info["y"],
                    road_id_str,
                    size=typography.road_label_plain_size,
                    color="#222222",
                    ha="center",
                    va="center",
                )

    def _plot_trajectory_trails(
        self,
        tracks_csv_path: str,
        metadata_yaml_path: str,
        timestamp: float,
        ego_id: Optional[int] = None,
    ) -> None:
        """Draw each agent path from scenario start up to ``timestamp``."""
        try:
            with open(metadata_yaml_path, "r") as f:
                metadata = yaml.safe_load(f)
            x_offset = metadata.get("x_offset", 0)
            y_offset = metadata.get("y_offset", 0)
        except (OSError, yaml.YAMLError):
            x_offset, y_offset = 0.0, 0.0

        try:
            df = pd.read_csv(tracks_csv_path)
        except (FileNotFoundError, OSError):
            return

        for track_id, group_df in df.groupby("trackId"):
            trail = group_df[group_df["time"] <= timestamp + 0.02].sort_values("time")
            if len(trail) < 2:
                continue
            xs = trail["x"].astype(float) + x_offset
            ys = trail["y"].astype(float) + y_offset
            tid = int(track_id)
            is_ego = ego_id is not None and tid == ego_id
            color = "#CC5500" if is_ego else "#2255AA"
            plt.plot(
                xs,
                ys,
                color=color,
                linewidth=1.4,
                alpha=0.9,
                linestyle="-",
                zorder=8,
            )

    def _plot_agent_id_legend(
        self,
        legend_lines: List[str],
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
    ) -> None:
        """Draw ID → role key inside the map viewport (top-left, no canvas expansion)."""
        if not legend_lines:
            return
        ax = plt.gca()
        text = "\n".join(legend_lines)
        ax.text(
            0.02,
            0.98,
            text,
            transform=ax.transAxes,
            fontsize=typography.info_fontsize,
            va="top",
            ha="left",
            family="monospace",
            bbox=dict(
                boxstyle="round,pad=0.25",
                facecolor="white",
                edgecolor="#666666",
                alpha=0.92,
            ),
            zorder=20,
            clip_on=True,
        )

    def _plot_agents(
        self,
        tracks_csv_path: str,
        metadata_yaml_path: str,
        timestamp: float,
        ego_id: Optional[int] = None,
        heading_in_degrees: bool = True,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
    ) -> List[str]:
        try:
            with open(metadata_yaml_path, "r") as f:
                metadata = yaml.safe_load(f)
            x_offset = metadata.get("x_offset", 0)
            y_offset = metadata.get("y_offset", 0)
            agents_meta = {agent["track_id"]: agent for agent in metadata["agents"]}
        except (OSError, yaml.YAMLError, KeyError) as e:
            print(f"Error: Could not read metadata '{metadata_yaml_path}': {e}")
            return []

        try:
            df = pd.read_csv(tracks_csv_path)
            grouped_tracks = df.groupby("trackId")
        except FileNotFoundError:
            print(f"Error: Tracks file not found at '{tracks_csv_path}'")
            return []
        except Exception as e:
            print(f"Error: Failed to read tracks CSV: {e}")
            return []

        agents_to_plot = []
        time_threshold = 0.15
        for _track_id, group_df in grouped_tracks:
            time_diffs = (group_df["time"] - timestamp).abs()
            closest_idx = time_diffs.idxmin()
            if time_diffs.loc[closest_idx] < time_threshold:
                agents_to_plot.append(group_df.loc[closest_idx])

        ax = plt.gca()
        velocity_scale = 0.8
        id_pad = 0.12 * (typography.agent_id_fontsize / 4.0)
        id_bbox = dict(
            boxstyle=f"circle,pad={id_pad:.3f}",
            fc="black",
            ec="white",
            linewidth=max(0.3, typography.agent_id_fontsize / 10.0),
            alpha=0.9,
        )
        legend_lines: List[str] = []

        for agent_state in agents_to_plot:
            try:
                track_id = int(agent_state["trackId"])
                if track_id not in agents_meta:
                    continue
                meta = agents_meta[track_id]
                center_x = float(agent_state.get("world_x", agent_state.get("x", 0))) + x_offset
                center_y = float(agent_state.get("world_y", agent_state.get("y", 0))) + y_offset
                heading_val = float(agent_state["heading"])
                if not heading_in_degrees:
                    heading_val = math.degrees(heading_val)
                velocity = float(agent_state["velocity"])

                width, length = float(meta["width"]), float(meta["length"])
                cls = str(meta.get("class", "car")).lower()
                if width < 0.5:
                    if cls == "pedestrian":
                        width, length = 0.4, 0.4
                    elif cls == "bicycle":
                        width, length = 0.8, 2.5
                    else:
                        width, length = 2.0, 4.5
                if length < 1.0:
                    length = 4.5

                is_ego = ego_id is not None and track_id == ego_id
                box_color = "#FF8C00" if is_ego else "#3366CC"
                edge_color = "#8B4000" if is_ego else "#003366"
                arrow_fc = "darkgreen" if is_ego else "cyan"
                arrow_ec = "darkgreen" if is_ego else "blue"

                verts = _rotated_box_vertices(center_x, center_y, heading_val, length, width)
                poly = mpatches.Polygon(
                    verts,
                    closed=True,
                    facecolor=box_color,
                    edgecolor=edge_color,
                    linewidth=2.2,
                    alpha=0.78,
                    zorder=10,
                )
                ax.add_patch(poly)

                along_x = math.cos(math.radians(heading_val))
                along_y = math.sin(math.radians(heading_val))

                display_id = int(meta.get("display_id", track_id + 1))
                role = str(meta.get("role", meta.get("name", str(track_id))))

                plt.text(
                    center_x,
                    center_y,
                    str(display_id),
                    color="white",
                    fontsize=typography.agent_id_fontsize,
                    fontweight="bold",
                    ha="center",
                    va="center",
                    bbox=id_bbox,
                    zorder=14,
                    clip_on=True,
                )

                if velocity > 0.05:
                    arrow_start_x = center_x + (length / 2) * along_x
                    arrow_start_y = center_y + (length / 2) * along_y
                    arrow_len = max(velocity * velocity_scale, 1.5)
                    ax.arrow(
                        arrow_start_x,
                        arrow_start_y,
                        arrow_len * along_x,
                        arrow_len * along_y,
                        width=0.35,
                        head_width=1.4,
                        head_length=1.8,
                        fc=arrow_fc,
                        ec=arrow_ec,
                        length_includes_head=False,
                        zorder=11,
                    )
                    legend_lines.append(
                        f"ID:{display_id} → {role}  ({velocity:.1f} m/s)"
                    )
                else:
                    legend_lines.append(f"ID:{display_id} → {role}  (stationary)")
            except (ValueError, KeyError) as e:
                print(f"Warning: Skipping agent row: {e}")

        legend_lines.sort(key=lambda s: int(s.split(":")[1].split()[0]))
        return legend_lines

    def _finalize_and_save_plot(
        self,
        output_file: str,
        save_as_grayscale: bool = False,
        output_px: Optional[int] = None,
    ) -> None:
        plt.gca().set_aspect("equal", adjustable="box")
        plt.axis("off")
        out_dir = os.path.dirname(output_file)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)

        dpi = self._DEFAULT_OUTPUT_DPI
        if save_as_grayscale and Image is not None:
            buf = io.BytesIO()
            save_kwargs = dict(format="png", dpi=dpi, facecolor="white")
            if output_px:
                save_kwargs["bbox_inches"] = None
                save_kwargs["pad_inches"] = 0
            else:
                save_kwargs["bbox_inches"] = "tight"
                save_kwargs["pad_inches"] = 0
            plt.savefig(buf, **save_kwargs)
            buf.seek(0)
            img = Image.open(buf)
            if output_px and (img.width != output_px or img.height != output_px):
                img = img.resize((output_px, output_px), Image.Resampling.LANCZOS)
            img.convert("L").save(output_file)
            buf.close()
        elif output_px:
            plt.savefig(
                output_file,
                dpi=dpi,
                bbox_inches=None,
                pad_inches=0,
                facecolor="white",
            )
        else:
            plt.savefig(output_file, dpi=120, bbox_inches="tight", pad_inches=0)
        plt.close()
