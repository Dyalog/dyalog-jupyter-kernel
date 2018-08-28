#!/usr/bin/env sh

BASEDIR=$(dirname "$0")

OS=$(uname | tr "[:upper:]" "[:lower:]")
case $OS in
       darwin) KERNELDIR=~/Library/Jupyter/kernels/ ;;
       linux)  KERNELDIR=~/.local/share/jupyter/kernels/ ;;
esac

mkdir -p $KERNELDIR
cp -r $BASEDIR/dyalog-kernel $KERNELDIR

mkdir -p $(python3 -m site --user-site)/
cp -r $BASEDIR/dyalog_kernel $(python3 -m site --user-site)/
