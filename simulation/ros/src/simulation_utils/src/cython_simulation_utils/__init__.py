try:
	from src import cy_quaternion as cy_quaternion
	print("\033[1;36mcython_simulation_utils: cy_quaternion was used.\033[0m")
except Exception as e:
	print("\033[33m[WARNING] cython_simulation_utils: {},"\
		" use \"{}\" from simulation_utils instead. \033[0m".format(e, "quaternion"))
	from simulation_utils import quaternion as cy_quaternion
try:
	from src import cy_coord_transform as cy_coord_transform
	print("\033[1;36mcython_simulation_utils: cy_coord_transform was used.\033[0m")
except Exception as e:
	print("\033[33m[WARNING] cython_simulation_utils: {},"\
		" use \"{}\" from simulation_utils instead. \033[0m".format(e, "coord_transform"))
	from simulation_utils import coord_transform as cy_coord_transform
try:
	from src import cy_converter as cy_converter
	print("\033[1;36mcython_simulation_utils: cy_converter was used.\033[0m")
except Exception as e:
	print("\033[33m[WARNING] cython_simulation_utils: {},"\
		" use \"{}\" from simulation_utils instead. \033[0m".format(e, "converter"))
	from simulation_utils import converter as cy_converter
try:
	from src import cy_bounding_box_utils as cy_bounding_box_utils
	print("\033[1;36mcython_simulation_utils: cy_bounding_box_utils was used.\033[0m")
except Exception as e:
	print("\033[33m[WARNING] cython_simulation_utils: {},"\
		" use \"{}\" from simulation_utils instead. \033[0m".format(e, "bounding_box_utils"))
	from simulation_utils import bounding_box_utils as cy_bounding_box_utils

# To build cython code, run 'python src/cython_simulation_utils/setup.py build_ext --inplace' under simulation_utils/