"""
Do Tieu Thien
18/9/2017
"""



"""
Import
"""
from cv2 import *
from numpy import *
from IRIS import IRIS
from DIMatrix import DIMatrix



"""
Load
"""



"""
Creat muntual effective matrix
"""
E = zeros((4,20,400))
V = zeros((400,1920))
IRIS = IRIS(E,V)
E = zeros((4,20,160000))
for i in range(400):
    for j in range(400):
        # Index
        ind = 400*(i-1)+j
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

"""
Label matrix
"""
label_map = zeros((20,20,400))
for im_id in range(400):
    [i, j] = unravel_index(im_id,[20,20])
    if i < 11:
        label_map[i,1:10,im_id] = ones((1,10))
    else:
        label_map[i,11:20,im_id] = ones((1, 10))

"""
Calculate distance
"""
DI_all