#!/bin/bash

#check conky is installed
CONKY_INSTALLED=`aptitude search '~i ^conky$' | wc -l`
if [ ${CONKY_INSTALLED} -eq 0 ] ; then
    sudo aptitude install conky
fi

# Kill Conky If Running
test -z "`pgrep conky`" || killall -9 conky

# The directory of conkyrcs
conky_dir=`readlink -f $(dirname $0)`

# The command for start conkys
START="conky -d -c"

# The Conkys
sleep 5
$START $conky_dir/cpu
sleep 0.2
$START $conky_dir/time
sleep 0.2
$START $conky_dir/mem
sleep 0.2
$START $conky_dir/disk
sleep 0.2
$START $conky_dir/net
sleep 0.2
$START $conky_dir/big_clock
