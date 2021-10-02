import ifcopenshell as ifc
import csv
import sys
sys.path.append("C:\\Users\\ASUS\\Downloads\\FreeCAD\\bin")
import FreeCAD
import importIFC
import os
import numpy as np





os.environ['OCTAVE_EXECUTABLE'] = ('C:\\Program Files\\GNU Octave\\Octave-6.2.0\\mingw64\\bin\\octave-cli.exe')
from oct2py import octave
octave.run('main.m')
#import oct2py
#out = oct2py.Oct2Py()
#out.source('main.m')
