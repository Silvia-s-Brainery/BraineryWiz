# /* ****************************************************************** **
# **                    BraineryWiz TCL version                         **
# **              by Bijan Sayyafzadeh & Silvia Mazzoni                 **
# **                                                                    **
# **                                                                    **
# ** (C) Copyright 2022, Bijan Sayyafzadeh & Silvia Mazzoni             **
# **       SilviaBrainery.com                                           **
# ** All Rights Reserved.                                               **
# **                                                                    **
# ** Commercial use of this program without express permission of the   **
# ** https://www.silviasbrainery.com/ (BraineryWiz@Gmail.com), is       **
# ** strictly prohibited.  See file 'COPYRIGHT'  in main directory      **
# ** for information on usage and redistribution,  and for a            **
# ** DISCLAIMER OF ALL WARRANTIES.                                      **
# **                                                                    **
# ** Developed by:                                                      **
# **   Bijan SayyafZadeh (B.Sayyaf@yahoo.com)                           **
# **   SilviaMazzoni     (SilviaMazzoni@Yahoo.com)                      **
# **                                                                    **
# ** ****************************************************************** */

import sys

# only work for 64 bit system
if sys.maxsize < 2**31:
    raise RuntimeError('64 bit system is required')

# platform dependent
if sys.platform.startswith('linux'):

    try:
        # from openseespylinux.opensees import *
        raise RuntimeError(sys.platform+' is not supported yet')

    except:
        raise RuntimeError('Failed to import openseespy on Linux.')

elif sys.platform.startswith('win'):

    try:
        from .PlotModel import PlotModel
        from .PlotAnimation import RecorderReset, Record, PlotAnime, PlotAnimeGif
        from .PlotDefo import PlotDefo
        from .PlotModeShape import PlotModeShape
        from .RealTime import RealTimeObj, RealTimeUpdate
        from .FEMWiz import BaseData, DispData, EigenData

    except:
        raise RuntimeError('Use Python Version 3.11.5. If you are not using Anaconda environment instead of installing mentioned version of python you can install older version of BraineryWiz (pip install BraineryWiz==0.91) But it does not work on Anaconda environment!  For more information visit: https://silvia-s-brainery.github.io/BraineryWizDocumentation/Python_Version/installation.html')

elif sys.platform.startswith('darwin'):

    try:
        # from openseespymac.opensees import *
        raise RuntimeError(sys.platform+' is not supported yet')

    except:
        raise RuntimeError('Failed to import openseespy on Mac.')


else:

    raise RuntimeError(sys.platform+' is not supported yet')