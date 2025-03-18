#!/usr/bin/env python
import json
from collections import OrderedDict
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import cm

data_dir = "/project/simulation/src/metric/data/"

MARK_ON_PLOT = True

# mark_data = {
# 	"real": OrderedDict([
# 		(0.0, ""),
# 		(5.785, "Bump"),
# 		(16.5464, ""),
# 		(20.3524, "ACC"),
# 		(37.44, "Bump"),
# 		(46.0466, ""),
# 		(49.1433, "Intersection"),
# 		(58.2406, "Bump"),
# 		(66.8583, "Curve"),
# 		(74.4653, "Intersection"),
# 		(74.7628, ""),
# 		(86.4655, "Overtaking"),
# 		(89.1068, ""),
# 		(94.0241, "Pedestrian"),
# 		(105.963, "")
# 	]),
# 	"sim": OrderedDict([
# 		(0.0, ""),
# 		(5.0, "Bump"),
# 		(17.6489, ""),
# 		(21.3567, "ACC"),
# 		(38.277, "Bump"),
# 		(47.7066, ""),
# 		(51.3334, "Intersection"),
# 		(59.1611, "Bump"),
# 		(68.9524, "Curve"),
# 		(78.7646, ""),
# 		(86.4655, "Overtaking"),
# 		(88.6494, ""),
# 		(94.2528, "Pedestrian"),
# 		(107.124, "")
# 	])
# }
mark_data = {
	"real": OrderedDict([
		(0.0, ""),
		(20.3524, "ACC"),
		(37.44, ""),
		#(49.1433, "Intersection"),
		#(58.2406, ""),
		#(74.4653, "Intersection"),
		#(74.7628, ""),
		(86.4655, "Overtaking"),
		(89.1068, ""),
		(94.0241, "Pedestrian"),
		(105.963, "")
	]),
	"sim": OrderedDict([
		(0.0, ""),
		(21.3567, "ACC"),
		(38.277, ""),
		#(51.3334, "Intersection"),
		#(59.1611, ""),
		(86.4655, "Overtaking"),
		(88.6494, ""),
		(94.2528, "Pedestrian"),
		(107.124, "")
	])
}

mark_color_map = {
	"": "#D2E9FF",
	"Bump": "#FFFFB9",
	"ACC": "#A6A6D2",
	"Intersection": "#FFC1E0",
	"Curve": "#9D9D9D",
	"Overtaking": "#CA8EFF",
	"Pedestrian": "#6A6AFF"
}

