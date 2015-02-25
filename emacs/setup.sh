#!/bin/bash

CURRENT_DIR=`readlink -f $(dirname $0)`

if [ ! -d "$CURRENT_DIR/.emacs.d/rosemacs-debs" ] ; then
  git clone https://github.com/moesenle/rosemacs-debs.git $CURRENT_DIR/.emacs.d/rosemacs-debs
else
  pushd $CURRENT_DIR/.emacs.d/rosemacs-debs
  git pull
  popd
fi

if [ ! -f ~/.emacs ]; then
  ln -s $CURRENT_DIR/.emacs ~/.emacs
fi
if [ ! -d ~/.emacs.d ]; then
  ln -s $CURRENT_DIR/.emacs.d ~/.emacs.d
fi

