##
##	Author: Nguyen Chinh Thuy.
##	Date  : 17/08/2017.
##


##
## Import
##
from numpy import mean, uint8
from scipy.signal import medfilt2d


##
## Function : Binary the image bases on local histogram.
##
## Input    : im    : Read image.
##            err   : The minimum difference that can be ignored.
##            flgInv: Inverse the binary result?
##
## Output   : imbin : Binarized image.
##
def binarize (im, err, flgInv=False):
    ##
    ## Function : Calculate the threshold of an image.
    ##
    ## Input    : im    : Read image.
    ##            err   : The minimum difference that can be ignored.
    ##
    ## Output   : thres : Threshold of the image.
    ##
    def threshold (im, err):
        # Initialize the threshold
        thres = mean(im)
        thresnew = thres + err + 1
        # Loop for finding a convergence of threshold
        while(abs(thresnew - thres) > err):
            thres = thresnew
            G1 = im > thres
            G2 = 1 - G1
            G1 = im * G1
            G2 = im * G2
            thresnew = (mean(G1) + mean(G2)) / 2
        return thresnew

    # Smooth and binarize the image
    imf = medfilt2d(im)
    thres = threshold(imf, err)
    imbin = imf > thres

    # Inverse?
    if flgInv:
        imbin = ~imbin
    imb = imbin.astype(uint8)
    imbin = medfilt2d(imb)
    return imbin
