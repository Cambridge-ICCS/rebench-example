# rebench-example
Example using ReBench with performance monitoring in Fortran

# Requires
- Python
- pip
- gfortran (or some other Fortran compiler)

# Installation
Install [ReBench](https://rebench.readthedocs.io/en/latest/):

       pip install rebench
       
Compile the example
 
       gfortran example.f90 -o example
       
# Usage

The configuration for the benchmark is given in `test.conf`. See the [documentation for ReBench](https://rebench.readthedocs.io/en/latest/) on how to configure benchmarks.

Run:

      rebench test.conf
