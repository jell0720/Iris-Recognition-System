from numpy import *
from imDist import imDist
"""
Do Tieu Thien
19/9/2107
-------------
Input:  V_all	: Feature matrix of size [400,1920].
        E_all	: Effective-element matrix of all sample images [4,20,160000].
        Y		: Map vector of indeces considered in the ribbon set [1,96].
Output: DI_all	: Distances of sample images are arranged to form DI matrix.
"""

def DIMatrix(V_all, E_all, Y):
    DI_all = zeros((20,20,400))
    for im_id1 in range(400):
        # First time
        featureVec1 = V_all[im_id1,:]
        for i in range(20):
            for j in range(20):
                # Index of the second image
                im_id2 =
                # Skip if the second index is same as the first index
                if im_id2 == im_id1:
                    DI_all[i,j,im_id1] = 0
                    continue

                # Skip if the second index is smaller than the first index (combination order)
                if im_id2 < im_id1:
                    [m,n] = unravel_index(im_id1,[20,20])
                    DI_all[i,j,im_id1] = DI_all[m,n,im_id2]
                    continue

                # Calculate distance bw two image
                featureVec2 = V_all[im_id2,:]
                ind = 400*(im_id1-1) + im_id2
                DI_all[i,j,im_id1] = imDist(featureVec1,featureVec2,E_all[:,:,ind],Y)