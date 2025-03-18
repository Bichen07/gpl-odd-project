"""
Setup for sumo_cosimulation
"""

from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['sumo_cosimulation', 'sumo_cosimulation_adv'],
    package_dir={'': 'src'}
)

setup(**d)
