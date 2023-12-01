## Developing and publishing the Dyalog Jupyter kernel

We release from the master branch, and use semantic versioning. Releases are defined by the tag name. Find the current tag by

```
git describe --tags `git rev-list --tags --max-count=1`
```

For patch releases, add 1 to the last component of the current tag. 

Update the `__version__` string in `dyalog_kernel/__init__.py` accordingly, and the `version` key in `setup.py`.

The patch level should reset if we're changing major or minor version components, following semver.

Build release assets with

```sh
python setup.py sdist bdist_wheel
```

Built assets will end up in `dist/`, and you can instruct `pip` to install from file for testing:

```sh
pip install dist/dyalog-jupyter-kernel-x.y.z.tar.gz
```

Now tag the master branch with the new version (prefixed by `v.`):

```
git tag -a v2.0.2 -m "Release version 2.0.2"
git push origin v2.0.2
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
username = __token__
password = pypi-A...Z  # Replace with your actual TestPyPI API token
```

Use the API key(s) as password, including the `pypi-` prefix.

Upload the release to the test index first, and test that:

```sh
twine upload --repository testpypi dist/*
```

To install the module from the test index, use

```sh
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple dyalog-jupyter-kernel[==2.0.1]
python -m 'dyalog_kernel' install
```
The `--extra-index-url` argument is there so that `pip` can pick up any dependencies from the main index.

Upload the release to the main index, and test that:

```sh
twine upload --repository pypi dist/*
```