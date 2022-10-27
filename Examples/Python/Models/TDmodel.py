
##################################################################
## 3D frame example to show how to render opensees model and 
## plot mode shapes
##
## By - Anurag Upadhyay, PhD Candidate, University of Utah.
## Updated - 09/10/2020
##################################################################

import opsvis as opsplt
import openseespy.opensees as ops
import numpy as np
import topspy.dynamic as bjd

# %matplotlib notebook

from math import asin, sqrt

# set some properties
ops.wipe()

ops.model('Basic', '-ndm', 3, '-ndf', 6)

# properties
# units kip, ft

numBayX = 4
numBayY = 5
numFloor = 6

bayWidthX = 400.0
bayWidthY = 450.0

storyHeights = [150.0 for x in range(numFloor+1)]

E = 295000.0
massX = 0.49
M = 0.
coordTransf = "Linear"  # Linear, PDelta, Corotational
massType = "-lMass"  # -lMass, -cMass

nodeTag = 1

# add the nodes
#  - floor at a time
zLoc = 0.
for k in range(0, numFloor + 1):
	xLoc = 0. 
	for i in range(0, numBayX + 1):
		yLoc = 0.
		for j in range(0, numBayY + 1):
			ops.node(nodeTag, xLoc, yLoc, zLoc)
			ops.mass(nodeTag, massX, massX, 0.01, 1.0e-10, 1.0e-10, 1.0e-10)
			if k == 0:
				ops.fix(nodeTag, 1, 1, 1, 1, 1, 1)
				
			yLoc += bayWidthY
			nodeTag += 1
			
		xLoc += bayWidthX


	if k < numFloor:
		storyHeight = storyHeights[k]
	
	zLoc += storyHeight

# opsplt.plot_model()    
# add column element
ops.geomTransf(coordTransf, 1, 1, 0, 0)
ops.geomTransf(coordTransf, 2, 0, 0, 1)

eleTag = 1
nodeTag1 = 1

for k in range(0, numFloor):
	for i in range(0, numBayX+1):
		for j in range(0, numBayY+1):
			nodeTag2 = nodeTag1 + (numBayX+1)*(numBayY+1)
			iNode = ops.nodeCoord(nodeTag1)
			jNode = ops.nodeCoord(nodeTag2)
			ops.element('elasticBeamColumn', eleTag, nodeTag1, nodeTag2, 50., E, 1000., 1000., 2150., 2150., 1, '-mass', M, massType)
			eleTag += 1
			nodeTag1 += 1


nodeTag1 = 1+ (numBayX+1)*(numBayY+1)
#add beam elements
for j in range(1, numFloor + 1):
	for i in range(0, numBayX):
		for k in range(0, numBayY+1):
			nodeTag2 = nodeTag1 + (numBayY+1)
			iNode = ops.nodeCoord(nodeTag1)
			jNode = ops.nodeCoord(nodeTag2)
			ops.element('elasticBeamColumn', eleTag, nodeTag1, nodeTag2, 50., E, 1000., 1000., 2150., 2150., 2, '-mass', M, massType)
			eleTag += 1
			nodeTag1 += 1
		
	nodeTag1 += (numBayY+1)

nodeTag1 = 1+ (numBayX+1)*(numBayY+1)
#add beam elements
for j in range(1, numFloor + 1):
	for i in range(0, numBayY+1):
		for k in range(0, numBayX):
			nodeTag2 = nodeTag1 + 1
			iNode = ops.nodeCoord(nodeTag1)
			jNode = ops.nodeCoord(nodeTag2)
			ops.element('elasticBeamColumn', eleTag, nodeTag1, nodeTag2, 50., E, 1000., 1000., 2150., 2150., 2, '-mass', M, massType)
			eleTag += 1
			nodeTag1 += 1
		nodeTag1 += 1

# calculate eigenvalues & print results
# numEigen = 7
# eigenValues = ops.eigen(numEigen)
# PI = 2 * asin(1.0)

###################################
#### Display the active model with node tags only
# opsplt.plot_model("nodes")

####  Display specific mode shape with scale factor of 300 using the active model
# opsplt.plot_modeshape(5, 300)

###################################
# To save the analysis output for deformed shape, use createODB command before running the analysis
# The following command saves the model data, and output for gravity analysis and the first 3 modes 
# in a folder "3DFrame_ODB"

# opsplt.createODB("3DFrame", "Gravity", Nmodes=3)

# Define Static Analysis
# create SOE
ops.system("BandSPD")
ops.numberer("RCM")
ops.constraints("Plain")
ops.timeSeries('Constant', 1)
ops.pattern('Plain', 1, 1)
ops.load(186, 0, 0, -1000, 0, 0, 0)
ops.integrator('LoadControl',1)
ops.algorithm('Linear')
ops.analysis('Static')

# Run Analysis
ops.analyze(1)
ops.reactions()


print(ops.nodeReaction(6))

# IMPORTANT: Make sure to issue a wipe() command to close all the recorders. Not issuing a wipe() command
# ... can cause errors in the plot_deformedshape() command.



####################################
### Now plot mode shape 2 with scale factor of 300 and the deformed shape using the recorded output data

# opsplt.plot_modeshape(2, 300, Model="3DFrame")

# opsplt.plot_defo()



G = 3860
[dt,TH]=bjd.LAT2('models/1')

print(dt)
ops.timeSeries('Path', 2, '-dt', dt, '-values', *TH, '-factor', G) # define acceleration vector from file (dt=0.005 is associated with the input file gm)
ops.pattern('UniformExcitation', 2, 2, '-accel', 2)     # define where and how (pattern tag, dof) acceleration is applied

# set damping based on first eigen mode
freq = ops.eigen(1)[0]**0.5
dampRatio = 0.05
ops.rayleigh(0., 0., 0., 2*dampRatio/freq)

# create the analysis
ops.wipeAnalysis()    # clear previously-define analysis parameters
ops.constraints('Plain')    # how it handles boundary conditions
ops.numberer('Plain')    # renumber dof's to minimize band-width (optimization), if you want to
ops.system('BandGeneral') # how to store and solve the system of equations in the analysis
ops.algorithm('Linear') # use Linear algorithm for linear analysis
ops.integrator('Newmark', 0.5, 0.25)    # determine the next time step for an analysis
ops.analysis('Transient')   # define type of analysis: time-dependent
print('done')


