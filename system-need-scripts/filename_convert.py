#!/usr/share/python3

import os
path = os.path.dirname(os.path.realpath(__file__))
files = os.listdir(path)
for f in files:
	f1=f.replace("-","_")
	os.rename(f, f1)
print(os.listdir(path))
