#!/usr/sbin/python

from PIL import Image
import imagehash
import sys

h1      = imagehash.average_hash(Image.open(sys.argv[1]))
h2 = imagehash.average_hash(Image.open(sys.argv[2]))

# print(h1, " ", h2, " compare: ", h1 == h2, " diff:", h1 - h2)
print(h1 == h2)
