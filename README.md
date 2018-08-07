# [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/)

## What is a Jupyter notebook and where can I get one?

Introduction and a collection of ready-made notebooks are available [here](https://github.com/Dyalog/dyalog-jupyter-notebooks#what-is-a-jupyter-notebook).

## Installation

1. [Install Dyalog APL](https://www.dyalog.com/download-zone.htm) version 15.0 or later.
1. Install Python 3 and Jupyter as follows:  
   On any platform, you can install [Anaconda](https://www.anaconda.com/download/) (Python 3.X version)  
   On Debian-based Linux systems you may instead do `sudo apt-get install jupyter-notebook`
1. Download this repository as a zip: Click [here](https://github.com/Dyalog/dyalog-jupyter-kernel/archive/master.zip) to do so.
1. After downloading, extract the contents and open the *dyalog-jupyter-kernel-master* directory.
1. Run the following:  
   Windows: `install.bat`  
   Linux and macOS: `install.sh`

### APL keyboard and language bar

You can add an APL language bar which includes key-bindings and character compositions to your browser. It is available [here](https://abrudz.github.io/lb/apl) in the form of a bookmark. After installation, launch a Jupyter notebook and then click on the bookmark.

## Running

Jupyter Notebook uses a web interface. It has a drop-down button labeled *New* where you can choose to create a new Dyalog APL notebook. You can also navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it.
To start a web server and try to point your web browser at it, proceed as follows:

### Windows
1. Open *Jupyter Notebook* from the Start menu

This will start a web server and try to point your web browser at it. From the web interface you can use the *New* drop-down to create a new Dyalog APL notebook, or navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it. This interface is started as follows:

### Linux
1. Open a terminal window  
1. Optionally change directory (`cd mydirectory`) to where you want to place new notebooks or load notebooks from (or a parent directory thereof).
1. Run `jupyter-notebook`.

### Troubleshooting

If you get the message `OSError: [Errno 99] Cannot assign requested address` try:

`jupyter-notebook --ip=0.0.0.0 --port=8080` or some other port number.
