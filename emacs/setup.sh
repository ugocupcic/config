#!/bin/bash

CURRENT_DIR=`readlink -f $(dirname $0)`

ln -s $CURRENT_DIR/.emacs ~/.emacs
ln -s $CURRENT_DIR/.emacs.d ~/.emacs.d
