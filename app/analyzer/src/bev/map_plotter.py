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
from typing import List, Optional, Set, Tuple

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import pandas as pd
import yaml

try:
    from PIL import Image
except ImportError:  # pragma: no cover
    Image = None  # type: ignore


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


class MapPlotter:
    """Visualize road network from odrplot ``*_tracks.csv`` + optional agents."""

    def plot_empty_map(
        self,
        csv_file_path: str,
        output_file: str,
        highlight_road_ids_list: Optional[List] = None,
    ) -> None:
        (
            all_lanes_info,
            processed_roads_data,
            road_id_text_plot_info,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            lane_id_text_plot_info,
        ) = self._parse_and_process_map_data(csv_file_path)
        highlight_road_ids = (
            set(str(r_id) for r_id in highlight_road_ids_list)
            if highlight_road_ids_list
            else set()
        )
        highlighting_active = bool(highlight_road_ids)
        plt.figure(1)
        plt.clf()
        self._plot_base_map(
            all_lanes_info,
            processed_roads_data,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            highlighting_active,
            highlight_road_ids,
        )
        self._plot_text_labels(
            road_id_text_plot_info,
            lane_id_text_plot_info,
            highlighting_active,
            highlight_road_ids,
        )
        self._finalize_and_save_plot(output_file)

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
        figure_title: Optional[str] = None,
    ) -> None:
        (
            all_lanes_info,
            processed_roads_data,
            _,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            _,
        ) = self._parse_and_process_map_data(csv_file_path)
        highlight_road_ids = (
            set(str(r_id) for r_id in highlight_road_ids_list)
            if highlight_road_ids_list
            else set()
        )
        highlighting_active = bool(highlight_road_ids)
        plt.figure(1)
        plt.clf()
        self._plot_base_map(
            all_lanes_info,
            processed_roads_data,
            road_start_dots_plot_info,
            lane_section_dots_coords,
            highlighting_active,
            highlight_road_ids,
        )
        if draw_trajectory_trails:
            self._plot_trajectory_trails(
                tracks_csv_path,
                metadata_yaml_path,
                timestamp,
                ego_id=ego_id,
            )
        legend_lines = self._plot_agents(
            tracks_csv_path,
            metadata_yaml_path,
            timestamp,
            ego_id=ego_id,
            heading_in_degrees=heading_in_degrees,
        )
        if legend_lines:
            self._plot_agent_id_legend(legend_lines)
        if view_bounds is not None:
            xmin, xmax, ymin, ymax = view_bounds
            plt.xlim(xmin, xmax)
            plt.ylim(ymin, ymax)
        if figure_title:
            plt.suptitle(figure_title, fontsize=9, y=0.98, color="#222222")
        self._finalize_and_save_plot(output_file, save_as_grayscale=False)

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
        for lane_info in all_lanes_info:
            if lane_info["type"] == "border" and len(lane_info["x"]) > 0:
                plt.plot(lane_info["x"], lane_info["y"], linewidth=1.0, color="#AAAAAA")
        for lane_info in all_lanes_info:
            if highlighting_active and lane_info["road_id"] not in highlight_road_ids:
                continue
            if lane_info["type"] == "ref" and len(lane_info["x"]) > 0:
                plt.plot(lane_info["x"], lane_info["y"], linewidth=2.0, color="#BB5555")
        for lane_info in all_lanes_info:
            if lane_info["type"] == "driving" and len(lane_info["x"]) > 0:
                r_id = lane_info["road_id"]
                ls_idx = lane_info["lane_section"]
                l_id_int = lane_info.get("lane_id_int")
                if r_id in highlight_road_ids:
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
                        plt.fill(poly_x, poly_y, color="gray", alpha=0.35, edgecolor="none")
        for info in road_start_dots_plot_info:
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
    ) -> None:
        lane_bbox = dict(boxstyle="round,pad=0.15", fc="black", ec="none", alpha=0.7)
        road_bbox = dict(boxstyle="round,pad=0.3", fc="red", ec="darkred", alpha=0.7)
        for info in lane_id_text_plot_info:
            if highlighting_active and info["road_id"] not in highlight_road_ids:
                continue
            plt.text(
                info["x"],
                info["y"],
                info["text"],
                size=7,
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
                        size=7,
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
                    size=6,
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

    def _plot_agent_id_legend(self, legend_lines: List[str]) -> None:
        """Draw ID → role (+ speed) key outside the road area."""
        if not legend_lines:
            return
        text = "\n".join(legend_lines)
        plt.gcf().text(
            0.02,
            0.98,
            text,
            transform=plt.gcf().transFigure,
            fontsize=7,
            va="top",
            ha="left",
            family="monospace",
            bbox=dict(boxstyle="round,pad=0.4", facecolor="white", edgecolor="#666666", alpha=0.92),
            zorder=20,
        )

    def _plot_agents(
        self,
        tracks_csv_path: str,
        metadata_yaml_path: str,
        timestamp: float,
        ego_id: Optional[int] = None,
        heading_in_degrees: bool = True,
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
        id_bbox = dict(boxstyle="circle,pad=0.25", fc="black", ec="white", linewidth=0.8, alpha=0.9)
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

                heading_rad = math.radians(heading_val)
                # Driver's-right side of each vehicle (unified for all agents).
                lateral = 4.0 + max(width, length) / 2.0
                label_x = center_x + math.sin(heading_rad) * lateral
                label_y = center_y - math.cos(heading_rad) * lateral
                along_x = math.cos(heading_rad)
                along_y = math.sin(heading_rad)

                display_id = int(meta.get("display_id", track_id + 1))
                role = str(meta.get("role", meta.get("name", str(track_id))))

                plt.text(
                    label_x,
                    label_y,
                    str(display_id),
                    color="white",
                    fontsize=8,
                    fontweight="bold",
                    ha="center",
                    va="center",
                    bbox=id_bbox,
                    zorder=14,
                    clip_on=False,
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

    def _finalize_and_save_plot(self, output_file: str, save_as_grayscale: bool = False) -> None:
        plt.gca().set_aspect("equal", adjustable="box")
        plt.axis("off")
        out_dir = os.path.dirname(output_file)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)

        if save_as_grayscale and Image is not None:
            buf = io.BytesIO()
            plt.savefig(buf, format="png", dpi=100, bbox_inches="tight", pad_inches=0)
            buf.seek(0)
            img = Image.open(buf)
            img.convert("L").save(output_file)
            buf.close()
        else:
            plt.savefig(output_file, dpi=120, bbox_inches="tight", pad_inches=0)
        plt.close()
