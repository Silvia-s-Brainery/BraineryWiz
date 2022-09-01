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
    url="https://github.com/BijanSeif - https://github.com/silviamazzoni",
    keywords=['python', 'opensees', 'Modeling', 'Dynamic'],
    classifiers=[
        'Programming Language :: Python :: 3.9',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Operating System :: Microsoft :: Windows'
    ],

)
