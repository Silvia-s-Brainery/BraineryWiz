# [BraineryWiz](https://www.silviasbrainery.com/brainerywiz)

[![PyPI version fury.io](https://badge.fury.io/py/BraineryWiz.svg)](https://pypi.python.org/pypi/BraineryWiz/)
[![Downloads](https://pepy.tech/badge/BraineryWiz)](https://pepy.tech/project/BraineryWiz)
[![Downloads](https://pepy.tech/badge/BraineryWiz/month)](https://pepy.tech/project/BraineryWiz)
[![Downloads](https://pepy.tech/badge/BraineryWiz/week)](https://pepy.tech/project/BraineryWiz)

**Main WebPage**: https://www.silviasbrainery.com/brainerywiz

**BraineyWiz Email Address:** <BraineryWiz@Gmail.com>


**Description:**

***An Element Independent Package for plotting FEM models***

## By: 

- **Bijan Sayyafzadeh**: [Github](https://github.com/BijanSeif), Email: <B.Sayyaf@yahoo.com>
- **Silvia Mazzoni**: [Github](https://github.com/silviamazzoni), Email: <SilviaMazzoni@yahoo.com>


## Instalation Steps:
- Using command prompt using the following command:

```
pip install BraineryWiz
```
- For anaconda users:

```
conda ...
```

## How to use:
- User should import package: 

```
import BraineryWiz as bz
```
- for Jupyter users:

```
import BraineryWiz.Jupyter as bz
```

## BraineryWiz commands and options:

**bz.PlotModel** command options:
- draw_nodes=True

        Boolean that determines does nodes be drawn or not
        
- show_nodes_tag=False

        Boolean that determines does the nodes tag be shown or not
        
- show_elemens_tag=False

        Boolean that determines does the elements tag be shown or not
        
- onhover_message=False

    	Boolean that says Do the hovers data be shown or not    
        
-  title='BraineryWiz'

        Title of the figure
    
- fig_width=1000

        determines the width of the Figure
        
- fig_height=800

        determines the height od the figure
        
- elements_data_tag=[]

        List of the elements tag that you want to add some data to be shown on them
    
- elements_data=[]

        List of the data corresponding to the elements that you want to be shown on each element
        
- nodes_data_tag=[]

        List of the nodes tag that you want to add some data to be shown on them
        
- nodes_data=[]

        List of the data corresponding to the nodes that you want to be shown on each element
        
- image_type=None

        (Types: 'png' |'jpeg' |'svg' |'webp') This parameter sets the format of the image to be downloaded, if we choose to download an image.
    
- image_filename='BraneryWz'

        Filename of the download image
        
- quivers_size=None

        If None means do not plot quivers else plot quivers with entered size by the user
        
- plot_fibers=False

        Boolean that shows plot Fiber points or not
