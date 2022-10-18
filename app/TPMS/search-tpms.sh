#!/bin/bash

source ../dev-shell-essentials/dev-shell-essentials.sh
echo ''
echo 'Term   File   Lines Before    Lines After' | highlight red 'Term' | highlight red 'Lines Before' | highlight red 'Lines After' | highlight red 'File'
echo ''
egrep -B $3 -A $4 $1 $2 | highlight magenta $1

#  3.6 hours off video in 60 GB

