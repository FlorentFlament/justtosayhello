#!/usr/bin/python3

from sys import argv
from PIL import Image
from asmlib import *

def main():
    sprite_fname = argv[1]

    image = Image.open(sprite_fname)
    width, height = image.size

    if width != 16:
        print("Error width expected to be 16, but found {}".format(width))
        exit(1)

    data = list(image.getdata())

    sprite_l = []
    sprite_r = []
    for l in range(height):
        line_l = []
        line_r = []
        for i in range(8):
            pxl = data[l*width + i]
            line_l.append( pxl[:3] != (0,0,0) )
        for i in range(8, 16):
            pxl = data[l*width + i]
            line_r.append( pxl[:3] != (0,0,0) )
        sprite_l.append(lbool2int(line_l))
        sprite_r.append(lbool2int(line_r))

    print("sprite_l:")
    print(lst2asm(reversed(sprite_l)))
    print("sprite_r:")
    print(lst2asm(reversed(sprite_r)))

main()
