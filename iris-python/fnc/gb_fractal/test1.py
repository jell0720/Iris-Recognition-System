from numpy import *
import numpy.matlib
from imDist import imDist
from DIMatrix import DIMatrix
a = array([[3,6,6],[4,5,1],[2,2,3]])
# # b = sum(a,axis = 1)
# # b = b[newaxis,:].T
# # b = numpy.matlib.repmat(b,1,24)
# b = array([[1,2,3],[1,2,3],[4,5,7]])
# d = array([[1],[2],[3]])
# c = sum((a-b),axis=1)
# print(c)
# c = c[newaxis,:].T
# c = c/d
# print(c)
from ribbonDist import ribbonDist
# a = arange(1920)
# b = arange(1920)
# b = b*2
# c = arange(96)
# e = ones((4,20))*3
# r = imDist(a,b,e,c)
# print(r)
# [m,n] = unravel_index(7,[20,20])
# a = ravel_multi_index((0,7),(20,20))
# print(a)
a = ones((400,1920))
a = a* 3
b = ones((4,20,160000))*2
c = ones((1,96))
d = DIMatrix(a,b,c)
print(shape(d))
