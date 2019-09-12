#!/usr/bin/python3
import math
from asmlib import lst2asm

# Findings:
#
# ***** dist error *****
# stddev: 0.10069444444444445
# var: 0.125
# 
# ***** mul error *****
# stddev: 0.28125
# var: 0.28125
#
# x in [0, 23]
# sq(x): [0, 23] -> [0, 66]
# sq(x) + sq(y): [0, 23]x[0, 23] -> [0, 132]
# sqrt(x): [0, 132] -> [0, 32]
# dist(x, y): [0, 23]x[0, 23] -> [0, 32]
# mul(x, y): [0, 23]x[0, 23] -> [0, 66]
#
# Tables required:
# sq(x): [0, 23] -> [0, 66]
# sqrt(x): [0, 132] -> [0, 32]
#
# 155 bytes of tables required

DECIMALS=3

def sq(x):
    return round(2**DECIMALS * (x / 2**DECIMALS)**2)

def sqrt(x):
    return round(2**DECIMALS * math.sqrt(x / 2**DECIMALS))

def dist(x, y):
    return sqrt(sq(x) + sq(y))

def mul(x, y):
    return (sq(x) + sq(y) - sq(abs(x-y))) // 2

def dump_tables():
    print("fxc_square:")
    print(lst2asm([sq(x) for x in range(0, 24)]))
    
    print("\nfxc_sqrt:")
    print(lst2asm([sqrt(x) for x in range(0, 133)]))

def errors():
    print("***** dist error *****")
    err = 0
    err2 = 0
    for x in range(0, 24):
        for y in range(0, 24):
            eps = abs(dist(x, y) - round(math.sqrt(x**2 + y**2)))
            err += eps
            err2 += eps**2
    nelts = 24*24
    print("stddev: {}".format(err/nelts))
    print("var: {}".format(err2/nelts))
    
    print("\n***** mul error *****")
    err = 0
    err2 = 0
    for x in range(0, 24):
        for y in range(0, 24):
            eps = abs(mul(x, y) - round((x*y)/2**DECIMALS))
            err += eps
            err2 += eps**2
    nelts = 24*24
    print("stddev: {}".format(err/nelts))
    print("var: {}".format(err2/nelts))

dump_tables()
