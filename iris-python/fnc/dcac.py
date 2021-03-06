"""
Author: Nguyen Chinh Thuy.
Date  : 18/08/2017.
"""


"""
Import
"""
from numpy import *
from math import floor, pi
from scipy.ndimage.filters import generic_filter


"""
Class DCAC

Input:  coreraw     : Raw core of the pupil .
        dcac_param  : Specific DCAC parameters.

Functions:  evolution   : 
            varFilt     : 
            init_dcac   : 
            belongim    : 
            equilibrium : 
            move_dcac   : 
"""
class dcac():
    def __init__(self, coreraw, Seg_dcac_param):
        self.coreraw= coreraw
        self.thres  = Seg_dcac_param.thres
        self.r      = Seg_dcac_param.r
        self.n      = Seg_dcac_param.n
        self.delta  = Seg_dcac_param.delta
        self.deltac = Seg_dcac_param.deltac
        self.lamda  = Seg_dcac_param.lamda
        self.psi    = Seg_dcac_param.psi
        self.M      = Seg_dcac_param.M
        self.N      = Seg_dcac_param.N
        self.eps    = Seg_dcac_param.eps

# """
# Function : Determine core and radius of the pupil based on Discrete Circle
#            Active Contour (DCAC) method.
#
# Input:  im    : The eye image.
#         imsz  : Size of the image.
#
# Output: cin   : Inner core (i-j).
#         rin   : Inner radius.
# """
    def evolution (self, im, imsz):
        # Pre-filter
        imvar = self.varFilt(im,5)
        imthr = ~(imvar > self.thres)

        # Evolution
        delta = self.delta
        param = [self.n, self.lamda, self.psi]
        p = 0
        r = 0
        count = 0
        while delta>0:
            # Start DCAC
            p = zeros([self.M, 2])
            p[1,:] = self.coreraw
            r = zeros(self.M)
            r[1] = self.r
            contour = self.init_dcac(self.coreraw)

            # DCAC evolution
            flgEq = False
            count = 2
            while count<=self.M and self.belongim(contour, imsz):
                p_cur = p[count-1,:]
                r_cur = r[count-1,:]
                contour, p[count,:], r[count,:] = self.move_dcac(contour, p_cur, r_cur,
                                                    delta, param, im, imvar, imthr)
                # Test equilibrium for each N iterations
                if count%self.N==0 and count>=2*self.N:
                    if self.equilibrium(p, r, count):
                        flgEq = True
                        break
                count += 1

            # Stop if an equilibrium is reached
            if(flgEq):
                break

            # Prepare for the next iteration of new delta value
            delta -= self.deltac

        # Package output
        cin = [p[count,0], p[count,1]]
        rin = r[count]
        return cin, rin

# """
# Function : Filter the image by Variance filter.
#
# Input:  im        : The image.
#         sz        : Size of the Variance filter.
#
# Output: imvar     : Filtered image.
# """
    def varFilt (self, im, sz):
        # Mask
        NHOOD = ones([sz, sz])
        r = floor((sz - 1) / 2)
        NHOOD[r+1,r+1] = 0

        # Filter
        imvar = generic_filter(im, std, footprint=NHOOD)
        return imvar

# """
# Function : Initialize the DCAC contour.
#
# Input:  p         : Centroid of the contour (i-j).
#
# Output: contour   : Points of contour (i-j).
# """
    def init_dcac (self, p):
        contour = zeros([self.n, 2])
        t = arange(0, self.n-1, 1) / self.n
        contour[:,0] = p[0] - self.r * sin(2*pi*t)
        contour[:,1] = p[1] + self.r * cos(2*pi*t)
        contour = round(contour)
        return contour

# """
# Function : Test whether the contour still belongs within the image.
#
# Input:  contour   : Points of contour (i-j).
#         imsz      : Size of the image.
#
# Output: isBelong  : Boolean result.
# """
    def belongim (self, contour, imsz):
        up = min(contour[:,0])
        down = max(contour[:,0])
        left = min(contour[:,1])
        right = max(contour[:,1])
        if up<3 or down>imsz(1)-2 or left<3 or right>imsz(2)-2:
            isBelong = False
        else:
            isBelong = True
        return isBelong

# """
# Function : Test whether the contour reaches an equilibrium.
#
# Input:  p         : Array of centroid of DCAC.
#         r         : Array of radius of DCAC.
#         end_idx   : Index of the end of data.
#
# Output: isReach   : Boolean result.
# """
    def equilibrium (self, p, r, end_idx):
        ## Average
        # It requires 2*N samples divided into N last samples, and N previous samples.
        # Then average values are calculated for {i, j, r} of each group.
        i = p[:,0]
        j = p[:,1]
        # Last group
        il = mean(i[end_idx-self.N+1 : end_idx+1])
        jl = mean(j[end_idx-self.N+1 : end_idx+1])
        rl = mean(r[end_idx-self.N+1 : end_idx+1])
        # Previous group
        ip = mean(i[end_idx-2*self.N+1 : end_idx-self.N+1])
        jp = mean(j[end_idx-2*self.N+1 : end_idx-self.N+1])
        rp = mean(r[end_idx-2*self.N+1 : end_idx-self.N+1])

        ## Make a decision
        if abs(il-ip)<=self.eps and abs(jl-jp)<=self.eps and abs(rl-rp)<=self.eps:
            isReach = True
        else:
            isReach = False
        return isReach

# """
# Function : Move DCAC under influence of int-/ext- forces.
#
# Input:  contour       : Current pointset of DCAC (i-j).
#         p             : Current centroid of DCAC (i-j).
#         r             : Current radius of DCAC.
#         delta         : Delta parameter.
#         param         : Specific constant parameters.
#         im            : The gray-scale original image.
#         imvar         : The gray-scale variance image.
#         imthr         : The gray-scale threshold image.
#
# Output: contour, p, r : Updated data.
# """
    def move_dcac (self, contour, p, r, delta, param, im, imvar, imthr):
        ## Necessary functions
        def nearestVal(data, ref):
            dis = abs(data - ref)
            ind = argmin(dis)
            val = data[ind]
            return val

        def Gi(contour, p, im):
            di = dical(contour, p)
            vect = di * (Iical(contour, im) - Iical(contour + di, im))
            return vect

        def Iical(contour, im):
            len = contour.shape[0]
            vect = zeros(len)
            for ind in range(len+1):
                i = contour[ind,0]
                j = contour[ind,1]
                w = im[i-2 : i+3 , j-2 : j+3]
                ref = w(2,2)
                w = w.reshape(25).delete(12)
                vect[ind] = nearestVal(w, ref)
            return vect

        def dical(contour, p):
            vect = p - contour
            dis = sqrt(vect[:,0]**2 + vect[:,1]**2) + finfo(float).eps
            vect = round(vect / dis)
            return vect

        ## Specific constant parameters
        n = param[0]
        lamda = param[1]
        psi = param[2]

        ## Internal force
        t = 2*pi*arange(0,n-1)/n
        apx = zeros(contour.shape)
        apx[:,0] = p[0] - (r + delta)*sin(t)
        apx[:,1] = p[1] + (r + delta)*cos(t)
        F = apx - contour

        ## External force
        G1 = Gi(contour, p, im)
        G2 = Gi(contour, p, imvar)
        G = Iical(contour, imthr) * (psi*G1 + (1-psi)*G2)

        ## Update
        contour = round(contour + lamda*F + (1-lamda)*G)
        p = round(sum(contour,0) / n)
        dis = contour - p
        r = round(sum(sqrt(dis[:,0]**2 + dis[:,1]**2)) / n)
        return contour, p, r
