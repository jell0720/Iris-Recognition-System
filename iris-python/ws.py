##
##	[1]. Create workspace for the project.
##	Author: Nguyen Chinh Thuy.
##	Date  : 17/08/2017.
##


##
## Import
##
import cv2
from matplotlib.pyplot import *


##
## Function : Read eye image.
##
## Input    : fname : Name of file eye image.
##			  dbpath: Path of sample database.
##
## Output   : im    : Read image.
##            imsz  : Size of the image.
##
def readim(fname, dbpath):
	im = cv2.imread(dbpath + fname, 0)
	imsz = [im.shape[0], im.shape[1]]
	return im, imsz


##
## Function : Plot read image.
##
## Input    : im    : Read image.
##            imsz  : Size of the image.
##            fname : Name of file eye image.
##
## Output   : None.
##
def vs(im, imsz, fname):
	figure(1)
	title('[%s].Input image [%dx%d]' % (fname[0:8],imsz[0],imsz[1]))
	imshow(im, cmap='gray', interpolation='bicubic')
	show()
