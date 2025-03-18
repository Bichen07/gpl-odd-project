"""
Setup for scenario_tools
"""

from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['scenario_tools', 'reproducing_tools', 'trajectory_analysis'],
    package_dir={'': 'src'}
)

setup(**d)
