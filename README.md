# [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/)

## What is a Jupyter notebook and where can I get one?

Introduction and a collection of ready-made notebooks are available [here](https://github.com/Dyalog/dyalog-jupyter-notebooks#what-is-a-jupyter-notebook).

## Installation

1. Install Dyalog APL version 15.0 or later.
1. Install Python 3 and Jupyter. There are several ways to do this, for example:
   * Install [Anaconda](https://www.anaconda.com/download/) (Python 3 version), which is available for various platforms.
   * On Debian-based Linux systems, try `sudo apt-get install jupyter-notebook`.
1. [Clone](https://help.github.com/articles/cloning-a-repository/) this repository.
1. Run the following:  
   Linux: `install.sh`  
   Windows: `install.bat`  
1. You may now delete the repository clone, if you wish to do so.

### APL keyboard and language bar

A zero footprint in-browser language bar, key-bindings, and character compositions is available using [a bookmarklet](https://abrudz.github.io/lb/apl). After installation, launch a Jupiter notebook and then click on the bookmarklet.

## Running

1. Start Jupyter notebook:  
   Linux: Open a terminal window  
   Windows: Open the Anaconda Prompt from the Start menu
1. Change directory (`cd mydirectory`) to where you want to place new notebooks or load notebooks from (or a parent directory thereof).
1. Run `jupyter-notebook`.

This will start a web server and try to point your web browser at it. From the web interface you can use the *New* drop-down to create a new Dyalog APL notebook, or navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it.

### Troubleshooting

If you get the message `OSError: [Errno 99] Cannot assign requested address` try:

`jupyter-notebook --ip=0.0.0.0 --port=8080` or some other port number.
