This is a [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/).

## Installation

1. Install Dyalog APL version 15.0 or later.
1. Install Python 3 and Jupyter. There are several ways to do this, for example:
   * Install [Anaconda](https://www.anaconda.com/download/) (Python 3 version), which is available for various platforms.
   * On Debian-based Linux systems, try `sudo apt-get install jupyter-notebook`.
1. [Clone](https://help.github.com/articles/cloning-a-repository/) this repository.
1. Create the directory following directory and copy `kernel.json` into it:  
   Linux: `~/.local/share/jupyter/kernels/dyalog-kernel/`  
   Windows: `%APPDATA%\jupyter\kernels\dyalog-kernel\`
1. Create the following directory and copy `__init__.py`, `__main__.py` and `kernel.py` into it:  
   Linux: `$(python3 -m site --user-site)/dyalog_kernel/`  
   Windows: `%APPDATA%\Python\Python36\site-packages\dyalog_kernel\`

## Running

From the **Linux** command line, run `jupyter-notebook`. This will start a web server and try to point your web browser at it. From the web interface you can use the New drop-down to create a new Dyalog APL notebook.

On **Windows** if you have installed Anaconda, open the Anaconda Navigator from the Start menu and launch Jupyter notebook from the navigator home screen.