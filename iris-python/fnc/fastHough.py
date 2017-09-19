##-----------------------------------------------------------------------------
## Author       : Nguyen Chinh Thuy.
## Date         : 18/08/2017.
##  
## Interpreter  : Python 3.5
## IDE          : Pycharm Community 2017.2.1
##
## Description  : This file includes function correlating to [Segmentation]
##                section, with the method of "Fast Hough transform".
##
## Input        : xxxxxxxxxx.
## Output       : xxxxxxxxxx.
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
##  Import
##-----------------------------------------------------------------------------
from numpy import round, zeros, arange, argmax, array, sqrt, reshape
from numpy.matlib import repmat
from scipy.stats import mode


##-----------------------------------------------------------------------------
## Class fh (Fast Hough)
##
## Input    : core            : Core of side-masks (i-j).
##            hei             : Height of side-masks.
##            fastHough_param : Specific fastHough parameters.
##
## Output   : outerMsk        :
##-----------------------------------------------------------------------------
class fh():
    def __init__(self, core, hei, fastHough_param):
        self.core = core
        self.hei = hei
        self.wid = fastHough_param.wid
        self.jDelta = fastHough_param.jDelta


##-----------------------------------------------------------------------------
## Function : Create two side-masks (left and right) for finding outer
##            boundary of the iris.
##
## Input    : imsz       : Size of the eye image.
##
## Output   : lmsk, rmsk : Two side-masks.
##            up, down   : Two limited j-position of the two side-masks.
##-----------------------------------------------------------------------------
    def outerMsk (self, imsz):
        # Left mask
        right1 = int(self.core[1] - self.jDelta)
        if right1 < 1:
            right1 = 10
        left1 = int(right1 - self.wid)
        if left1 < 1:
            left1 = 10
        up = int(self.core[0] - round(self.hei / 2))
        if up < 1:
            up = 10
        down = int(self.core[0] + round(self.hei / 2))
        if down >= imsz[0]:
            down = int(imsz[0] - 10)

        # Right mask
        left2 = int(self.core[1] + self.jDelta)
        if left2 >= imsz[1]:
            left2 = int(imsz[1] - 10)
        right2 = int(left2 + self.wid)
        if right2 >= imsz[1]:
            right2 = int(imsz[1] - 10)

        # Create mask
        lmsk = zeros(imsz)
        rmsk = zeros(imsz)
        lmsk[up : down , left1 : right1] = 1
        rmsk[up : down , left2 : right2] = 1
        return lmsk, rmsk, up, down


##-----------------------------------------------------------------------------
## Function : Find two sets of points on the outer boundary of iris within
##            two side-masks.
##
## Input    : edg           : Edge image from the eye image.
##            l_msk, r_msk  : Two side-masks.
##            up, down      : Two limited j-position of the two side-masks.
##
## Output   : l_set, r_set  : Two sets of points (i-j).
##-----------------------------------------------------------------------------
    def findOuterSets (self, edg, l_msk, r_msk, up, down):
        # Left set of points
        l_set = zeros([down - up + 1, 2])
        l_set[:,0] = arange(up, down+1)
        region = edg * l_msk
        l_set[:, 1] = argmax(region[up:down+1], axis=1)

        # Right set of points
        r_set = zeros([down - up + 1, 2])
        r_set[:,0] = arange(up, down+1)
        region = edg * r_msk
        r_set[:, 1] = argmax(region[up:down + 1], axis=1)
        return l_set, r_set


##-----------------------------------------------------------------------------
## Function : Find outer boundary of the iris.
##
## Input    : l_set, r_set : Two point sets within two side-masks.
##
## Output   : cout, rout   : Core and radius of the outer boundary (i-j).
##-----------------------------------------------------------------------------
    def findBound (self, l_set, r_set):
        # Voting matrices
        m = l_set.shape[0]
        n = r_set.shape[0]
        X_left = repmat(array([l_set[:,1]]).transpose(), 1, n)
        X_right = repmat(r_set[:,1], m, 1)
        Y_left = repmat(array([l_set[:,0]]).transpose(), 1, n)
        Y_right = repmat(r_set[:,0], m, 1)

        X = round((X_left + X_right) / 2)
        Y = round((Y_left + Y_right) / 2)
        R = sqrt((X_left - X_right)**2 + (Y_left - Y_right)**2)

        # Result
        cout = zeros(2)
        cout[0] = mode(reshape(Y, Y.shape[0]*Y.shape[1]))[0][0]
        cout[1] = mode(reshape(X, X.shape[0]*X.shape[1]))[0][0]
        rout = mode(reshape(R, R.shape[0]*R.shape[1]))[0][0] / 2
        return cout, rout


##-----------------------------------------------------------------------------
## Function : Get the polar form of the Iris.
##
## Input    : im     : The eye image.
##            imsz   : Size of the eye image.
##
## Output   : polar  : Polar form of the iris.
##-----------------------------------------------------------------------------
    def getIrisPolar (self, im, imsz, cin, cout, rin, rout):
        # Prepare
        x = arange(1, imsz[1]+1)
        x = repmat(x, imsz[0], 1)
        y = arange(1, imsz[0]+1)
        y = repmat(array([y]).transpose(),1, imsz[1])
        xin = x - cin[1]
        xout = x - cout[1]
        yin = y - cin[0]
        yout = y - cout[0]
        ri = sqrt(xin**2 + yin**2)
        ro = sqrt(xout**2 + yout**2)

        # Segment the iris region
        polar = im * (ri > rin) * (ro < rout)
        return polar

