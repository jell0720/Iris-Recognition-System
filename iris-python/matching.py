"""
Do Tieu Thien
22/9/2107
Matching of Iris
"""

# Import
from numpy import*
from scipy.io import loadmat
import sys
sys.path.append('C:/Users/Admin/Documents/Github/Iris-Python/Iris-Recognition-System/iris-python/fnc/gb_fractal')
sys.path.append('C:/Users/Admin/Documents/Github/Iris-Python/Iris-Recognition-System/iris-python/fnc/FAR-FRR')
from DIMatrix import DIMatrix

# Load
Data_file = loadmat('data.mat',squeeze_me=True,struct_as_record=False)
Training_file = loadmat('training.mat',squeeze_me=True,struct_as_record=False)
IRIS = Data_file['IRIS']
training = Training_file['training']

# Creat muntual effective matrix
E = zeros((4,20,160000))
for i in range(400):
    for j in range(400):
        # Index
        ind = 400*i+j
        # Same
        if i == j:
            E[:,:,ind] = IRIS.E[:,:,i]
            continue
        # Combination order
        elif j < i:
            s_ind = 400*(j-1)+i
            E[:,:,ind] = E[:,:,s_ind]
            continue
        # Normal
        else:
            E[:,:,ind] = IRIS.E[:,:,i]* IRIS.E[:,:,j]

# Label matrix
label_map = zeros((20,20,400))
for im_id in range(400):
    [i, j] = unravel_index(im_id,[20,20])
    if i < 10:
        label_map[i,0:10,im_id] = ones((1,10))
    else:
        label_map[i,10:20,im_id] = ones((1, 10))

# Calculate distance
print(shape(IRIS.V))
print(shape(E))
print(shape(training.map))
DI_all = DIMatrix[IRIS.V,E,training.map]
