##-----------------------------------------------------------------------------
##  Author          :   Nguyen Chinh Thuy.
##  Date            :   18/09/2017.
##  
##  Interpreter     :   Python 3.5
##  IDE             :   Pycharm Community 2017.2.1
##
##  Description     :   Extract feature vectors from iris images.
##
##  Input           :   xxxxxxxxxx.
##  Output          :   xxxxxxxxxx.
##-----------------------------------------------------------------------------



##-----------------------------------------------------------------------------
##  Import
##-----------------------------------------------------------------------------
import ws
import segment


##-----------------------------------------------------------------------------
##  Database
##-----------------------------------------------------------------------------
smp_db = '../sample_db/'


##-----------------------------------------------------------------------------
##   Class iris
##
##   Input:  cin		: Inner core of the iris.
## 		     cout	    : Outer core of the iris.
## 		     rin		: Inner radius of the iris.
## 		     rout	    : Outer radius of the iris.
## 		     polar	    : Polar form of the iris.
## 		     descartes  : Descartes form of the iris.
##-----------------------------------------------------------------------------
class iris():
    def __init__(self, cin, cout, rin, rout, polar, descartes):
        self.cin = cin
        self.cout = cout
        self.rin = rin
        self.rout = rout
        self.polar = polar
        self.descartes = descartes


##-----------------------------------------------------------------------------
##  Loop
##-----------------------------------------------------------------------------
# ID and sample of images
idstart   = 1
idend     = 20
sampstart = 1
sampend   = 20

# Loop
for m in range(idstart, idend+1):
    for n in range(sampstart, sampend+1):

# Create workspace: See [ws.py] for more information
        # Parameters
        Ws_isPlot = False            # True 	False

        # Make file name
        k=n
        if(k > 10):
            k=k-10
            lr='R'
        else:
            lr='L'
        Ws_fname = "S10%.2d%s%.2d.jpg" % (m, lr, k)

        # Read image
        print('>>> Examine %s\n' % Ws_fname)
        im, imsz = ws.readim(Ws_fname, smp_db)
        if Ws_isPlot:
            ws.vs(im, imsz, Ws_fname)


# Segmentation: See [segment.py] for more information.
        # Parameters
        class Seg():
            isPlot  = True         # True     False
            wid     = 40
            jDelta  = 80
            err     = 3
            thres   = 150
            r       = 20
            n       = 30
            delta   = 2
            deltac  = 0.1
            lamda   = 0.5
            psi     = 0.9
            M       = 1500
            N       = 250
            eps     = 1

        # Implementation
        bound, coreraw      = segment.raw_pupil(im, Seg.err)
        cin, rin            = segment.refined_pupil(im, imsz, bound, coreraw, Seg)
        cout, rout, polar   = segment.iris(im, imsz, cin, rin, Seg)
        
        # Package
        Iris = iris(cin, cout, rin, rout, polar, None)

        # Visualize
        if Seg.isPlot:
            segment.vs(im, Ws_fname, cin, cout, rin, rout)


# # Normalization
#         Norm.isPlot=false       # True False
#         Norm.M = 64
#         Norm.N = 512
#         normalization
#
# # Enhancement
#         Enh.isPlot=false       # True False
#         enhancement
#
# # Feature extraction
#         Extr.isPlot=false       # True False
#         Extr.R=1
#         Extr.flgFill=0
#         extraction
#
#
# # Matching
#         % matching
#
# # Time measurement
#         [timval,timname]=dispTime(time)
#         timplval=[timplval;timval]
#         timplname=timname


##-----------------------------------------------------------------------------
##  Time analysis
##-----------------------------------------------------------------------------
