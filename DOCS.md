# Building the docs

Make a Python virtual environment, e.g.

```sh
mkdir ~/.venv
python -m venv ~/.venv/docs
. ~/.venv/docs/bin/activate
```

Install the following python modules:

```sh
pip install --upgrade pip
pip install mkdocs
pip install mkdocs-material
```

To build:
```sh
mkdocs build
```

View locally:
```sh
mkdocs serve
```
access at http://127.0.0.1:8000

Deploy:
```sh
mkdocs gh-deploy
```