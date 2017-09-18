##
##	Author: Nguyen Chinh Thuy.
##	Date  : 18/08/2017.
##


##
## Import
##
from numpy import arange, reshape, mean, abs, sqrt, sum
from math import floor


##
## Function : Test whether the raw pupil detection is good enough.
##
##   Input  : bound : Boundary of a specific object (x-y).
##			  p     : Centroid of the boundary (i-j).
##			  N     : Number of small parts that the boundary will be divided.
##			  err	: Value that can be ignored.
##
##   Output : isOK  : Boolean result.
##
def test (bound, p, N, err):
    # Divide the boundary into small parts
    len = bound.shape[0]
    elnum = floor(len/N)
    arr = arange(1, elnum * N + 1)
    part_idx = reshape(arr,[elnum,N])

    # Calculate r for each part and the average for all parts
    i_idx = bound[:,0,1]
    j_idx = bound[:,0,0]
    di = i_idx[part_idx] - p[0]
    dj = j_idx[part_idx] - p[1]
    r = sqrt(di*di + dj*dj)
    r_ave = mean(r)

    # Calculate differences and make the decision
    diff = abs(r - r_ave)
    diff = diff > err
    if bool(sum(diff)):
        isOK = False
    else:
        isOK = True
    return isOK
