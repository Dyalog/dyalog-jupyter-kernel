#!/usr/bin/env sh

BASEDIR=$(dirname "$0")

if [ "$(uname)" == "Darwin" ]; then
  mkdir -p ~/Library/Jupyter/kernels/
  cp -r $BASEDIR/dyalog-kernel ~/Library/Jupyter/kernels/
else
  mkdir -p ~/.local/share/jupyter/kernels/
  cp -r $BASEDIR/dyalog-kernel ~/.local/share/jupyter/kernels/
fi

mkdir -p $(python3 -m site --user-site)/
cp -r $BASEDIR/dyalog_kernel $(python3 -m site --user-site)/
