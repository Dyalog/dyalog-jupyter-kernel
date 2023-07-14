# Install and use locally

## Installing the Dyalog Jupyter kernel
**Dyalog version 15.0 or later** and **Python version 3.X**, and the **jupyter** Python package must be installed in order to use the Dyalog Jupyter kernel.

1. Go to [the python website](https://www.python.org/downloads/) to download and install Python on your system. Linux typically comes with Python already installed.

	If you need to manage multiple python versions, we recommend [pyenv](https://github.com/pyenv/pyenv).

1. Install [Jupyter](https://jupyter.org/) from a command line or PowerShell terminal.

	`pip install jupyter`

1. Click to [download the Dyalog Jupyter kernel repository as a zip](https://github.com/Dyalog/dyalog-jupyter-kernel/archive/master.zip).
1. After downloading, extract the contents and open the *dyalog-jupyter-kernel-master* directory.
1. Run the following (it will have little visual effect, if any):  

	Windows: `install.bat`  

	Linux and macOS: `install.sh`

## Run Jupyter Notebook
Use a command line or PowerShell terminal.

Go to the directory which contains your notebooks:

```
cd /path/to/my/notebooks
```

Then start the Jupyter notebook system:

```
jupyter notebook
```

Jupyter Notebook uses a web interface. It has a drop-down button labeled *New▾* where you can choose to create a new Dyalog APL notebook. You can also navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it.

## Troubleshooting

### Python is not found
> If you get the message
> ```
> python : The term 'python' is not recognized as the name of a cmdlet, function,  script file, or operable program.
> ```
> Run the installer again. Make sure to tick **Add Python to environment variables**

### Cannot assign requsted address
> If you get the message  
> `OSError: [Errno 99] Cannot assign requested address`  
> try:  
> `jupyter-notebook --ip=0.0.0.0 --port=8080`  
> or some other port number.

## Entering APL characters

You can get an APL language bar and enable key-bindings and character compositions using just a [a bookmarklet](https://abrudz.github.io/lb/apl) (a browser bookmark that contains commands which add new features to the browser). After adding the bookmarklet to your language bar, and opening a Jupyter notebook document in your browser, click on the bookmarklet. You can now insert APL characters in three ways:

1. Click a symbol on the language bar.
1. Type *Backtick* (`` ` ``) and then the associated symbol (hover over symbols on the language bar to see associations), e.g. *Backtick*+*r* makes `⍴` and *Backtick*+*Shift*+*e* makes `⍷`.
1. Type two symbols which roughly make up the APL symbol, then press the *Tab* key to combine them. The two symbols are chosen to be easy to guess according to one of the following systems:
    1. The symbols roughly make up the APL symbol when overlaid. For example, `O-` *Tab* makes `⊖` and `A|`*Tab*  makes `⍋`.
    1. The symbols roughly make up the APL symbol when juxtaposed. For example, `<>` *Tab* makes `⋄` and `[]` *Tab* makes `⎕`
    1. The symbols are identical, and are visually similar to the APL symbol. For example, `ee` makes `∊` and `xx` makes `×`.
