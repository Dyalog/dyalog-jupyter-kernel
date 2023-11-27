# Jupyter kernel for Dyalog APL

This is a [Jupyter](http://jupyter.org/) kernel for [Dyalog APL](https://www.dyalog.com/). The [wiki](https://github.com/Dyalog/dyalog-jupyter-kernel/wiki) has more details. 

## Do you have any pre-made notebook documents?

A collection of ready-made notebooks is available [here](https://github.com/Dyalog/dyalog-jupyter-notebooks).

## Installation

### Pre-requisites:

- Python version 3.8 or later. Python can be installed in several ways. We recommend the standard download from https://www.python.org/downloads/. 
- Jupyter: see the [official documentation](https://jupyter.readthedocs.io/en/latest/install.html) for installation instructions.

### Installing the Dyalog kernel

This kernel is installable via Python's package installer, [pip](https://pip.pypa.io/en/stable/). It comes bundled with Python, but does occasionally need updating. 

In your terminal, run the follwing command:

```sh
pip install dyalog-jupyter-kernel[==2.0.0]
```

After successfully installing the kernel module itself, you need to register it with your Jupyter installation, using the following terminal command:

```sh
python -m 'dyalog_kernel' install
```

You should now be able to see the `dyalog_apl` kernel listed:
```sh
jupyter kernelspec list

Available kernels:
  python3       C:\Users\stefa\work\Jupyter\py312\share\jupyter\kernels\python3
  dyalog_apl    C:\Users\stefa\AppData\Roaming\jupyter\kernels\dyalog_apl
```

Start Jupyter:

```sh
jupyter lab # or jupyter notebook
```
and you should now see Dyalog APL amongst your kernels. Click on the Dyalog APL icon.

## Build notes (kernel developer interest only)

Build release assets with

```sh
python setup.py sdist bdist_wheel
```

Built assets will end up in `dist/`, and you can instruct `pip` to install from file for testing:

```sh
pip install dist/dyalog-jupyter-kernel-x.y.z.tar.gz
```

Upload release assets using [twine](https://twine.readthedocs.io/en/stable/). Install `twine` with 

```sh
pip install twine
```

Pick up the API token, and set up your `$HOME/.pypirc` file like this:

```
[distutils]
index-servers =
  pypi
  testpypi

[pypi]
username = __token__
password = pypi-A...Z  # Replace with your actual PyPI API token

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-A...Z  # Replace with your actual TestPyPI API token
```

Use the API key as password, including the `pypi-` prefix.

Upload the release:

```sh
twine upload --repository [test]pypi dist/*
```

To install the module from the test index, use

```sh
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple dyalog-jupyter-kernel[==2.0.0]
python -m 'dyalog_kernel' install
```
The `--extra-index-url` argument is there so that `pip` can pick up any dependencies from the main index.
