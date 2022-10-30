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

from setuptools import setup, find_packages

import subprocess
import os

BraineryWiz_version = (
    subprocess.run(["git", "describe", "--tags"], stdout=subprocess.PIPE)
    .stdout.decode("utf-8")
    .strip()
)

assert "." in BraineryWiz_version

assert os.path.isfile("BraineryWiz/version.py")
with open("BraineryWiz/VERSION", "w", encoding="utf-8") as fh:
    fh.write(f"{BraineryWiz_version}\n")



with open("README.md", "r") as fh:
    long_description = fh.read()


setup(
    name="BraineryWiz",
    version=BraineryWiz_version,
    author="Bijan Sayyafzadeh - Silvia Mazzoni",
    author_email="<BraineryWiz@Gmail.com>",
    description="OpenSees Plotting Package",
    long_description_content_type="text/markdown",
    long_description=long_description ,
    package_data={
        "":["*.jpg","*.at2","*.pyd"],
        # If any package contains *.txt or *.rst files, include them:
        #"": ["*.txt", "*.rst"],
        # And include any *.msg files found in the "hello" package, too:
        #"hello": ["*.msg"],
    },
    packages=find_packages(),
    install_requires=['openseespy', 'eseesminipy','numpy','plotly','scipy','pillow','kaleido','tqdm'],
    url="https://github.com/Silvia-s-Brainery/BraineryWiz",
    keywords=['python', 'opensees', 'Modeling', 'Dynamic'],
    classifiers=[
        'Programming Language :: Python :: 3.9',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Operating System :: Microsoft :: Windows'
    ],

)
