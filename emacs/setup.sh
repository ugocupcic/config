#!/bin/bash

CURRENT_DIR=`readlink -f $(dirname $0)`

git clone https://github.com/moesenle/rosemacs-debs.git $CURRENT_DIR/.emacs.d/rosemacs-debs

ln -s $CURRENT_DIR/.emacs ~/.emacs
ln -s $CURRENT_DIR/.emacs.d ~/.emacs.d

