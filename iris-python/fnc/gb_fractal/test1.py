from numpy import *
import numpy.matlib
# a = array([[3,6,6],[4,5,1],[2,2,3]])
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
a = arange(1920)
b = arange(1920)
b = b*2
c = ones((4,20))
X = ribbonDist(a,b,c)
print(shape(X))