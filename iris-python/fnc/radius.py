##
##	Author: Nguyen Chinh Thuy.
##	Date  : 18/08/2017.
##


##
## Import
##
from numpy import sqrt, mean


##
## Function : Calculate the radius of an object based on its boundary and core.
##
##   Input  : bound : Boundary of a specific object (x-y).
##			  p     : Centroid of the boundary (i-j).
##
##   Output : r     : Value of the radius.
##
def cal (bound, p):
    di = bound[:,0,1] - p[0]
    dj = bound[:,0,0] - p[1]
    r = sqrt(di**2 + dj**2)
    r = mean(r)
    return r
