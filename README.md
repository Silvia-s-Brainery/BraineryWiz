# BraineryWiz

[![PyPI version fury.io](https://badge.fury.io/py/TOpsPy.svg)](https://pypi.python.org/pypi/topspy/)
[![Downloads](https://pepy.tech/badge/topspy)](https://pepy.tech/project/topspy)
[![Downloads](https://pepy.tech/badge/topspy/month)](https://pepy.tech/project/topspy)
[![Downloads](https://pepy.tech/badge/topspy/week)](https://pepy.tech/project/topspy)



**By: [Bijan Sayyafzadeh](b.sayyaf@yahoo.com) and Proudly 
      [Silvia Mazzoni](SilviaMazzoni@yahoo.com)**

This module conatin my functions for openseespy and you can find the doucumentation using shift+Tab key after their name.


### Packages and Functions that Are presented are here with their usage Description:


* **AutoModeler** (SubPackage)

* **TimeHistories** (SubPackage)

* **dynamic** (SubPackage)
   - **LAT2**   : Function for importing acceleration data from *.AT2 PEER Files.
   - **RspSpc** : Function for calculating Linear Response Spectrum for any Time History.
   - **SDFTHA** : Function for calculation the displacement response history of a SDF under any time history acceleration.
* **modeling** (SubPackage)
   - **ElePerPend**    : Function that Provide a vector that is perpendicular to the line from first defined point to the last defined point.
   - **eleAxialForce** : Function That return the Axial force of the defined element.
   - **MultiEl**       : Function That draw any number of elements alog defined nodes. This function also returns middle point/s NodeTag/s and their corresponding coordinates. There is an option that by this option User Can specify that end connection be pinned or fixed!    
   - **GmTVector**     : Function that return the Geometric Transformation Vector of any element using only one Parameter. For more information Review This: https://github.com/BijanSeif/My-Opensees-Jupyter-NoteBooks/blob/main/Auto%20Geometric%20Transform%20Function%20(GmTVector).ipynb



Find more examples in detail: https://github.com/BijanSeif/My-Opensees-Jupyter-NoteBooks
