##-----------------------------------------------------------------------------
##  Author          :   Nguyen Chinh Thuy.
##  Date            :   24/09/2017.
##  
##  Interpreter     :   Python 3.5
##  IDE             :   Pycharm Community 2017.2.3
##
##  Description     :   Convert image from polar form to rectangle form.
##						Rubber Sheet transformation.
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
##  Import
##-----------------------------------------------------------------------------
# Libraries
import numpy as np
from math import pi
from matplotlib import pyplot as plt

# Modules


##-----------------------------------------------------------------------------
## Function : Normalize the image in a raw step.
##
## Input    : Iris      : Iris structure.
##            Norm      : Parameters.
##            imsz      : Size of the iris.
##
## Output   : descart   : Rectangle form of the image.
##-----------------------------------------------------------------------------
def descart_raw(Norm, Iris, imsz):
    # Relationship bw 2 cores
    dis = np.sqrt((Iris.cin[0] - Iris.cout[0])**2 + (Iris.cin[1] - Iris.cout[1])**2)
    ang = np.arctan2(Iris.cin[1] - Iris.cout[1], Iris.cin[0] - Iris.cout[0])

    # Get the radius of outer boundary in Polar system
    theta = np.linspace(Norm.ang_start, Norm.ang_end, Norm.N)
    theta = pi * theta / 180
    theta = np.repeat(np.array([theta]), Norm.M + 2, 0)
    R = dis * np.cos(theta - ang) + np.sqrt(Iris.rout**2 - dis**2 * np.sin(theta - ang)**2)

    # Convert gray value
    r = np.array([np.arange(0, Norm.M+2, 1)])
    r = r.transpose() / (Norm.M+1)
    r = np.repeat(r, Norm.N, 1)
    Rp = (1-r)*Iris.rin + r*R

    x = Iris.cin[1] + Rp*np.cos(theta)
    x = np.round(x)
    x = x * (x < imsz[1]) + (x >= imsz[1]) * (imsz[1] - 5)
    x = x * (x >= 1) + (x < 1)
    x = x.astype(int)

    y = Iris.cin[0] - Rp*np.sin(theta)
    y = np.round(y)
    y = y * (y < imsz[0]) + (y >= imsz[0]) * (imsz[0] - 5)
    y = y * (y >= 1) + (y < 1)
    y = y.astype(int)

    val = Iris.polar[y[:], x[:]]
    descart = np.reshape(val, (Norm.M+2, Norm.N))
    descart = np.delete(descart, 0, 0)
    descart = np.delete(descart, Norm.M, 0)

    return descart


##-----------------------------------------------------------------------------
## Function : Plot rectangle form if the iris image.
##
## Input    : descart   : Rectangle form of the iris.
##            fname     : Name of file.
##
## Output   : None.
##-----------------------------------------------------------------------------
def vs(descart, fname):
    fg = plt.figure(3)
    plt.title('[%s].Iris Normalization' % fname[0:8])
    plt.imshow(descart, cmap='gray', interpolation='bicubic')
    plt.show(block=True)

