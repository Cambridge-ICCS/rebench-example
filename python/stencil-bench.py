#!/usr/bin/env python3

import time
import sys

def traverse(order: str, multiplier: int):
    """
    Create a square array, fill it with data then compute an averaging stencil
    over it in either row-major or column-major order.

    `order` must be one of `row` or `column`.
    """

    n = 1000 * multiplier
    x = [[i*n+j for j in range(0, n)] for i in range(0, n)]
    if order == "column":
        for i in range(1, n-1):
            for j in range(1, n-1):
                x[j][i] = (x[j][i]+x[j-1][i]+x[j+1][i]+x[j][i-1]+x[j][i+1]) / 5.0
    elif order == "row":
        for i in range(1, n-1):
            for j in range(1, n-1):
                x[i][j] = (x[i][j]+x[i-1][j]+x[i+1][j]+x[i][j-1]+x[i][j+1]) / 5.0
    else:
        print(f"traverse received bad order: must be \"column\" or \"row\", got \"{order}\"")

def time_traverse(order: str, multiplier: int):
    t1 = time.time()
    traverse(order, multiplier)
    t2 = time.time()
    t = t2-t1
    t_ms = t*1000
    # TODO 2023-01-30 raehik: RebenchLogAdapter doesn't support fractional
    # components! Integers only. No good reason, should be changing this soon.
    t_ms_int = int(t_ms)
    print(format_rebenchlog_line("array_stencil", 1, t_ms_int))

def format_rebenchlog_line(name, iters, runtime):
    return f"{name}: iterations={iters} runtime: {runtime}ms"

def main():
    argc = len(sys.argv)-1
    if argc != 2:
        print(f"error: expected exactly 2 arguments, got {argc}")
        sys.exit(1)
    multiplier = int(sys.argv[2])
    if sys.argv[1] == "-r":
        for i in range(0, 5):
            time_traverse("row", multiplier)
    elif sys.argv[1] == "-c":
        for i in range(0, 5):
            time_traverse("column", multiplier)
    else:
        print("error: expected -r or -c option")

main()
