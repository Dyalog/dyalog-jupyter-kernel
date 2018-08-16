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

### Entering APL characters

You can get an APL language bar and enable key-bindings and character compositions using just a [a bookmarklet](https://abrudz.github.io/lb/apl) (a browser bookmark that contains commands which add new features to the browser). After adding the bookmarklet to your language bar, and opening a Jupyter notebook document in your browser, click on the bookmarklet. You can now insert APL characters in three ways:

1. Click a symbol on the language bar.
1. Type *Backtick* (`` ` ``) and then the associated symbol (hover over symbols on the language bar to see associations), e.g. *Backtick*+*r* makes `⍴` and *Backtick*+*Shift*+*e* makes `⍷`.
1. Type two symbols which roughly make up the APL symbol, then press the *Tab* key to combine them. The two symbols are chosen to be easy to guess according to one of the following systems:
    1. The symbols roughly make up the APL symbol when overlaid. For example, `O-` *Tab* makes `⊖` and `A|`*Tab*  makes `⍋`.
    1. The symbols roughly make up the APL symbol when juxtaposed. For example, `<>` *Tab* makes `⋄` and `[]` *Tab* makes `⎕`
    1. The symbols are identical, and are visually similar to the APL symbol. For example, `ee` makes `∊` and `xx` makes `×`.

## Running

Jupyter Notebook uses a web interface. It has a drop-down button labeled *New* where you can choose to create a new Dyalog APL notebook. You can also navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it.
To start a web server and try to point your web browser at it, proceed as follows:

### Windows
1. Open *Jupyter Notebook* from the Start menu

### Linux
1. Open a terminal window  
1. Optionally change directory (`cd mydirectory`) to where you want to place new notebooks or load notebooks from (or a parent directory thereof).
1. Run `jupyter-notebook`.

### Troubleshooting

If you get the message `OSError: [Errno 99] Cannot assign requested address` try:

`jupyter-notebook --ip=0.0.0.0 --port=8080` or some other port number.
