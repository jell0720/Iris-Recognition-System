from numpy import *
import numpy.matlib
from ribbonDist import ribbonDist
"""
Do Tieu Thien
19/9/2017
-------------
Input:  featureVec1	: Feature vector of test image [1,1920].
		featureVec2	: Feature vector of template image [1,1920].
        E           : Mutual effective region of two images.
        Y			: Map vector of indeces considered in the ribbon set [1,96].
Output: im_dis 		: Resulting distance as form of percentage.
"""

def imDist(featureVec1,featureVec2,E,Y):
    # Mutual effective region
    num_e = sum(E,axis = 1)
    num_e = numpy.matlib.repmat(num_e,1,24) # size [1,96]
    # Ribbon distances [1,96]
    X = ribbonDist(featureVec1,featureVec2,E)
    # Numerator
    num = X*num_e*Y
    num = sum(num)
    # Denominator
    den = sum(num_e)
    # Ratio is also the distance
    im_dis = num/den
    return(im_dis)