##
##	Author: Nguyen Chinh Thuy.
##	Date  : 17/08/2017.
##


##
## Import
##
from numpy import zeros, round


##
## Function : Calculate the core of an object based on its outer boundary.
##
## Input    : outbound  : Outer boundary of the object (x-y).
##
## Output   : core      : Core of the object (i-j).
##
def core_outbound (outbound):
    core = zeros(2)
    len = outbound.shape[0]
    for i in range(len):
        core[0] += outbound[i][0][1]
        core[1] += outbound[i][0][0]
    core /= len
    return round(core)
