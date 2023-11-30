# Install and use locally

**Dyalog version 15.0 or later** and **Python version 3.8+**, and the **jupyterlab** Python package must be installed in order to use the Dyalog Jupyter kernel.

Installing, operating and maintaining a Python installation can be a bit of a chore, especially if you're not a Python developer. If you're coming to this wanting only to use Jupyter for Dyalog APL, here are some step by step instructions for how to set up the whole tool chain from scratch. 

If you're a Python developer, or if you're already using a "canned" Python distribution, like [conda](https://docs.conda.io/en/latest/), you probably know what you're doing and can skip this document.

The below instructions show how to install Jupyter and the Dyalog kernel inside a Python "virtual environment". This means that you can keep your Jupyter work separate from any other Python work, current or future. This is usually a good idea when working with Python.

1. Download and install the [Dyalog interpreter](https://www.dyalog.com/download-zone.htm). 
2. Download, and run the official [Python installer](https://www.python.org/downloads/). Ensure you select `Use admin privileges to install Python`, `Add python.exe to PATH`, and `Disable PATH limit`.
3. Open a  terminal (e.g. PowerShell if you're on Windows). Type the following steps into the terminal window.
4. Create a virtual Python environment with a name of your choosing, e.g.
    ```
    python -m venv jupy312
    ```
5. Activate the virtual environment -- this is important:
    ```
    jupy312\Scripts\activate # Windows
	. jupy312/bin/activate   # linux, macOS. Note leading dot.
    ```
    Your terminal prompt should change to have a `(jupy312)` prefix.
6. [Optional, but recommended] Upgrade `pip` to the latest version:
    ```
    python.exe -m pip installl --upgrade pip # Windows
    python -m pip installl --upgrade pip     # linux, macOS
    ```
7. Install `jupyterlab`:
    ```
    pip install jupyterlab
    ```
8. Install the Dyalog kernel Python module:
    ```
    pip install dyalog-jupyter-kernel
    ```
9. Register the kernel with Jupyter:
    ```
    python -m 'dyalog_kernel' install
    ```
10. Start jupyterlab (or notebook):
    ```
	cd path/to/my/notebooks/
    jupyter lab # or jupyter notebook
    ```

Jupyter lab (and notebook) uses a web interface. It has a drop-down button labeled *New▾* where you can choose to create a new Dyalog APL notebook. You can also navigate to and click on any existing notebook (a file with the `.ipynb` extension) to open it.

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
