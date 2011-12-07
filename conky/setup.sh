#!/bin/bash

# The directory of conkyrcs
CONKY_DIR=`readlink -f $(dirname $0)`

mkdir -p ~/.conky

ln -sf $CONKY_DIR/windows ~/.conky
ln -sf $CONKY_DIR/lua ~/.conky

ln -sf $CONKY_DIR/conky.sh ~/.conky

echo "Add this to your startup daemons : "
echo "  ~/.conky/conky.sh"
echo "Also, if you don't have them already, copy these fonts to your local fonts."
echo "  mv $CONKY_DIR/fonts/*.ttf /usr/share/fonts/truetype"