def main():
	traj_file = data_dir + "recorded-traj-2021-07-19-10-36-32-remove_trigger_vehicle.json"
	indice_file = data_dir + "matched_indice.json"

	with open(traj_file, "r") as f:
		traj_data = json.load(f)
	with open(indice_file, "r") as f:
		indice_data = json.load(f)

	real_traj = traj_data["real"]
	sim_traj = traj_data["sim"]

	real_indice = indice_data["Common Indice"]["real"]
	sim_indice = indice_data["Common Indice"]["sim"]
	indice_data = indice_data["Common Indice"]

	match = {
		"real": [],
		"sim": []
	}
	unmatch = {
		"real": [],
		"sim": []
	}

	indice = {
		"min": {
			"real": np.min(indice_data["real"]),
			"sim": np.min(indice_data["sim"])
		},
		"max": {
			"real": np.max(indice_data["real"]),
			"sim": np.max(indice_data["sim"])
		}
	}

	stamp = {
		"real": traj_data["real"][indice["min"]["real"]][0],
		"sim": traj_data["sim"][indice["min"]["sim"]][0]
	}

	cmap = {
		"real": "Oranges",
		"sim": "Greens"
	}

	match_color = {
		"real": {
			"speed cmd": (0.8, 0.4, 0.4, 0.8),
			"actual speed": (1.0, 0.6, 0.6, 0.8),
		},
		"sim": {
			"speed cmd": (0.4, 0.8, 0.4, 0.8),
			"actual speed": (0.6, 1.0, 0.6, 0.8)
		}
	}

	fig, ax = plt.subplots()

	for traj_from in ["real", "sim"]:

		is_matching = True
		rgb = cm.get_cmap(cmap[traj_from])

		for idx in range(len(traj_data[traj_from])):
			if idx < indice["min"][traj_from] or idx > indice["max"][traj_from]:
				continue

			if idx in indice_data[traj_from]:
				match[traj_from].append(traj_data[traj_from][idx])
				if not is_matching:
					unmatch[traj_from].append(traj_data[traj_from][idx])
					unmatch[traj_from] = np.array(unmatch[traj_from])
					ax.plot(unmatch[traj_from][:, 0] - stamp[traj_from], unmatch[traj_from][:, 5], color=(0.9, 0.8, 0.4 + 0 * 0.4, 0.6))
					ax.plot(unmatch[traj_from][:, 0] - stamp[traj_from], unmatch[traj_from][:, 6], color=(0.9, 0.8, 0.4 + 0 * 0.4, 0.6))
					unmatch[traj_from] = []
					is_matching = True
			else:
				unmatch[traj_from].append(traj_data[traj_from][idx])
				if is_matching:
					match[traj_from].append(traj_data[traj_from][idx])
					match[traj_from] = np.array(match[traj_from])
					# ax.plot(match[traj_from][:, 1], match[traj_from][:, 2], color=match_color[traj_from], linewidth=5)
					ax.plot(match[traj_from][:, 0] - stamp[traj_from], match[traj_from][:, 6], color=match_color[traj_from]["actual speed"], linewidth=2)
					ax.plot(match[traj_from][:, 0] - stamp[traj_from], match[traj_from][:, 5], color=match_color[traj_from]["speed cmd"], linewidth=2)
					match[traj_from] = []
					is_matching = False

		if is_matching:
			match[traj_from] = np.array(match[traj_from])
			# ax.plot(match[traj_from][:, 1], match[traj_from][:, 2], color=match_color[traj_from], linewidth=5)
			ax.plot(match[traj_from][:, 0] - stamp[traj_from], match[traj_from][:, 6], color=match_color[traj_from]["actual speed"], linewidth=2, label="{}: {}".format(traj_from, "actual speed"))
			ax.plot(match[traj_from][:, 0] - stamp[traj_from], match[traj_from][:, 5], color=match_color[traj_from]["speed cmd"], linewidth=2, label="{}: {}".format(traj_from, "speed cmd"))
		else:
			unmatch[traj_from] = np.array(unmatch[traj_from])
			ax.plot(unmatch[traj_from][:, 0] - stamp[traj_from], unmatch[traj_from][:, 5], color=(0.9, 0.8, 0.4 + 0 * 0.4, 0.6))
			ax.plot(unmatch[traj_from][:, 0] - stamp[traj_from], unmatch[traj_from][:, 6], color=(0.9, 0.8, 0.4 + 0 * 0.4, 0.6))

        ax.set_xlim(0, 123)
        ax.set_ylim(0, 35)
        ax.set_xlabel('Time(s)', fontsize=20, labelpad=15)
        ax.set_ylabel('Speed(km/hr)', fontsize=20, labelpad=15)
        ax.tick_params(labelsize = 15)
	return ax

def fill_states(ax):
	for traj_from, start_y, end_y in zip(["real", "sim"], [0.0, 0.5], [0.5, 1.0]):
		start_x = 0.
		last_state = ""
		for i, (stamp, state) in enumerate(mark_data[traj_from].items()):
			if i == 0:
				continue
			
			ax.axvspan(start_x, stamp, start_y, end_y, alpha=0.3, color=mark_color_map[last_state], edgecolor=None)

			if last_state != "":
				if traj_from == "real":
					if last_state != "intersection":
						ax.text(start_x + 0.5, 0.5, "{}: {}".format(traj_from, last_state), rotation=90., va="bottom", fontsize=15)
					else:
                                            ax.text(start_x, 0.5, "{}: {}".format(traj_from, last_state), rotation=90., va="bottom", ha="center", fontsize=15)
				elif traj_from == "sim":
					ax.text(start_x + 0.5, 34.5, "{}: {}".format(traj_from, last_state), rotation=90., va="top", fontsize=15)

			if i == len(mark_data[traj_from].items()) - 1:
				ax.axvspan(stamp, 124, start_y, end_y, alpha=0.3, color=mark_color_map[state], edgecolor=None)

			start_x = stamp
			last_state = state



if __name__ == '__main__':
	ax = main()
	if MARK_ON_PLOT:
		fill_states(ax)
        leg = ax.legend(loc='upper right', shadow=False, prop={'size':15}) 
	plt.show()
