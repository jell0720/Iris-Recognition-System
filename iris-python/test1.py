from numpy import *
from scipy.io import loadmat

import numpy.matlib
import sys
sys.path.append('C:/Users/Admin/Documents/Github/Iris-Python/Iris-Recognition-System/iris-python/fnc/gb_fractal')
sys.path.append('C:/Users/Admin/Documents/Github/Iris-Python/Iris-Recognition-System/iris-python/fnc/FAR-FRR')
import DIMatrix
file = loadmat('data.mat',squeeze_me=True,struct_as_record=False)
IRIS = file['IRIS']
E = IRIS.E
print(shape(E))
