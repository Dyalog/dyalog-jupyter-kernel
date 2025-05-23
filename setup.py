from setuptools import setup, find_packages

setup(
    name="dyalog-jupyter-kernel",
    version="2.0.2",
    author="Stefan Kruger",
    author_email="stefan@dyalog.com",
    description="Jupyter kernel for Dyalog APL",
    long_description=open('README.md').read(),
    long_description_content_type="text/markdown",
    url="https://github.com/Dyalog/dyalog-jupyter-kernel",
    packages=find_packages(),
    include_package_data=True,
    package_data={
        'dyalog_kernel': ['dyalog_apl/*']
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.8",
    install_requires=[
        "ipykernel>=6.20.0",
        "metakernel>=0.30.3"
    ],
    entry_points={
        'console_scripts': [
        ],
    },
)