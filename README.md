This is a [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/).

## Installation

1. Install Dyalog APL version 15.0 or later.
1. Install Python 3 and Jupyter. There are several ways to do this, for example:
   * Install [Anaconda](https://www.anaconda.com/download/) (Python 3 version), which is available for various platforms.
   * On Debian-based Linux systems, try `sudo apt-get install jupyter-notebook`.
1. [Clone](https://help.github.com/articles/cloning-a-repository/) this repository.
1. Create the directory `~/.local/share/jupyter/kernels/dyalog-kernel/` and copy `kernel.json` into it.
1. Create the directory `$(python3 -m site --user-site)/dyalog_kernel/` and copy `__init__.py`, `__main__.py` and `kernel.py` into it.

## Running

From the **Linux** command line, run `jupyter-notebook`. This will start a web server and try to point your web browser at it. From the web interface you can use the New drop-down to create a new Dyalog APL notebook.

This kernel implements some meta-commands:
* `!pw = <n>` tells the APL interpreter to use a page width of _n_ characters.
* `!tutor` lists available tutorials.
* `!tutor <source> <destination>` converts XHTML tutorial `tutor/<source>.html` to notebook `tutor/<destination>.ipynb`.
