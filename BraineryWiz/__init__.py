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
import os
import shutil


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
    
    #Get the current directory path
    curfol=os.path.dirname(__file__)
    
    try:
        
        #initially import brainerywiz with current files. if it worked so worked else we dive into exceptions
        from .PlotModel import PlotModel
        from .PlotAnimation import RecorderReset, Record, PlotAnime, PlotAnimeGif
        from .PlotDefo import PlotDefo
        from .PlotModeShape import PlotModeShape
        from .RealTime import RealTimeObj, RealTimeUpdate
        from .FEMWiz import BaseData, DispData, EigenData
    
    except:
        
        try:
            # print('python 11')

            #Remove files if exist
            if os.path.isfile('_DFunctions.pyd'): os.remove('_DFunctions.pyd')
            if os.path.isfile('_PlotData.pyd'): os.remove('_PlotData.pyd')
            if os.path.isfile('PlotModel.pyd'): os.remove('PlotModel.pyd')    
            if os.path.isfile('PlotAnimation.pyd'): os.remove('PlotAnimation.pyd')
            if os.path.isfile('PlotDefo.pyd'): os.remove('PlotDefo.pyd')
            if os.path.isfile('PlotModeShape.pyd'): os.remove('PlotModeShape.pyd')
            if os.path.isfile('RealTime.pyd'): os.remove('RealTime.pyd')
            if os.path.isfile('FEMWiz.pyd'): os.remove('FEMWiz.pyd')
            # print('remove has done')              
                
            #Rename files from the above version  
            shutil.copy(curfol+"\\"+"_DFunctions.cp311-win_amd64.pyd",curfol+"\\"+'_DFunctions.pyd');
            shutil.copy(curfol+"\\"+"_PlotData.cp311-win_amd64.pyd",curfol+"\\"+'_PlotData.pyd');
            shutil.copy(curfol+"\\"+"PlotModel.cp311-win_amd64.pyd",curfol+"\\"+'PlotModel.pyd');
            shutil.copy(curfol+"\\"+"PlotAnimation.cp311-win_amd64.pyd",curfol+"\\"+'PlotAnimation.pyd');
            shutil.copy(curfol+"\\"+"PlotDefo.cp311-win_amd64.pyd",curfol+"\\"+'PlotDefo.pyd');
            shutil.copy(curfol+"\\"+"PlotModeShape.cp311-win_amd64.pyd",curfol+"\\"+'PlotModeShape.pyd');
            shutil.copy(curfol+"\\"+"RealTime.cp311-win_amd64.pyd",curfol+"\\"+'RealTime.pyd');
            shutil.copy(curfol+"\\"+"FEMWiz.cp311-win_amd64.pyd",curfol+"\\"+'FEMWiz.pyd');
            # print('rename has done')


            from .PlotModel import PlotModel
            from .PlotAnimation import RecorderReset, Record, PlotAnime, PlotAnimeGif
            from .PlotDefo import PlotDefo
            from .PlotModeShape import PlotModeShape
            from .RealTime import RealTimeObj, RealTimeUpdate
            from .FEMWiz import BaseData, DispData, EigenData
            

        except:

            try:
                # print('python 10')

                #Remove files if exist
                if os.path.isfile('_DFunctions.pyd'): os.remove('_DFunctions.pyd')
                if os.path.isfile('_PlotData.pyd'): os.remove('_PlotData.pyd')
                if os.path.isfile('PlotModel.pyd'): os.remove('PlotModel.pyd')    
                if os.path.isfile('PlotAnimation.pyd'): os.remove('PlotAnimation.pyd')
                if os.path.isfile('PlotDefo.pyd'): os.remove('PlotDefo.pyd')
                if os.path.isfile('PlotModeShape.pyd'): os.remove('PlotModeShape.pyd')
                if os.path.isfile('RealTime.pyd'): os.remove('RealTime.pyd')
                if os.path.isfile('FEMWiz.pyd'): os.remove('FEMWiz.pyd')
                # print('remove has done')              

                #Rename files from the above version  
                shutil.copy(curfol+"\\"+"_DFunctions.cp310-win_amd64.pyd",curfol+"\\"+'_DFunctions.pyd');
                shutil.copy(curfol+"\\"+"_PlotData.cp310-win_amd64.pyd",curfol+"\\"+'_PlotData.pyd');
                shutil.copy(curfol+"\\"+"PlotModel.cp310-win_amd64.pyd",curfol+"\\"+'PlotModel.pyd');
                shutil.copy(curfol+"\\"+"PlotAnimation.cp310-win_amd64.pyd",curfol+"\\"+'PlotAnimation.pyd');
                shutil.copy(curfol+"\\"+"PlotDefo.cp310-win_amd64.pyd",curfol+"\\"+'PlotDefo.pyd');
                shutil.copy(curfol+"\\"+"PlotModeShape.cp310-win_amd64.pyd",curfol+"\\"+'PlotModeShape.pyd');
                shutil.copy(curfol+"\\"+"RealTime.cp310-win_amd64.pyd",curfol+"\\"+'RealTime.pyd');
                shutil.copy(curfol+"\\"+"FEMWiz.cp310-win_amd64.pyd",curfol+"\\"+'FEMWiz.pyd');
                # print('rename has done')
                
                from .PlotModel import PlotModel
                from .PlotAnimation import RecorderReset, Record, PlotAnime, PlotAnimeGif
                from .PlotDefo import PlotDefo
                from .PlotModeShape import PlotModeShape
                from .RealTime import RealTimeObj, RealTimeUpdate
                from .FEMWiz import BaseData, DispData, EigenData       


            except:

                raise RuntimeError('Use Python Version 3.11.5 or 3.10.4. If you are not using Anaconda environment instead of installing mentioned versions of python. For more information visit: https://silvia-s-brainery.github.io/BraineryWizDocumentation/Python_Version/installation.html')

elif sys.platform.startswith('darwin'):

    try:
        # from openseespymac.opensees import *
        raise RuntimeError(sys.platform+' is not supported yet')

    except:
        raise RuntimeError('Failed to import openseespy on Mac.')


else:

    raise RuntimeError(sys.platform+' is not supported yet')