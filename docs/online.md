# Use without installing anything
Jupyter notebooks can be viewed and interacted with online in a sandboxed environment.

## Using TryAPL
1. Click on [TryAPL](https://tryapl.org/)'s **Learn** tab.

1. Select tutorial (or enter the URL of an online Jupyter notebook document.<sup>Coming soon!</sup>)

1. Click *Next* to proceed through the tutorial steps.

1. At any time, you may click on APL expressions in the tutorial pane to re-insert them in the session pane, or press the up arrow key to recall previous statements.

## Using Binder
1. Add a Dockerfile to your Git repository (with the name Dockerfile) which uses the following template:

	```Dockerfile
	FROM rikedyp/dyalog-jupyter-binder:49 # This Docker container is a Dyalog Jupyter environment
	COPY ./NotebookFolder/ ${HOME}        # NotebookFolder is a folder containing notebooks
	ADD ./MyNotebook.ipynb ${HOME}        # MyNotebook.ipynb is an individual notebook
	```

1. Go to [mybinder.org](https://mybinder.org) and paste your repository URL
1. Click the `launch` button

If you are not already able to enter APL characters, try [the bookmarklet](./install.md#entering-apl-characters).
