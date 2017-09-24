##-----------------------------------------------------------------------------
##  Author          :   Nguyen Chinh Thuy.
##  Date            :   18/09/2017.
##  
##  Interpreter     :   Python 3.5
##  IDE             :   Pycharm Community 2017.2.1
##
##  Description     :   Determine the location of iris from the eye image.
##						Hybrid method (Histogram binary + Discrete Active Contour).
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
##  Import
##-----------------------------------------------------------------------------
from cv2 import *
import matplotlib.pyplot as plt
from numpy import *
from scipy.ndimage import measurements

# Modules
from fnc import histoBin, core, quality, radius, edge
from fnc.dcac import dcac
from fnc.fastHough import fh


##-----------------------------------------------------------------------------
## 	Function : Raw detection of pupil from the eye image.
##
## 	Input    : im 		: Read image.
##             err 		: The minimum difference that can be ignored.
##
## 	Output   : bound   	: Bound of the pupil.
##             coreraw 	: Raw core of the pupil.
##-----------------------------------------------------------------------------
def raw_pupil(im, err):
    # Binarize the image and get the largest object
    imbin = histoBin.binarize(im, err, 1)
    labels, nbr_obj = measurements.label(imbin)
    obj = zeros(nbr_obj, dtype=object)
    area = zeros(nbr_obj)
    for i in range(nbr_obj):
        obj[i] = (labels==(i+1))
        area[i] = sum(obj[i])
    ind_maxarea = argmax(area)
    obj = obj[ind_maxarea]
    obj = 255*obj.astype(uint8)

    # Get the boundary of the largest object
    _, bound, _ = findContours(obj, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE)
    bound = bound[0]
    coreraw = core.core_outbound(bound).astype(int)

    # Return
    return bound, coreraw


##-----------------------------------------------------------------------------
## 	Function : Refined detection of pupil from the eye image.
##
## 	Input    : im 		: The eye image.
##             imsz   	: Size of the image.
##             bound   	: Bound of the pupil (x-y).
##             coreraw 	: Raw core of the pupil (i-j).
##
## 	Output   : cin		: Inner core (i-j).
## 		       rin		: Inner radius.
##-----------------------------------------------------------------------------
def refined_pupil(im, imsz, bound, coreraw, Seg_dcac_param):
    if not quality.test(bound, coreraw, 10, 10):
        dcac_seg = dcac(coreraw, Seg_dcac_param)
        cin, rin = dcac_seg.evolution(im, imsz)
    else:
        cin = coreraw
        rin = int(radius.cal(bound, coreraw))
    return cin, rin


##-----------------------------------------------------------------------------
## 	Function : Detect region of iris from the eye image.
##
## 	Input    : im 					: The eye image.
##             imsz   				: Size of the image.
##             cin					: Inner core (i-j).
##             rin					: Inner radius.
##             Seg_fastHough_param	: Specific parameters of FastHough method.
##
## 	Output   : cout					: Outer core (i-j).
## 		   	   rout					: Outer radius.
## 		       polar				: Polar form of the iris.
##-----------------------------------------------------------------------------
def iris(im, imsz, cin, rin, Seg_fastHough_param):
    edg = edge.canny(im, sz=5, std=1.2)
    fh_seg = fh(cin, 2*rin, Seg_fastHough_param)
    l_msk, r_msk, up, down = fh_seg.outerMsk(imsz)
    l_set, r_set = fh_seg.findOuterSets(edg, l_msk, r_msk, up, down)
    cout, rout = fh_seg.findBound(l_set, r_set)
    polar = fh_seg.getIrisPolar(im, imsz, cin, cout, rin, rout)
    return cout, rout, polar


##-----------------------------------------------------------------------------
## 	Function : Plot the eye image alongside core and two circles bounding the
##             iris region.
##
## 	Input    : im    	: Read image.
##             fname 	: Name of file eye image.
##             cin		: Inner core (i-j).
##             cout		: Outer core (i-j).
##             rin 		: Inner radius.
##             rout 	: Outer radius.
##
## 	Output   : None.
##-----------------------------------------------------------------------------
def vs(im, fname, cin, cout, rin, rout):
    # Plot the eye image
    fg = plt.figure(2)
    plt.title('[%s].Iris segmentation' % fname[0:8])
    plt.imshow(im, cmap='gray', interpolation='bicubic')
    plt.hold(True)

    # Plot inner core and outer core
    plt.plot(cin[1], cin[0], 'rx')
    plt.plot(cout[1], cout[0], 'bo')

    # Plot inner circle and outer circle
    cir_in = plt.Circle((cin[1],cin[0]), rin, color='r', fill=False)
    cir_out = plt.Circle((cout[1],cout[0]), rout, color='b', fill=False)
    fg.gca().add_artist(cir_in)
    fg.gca().add_artist(cir_out)
    plt.show(block=True)
    # plt.savefig('test_result/segmentation/%s.jpg' % fname[0:8])
    # plt.close("all")

