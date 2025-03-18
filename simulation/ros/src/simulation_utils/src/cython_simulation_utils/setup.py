from setuptools import setup
from distutils.sysconfig import get_python_lib
from catkin_pkg.python_setup import generate_distutils_setup
import glob
import os
import sys

print("\n"*3)
print("\033[1;32;45m===================================\033[0m")
print("\033[1;32;45mInstalling cython_simulation_utils.\033[0m")
print("\033[1;32;45m===================================\033[0m")
print("\n"*3)


setup(
    name = "cython_simulation_utils",
    package_dir = {'': 'src'},
    data_files = [(get_python_lib(), glob.glob('src/*.so'))
                  #,('bin', ['bin/cython_simulation_utils'])
                  ],
    keywords = 'cmake cython build',
)


from Cython.Build import cythonize
dir_path = os.path.dirname(os.path.realpath(__file__))
setup_args = generate_distutils_setup(
    ext_modules=cythonize("{}/src/*.pyx".format(dir_path)),
    packages=['cython_simulation_utils'],
    package_dir={'': 'src'},
    requires=["geometry_msgs", "numpy"])
setup(**setup_args)