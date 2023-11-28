# A full installation, from scratch, on Windows

Installing, operating and maintaining a Python installation can be a bit of a chore, especially if you're not a Python developer. If you're coming to this wanting only to use Jupyter for Dyalog APL, here are some step by step instructions for how to set up the whole tool chain (on Windows) from scratch. 

If you're a Python developer, or if you're already using a "canned" Python distribution, like [conda](https://docs.conda.io/en/latest/), you probably know what you're doing and can skip this document.

The below instructions install Jupyter and the Dyalog kernel inside a Python "virtual environment". This means that you can keep your Jupyter work separate from any other Python work, current or future. This is usually a good idea when working with Python.

1. Download and install the [Dyalog interpreter](https://www.dyalog.com/download-zone.htm)
2. Download, and run the official [Python installer](https://www.python.org/downloads/).
3. Open a PowerShell terminal. Type the following steps into the terminal window.
4. Create a virtual Python environment with a name of your choosing, for example
    ```
    python -m venv jupy312
    ```
5. Activate the virtual environment -- this is important:
    ```
    jupy312\Scripts\activate
    ```
    Your terminal prompt should change to have a `(jupy312)` prefix.
6. Upgrade `pip` to the latest version:
    ```
    python.exe -m pip installl --upgrade pip
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
10. Start jupyterlab:
    ```
    jupyter lab
    ```

A browser window should open up with the Jupyter Lab application. Click the "Dyalog APL" symbol to open a new notebook document with the Dyalog kernel.

Once you're done working with Jupyter Lab, deactivate the Python environment:

```
deactivate
```

To start up Jupyter Lab again, you need to run `jupy312\Scripts\activate` and `jupyter lab` again. 
