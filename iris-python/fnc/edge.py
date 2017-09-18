"""
Author: Nguyen Chinh Thuy.
Date  : 18/08/2017.
"""


"""
Import
"""
from numpy import sqrt, gradient, mgrid, exp, max
from scipy.ndimage import convolve


"""
Function: Test whether the raw pupil detection is good enough.

Input:  im      : The image.
        sz      : Size of the filter.
        std     : Derivative standard.

Output: im_edg  : Boolean result.
"""
def canny (im, sz = 3, std = 1):
    f = fspecial_gauss(sz, std)
    mskY, mskX = gradient(f)
    Gx = convolve(im, mskX)
    Gy = convolve(im, mskY)
    im_edg = sqrt(Gx**2 + Gy**2)
    im_edg = im_edg * 255 / max(im_edg)
    return im_edg.astype(int)


"""
Function to mimic the 'fspecial' gaussian MATLAB function
"""
def fspecial_gauss(size, sigma):
    x, y = mgrid[-size // 2 + 1:size // 2 + 1 , -size // 2 + 1:size // 2 + 1]
    g = exp(-((x**2 + y**2) / (2.0*sigma**2)))
    return g / g.sum()
