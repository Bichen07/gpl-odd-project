"""
Setup for simulation_monitor
"""

from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['simulation_monitor', 'accident_identify'],
    package_dir={'': 'src'}
)

setup(**d)
