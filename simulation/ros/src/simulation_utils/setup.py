#!/usr/bin/env python

"""
Setup for simulation_utils
"""

from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['simulation_utils', 'cython_simulation_utils'],
    package_dir={'': 'src'},
)

setup(**d)

import os
dir_path = os.path.dirname(os.path.realpath(__file__))
cmd = "python2 {}/src/cython_simulation_utils/setup.py build_ext --inplace".format(dir_path)
os.system(cmd)