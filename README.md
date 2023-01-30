# Example benchmarks run with [ReBench][rebench]
[rebench]: https://github.com/smarr/ReBench
[rebench-docs]: https://rebench.readthedocs.io/en/latest/

This repository stores two programs, one Python, one Fortran, intended to be
called by [ReBench][rebench]. Each program performs some calculation, then
reports simple performance metrics in a specific format. We then provide a
ReBench configuration file for each program that tells ReBench about it and
defines an "experiment" (essentially what set of flags should ReBench try).

## General instructions
You will need Python 3 and ReBench. With pip installed:

       pip install rebench

See the individual READMEs for further instructions. For both programs, once set
up, you should be able to run ReBench by `cd`ing into the program directory and
running

    rebench rebench.conf

## Links
  * [ReBench documentation][rebench-docs]
