# Example Fortran program benchmark using [ReBench][rebench]
[rebench]: https://github.com/smarr/ReBench

See the top-level README for more information.

## Requirements
- gfortran (or some other Fortran compiler)

## Running
With ReBench installed, run the following in this folder:

    gfortran stencil-bench.f90 -o stencil-bench
    rebench rebench.conf
