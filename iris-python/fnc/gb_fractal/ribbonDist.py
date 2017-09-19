from numpy import *
import numpy.matlib

"""
Do Tieu Thien
19/9/2017
-------------
Input:  featureVec1	: Feature vector of test image [1,1920].
        featureVec2	: Feature vector of template image [1,1920].
        E			: Mutual effective-block matrix of test image and template image [4,20].
Output: X 			: Iris ribbon distances [1,96].
"""

def ribbonDist(featureVec1, featureVec2, E):
    # Prepare
    U1 = reshape(featureVec1,(96,20))
    U2 = reshape(featureVec2,(96,20))
    e = numpy.matlib.repmat(E,24,1)
    num_e = sum(e,axis = 1)
    num_e = num_e[newaxis,:].T

    # Calculate
    U1 = U1*e
    U2 = U2*e
    X = sum(absolute(U1-U2),axis = 1)
    X = (X[newaxis,:].T)/num_e
    X = X[:,:].T
    return(X)