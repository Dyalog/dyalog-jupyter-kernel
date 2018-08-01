#!/usr/bin/sh

BASEDIR=$(dirname `readlink -f "$0"`)

mkdir -p ~/.local/share/jupyter/kernels/
cp -r $BASEDIR/dyalog-kernel ~/.local/share/jupyter/kernels/

mkdir -p $(python3 -m site --user-site)/
cp -r $BASEDIR/dyalog_kernel $(python3 -m site --user-site)/
