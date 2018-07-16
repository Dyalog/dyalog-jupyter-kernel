# [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/)

## Installation

1. Install Dyalog APL version 15.0 or later.
1. Install Python 3 and Jupyter. There are several ways to do this, for example:
   * Install [Anaconda](https://www.anaconda.com/download/) (Python 3 version), which is available for various platforms.
   * On Debian-based Linux systems, try `sudo apt-get install jupyter-notebook`.
1. [Clone](https://help.github.com/articles/cloning-a-repository/) this repository.
1. Create the following directory:  
   Linux: `~/.local/share/jupyter/kernels/`  
   Windows: `%APPDATA%\jupyter\kernels\`  
   and copy `dyalog-kernel` (note the hyphen `-`) into it.
1. Create the following directory:  
   Linux: `$(python3 -m site --user-site)/`  
   Windows: `%APPDATA%\Python\Python36\site-packages\`  
   and copy `dyalog_kernel` (note the underscore `_`) into it.
1. You may now delete the repository clone, if you wish to do so.
1. Windows only:

   1. <kbd>**⊞** Win</kbd>+<kbd>Pause</kbd>
   1. click *Advanced system settings*
   1. click *Environment Variables…*
   1. click *System variables*
   1. double click on *Path*
   1. click *New*
   1. type `C:\Program Files\Dyalog\Dyalog APL-64 17.0 Unicode` or whatever your install directory is
   1. click *OK*
   1. click *OK*
   1. click *OK*

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
