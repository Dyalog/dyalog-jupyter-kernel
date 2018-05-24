Testing environment

- Ubuntu 16.04LST 64-bit
- Anaconda 1.6.3 (Python 3 version)
- Jupyter 4.3.0
- Dyalog APL/S - 64 version 16.0.29464 unicode edition




Files:

install.py:
please IGNORE install.py. At the moment it is not testet. Do not attemp to execute it. Thank you. 


-------------------------
kernel.json
-------------------------
manualy copy this file into the Jupyter kernels config dir e.g. :
~/.local/share/jupyter/kernels/dyalog-kernel/

-------------------------
__init__.py
__main__.py
kernel.py
/tutors/*
-------------------------
manualy copy all of this kernel files into anacondas site-packages e.g. :
~/anaconda3/lib/python3.6/site-packages/dyalog_kernel




-----------------------------------------------

Presuming Dyalog APL 16.0 unicode  has been installed, please start it:
- Dyalog APL kernel will handle instance of Dyalog executable. No need to manualy start Dyalog

- cd into your home dir, launch Jupyter notebook:
		jupiter notebook
		
- from Jupyter web frontend, launch Dyalog APL kernel, or multiple APL kernels.... enjoy
-----------------------------------------------


from the started notebook:

!tutor  <shift-enter>
will list available tutors

!tutor <source> <destination>  <shift-enter>
will convert XHTML tutor file from /tutor/ dir  to  .ipynb file. <source> and <destination> are file names WITHOUT extension .html and .ipynb

!pw = n  <shift-enter>, where n is an integer will send RIDE pw message. 

------------------------------------------------
Requested Python libraries (not sure what anaconda3 is installing by default) :

import json
import os
import socket
import sys
import time

from pathlib import Path
from ipykernel.kernelbase import Kernel
from dyalog_kernel import __version__
from collections import deque
from notebook.services.config import ConfigManager
from os.path import isfile, join
from bs4 import BeautifulSoup
