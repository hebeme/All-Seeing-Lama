#!/bin/bash

source ../dev-shell-essentials/dev-shell-essentials.sh
echo 'Term    File    Lines Before    Lines After'
egrep -B $3 -A $4 $1 $2 | highlight magenta $1 |highlight green '\[.........\]'| highlight green '\[..........\]' | highlight cyan 'FLEX' | highlight blue 'ALN' | highlight blue 'NUM ' | highlight blue 'TON' | highlight blue '-' | highlight blue ':' | highlight red 'Msg' | highlight red 'Subj' | highlight yellow 'SMS' | highlight yellow 'google' | highlight yellow 'Google' | highlight  magenta 'UNK' | highlight blue '[/]' | highlight blue '[.]' | highlight blue '_'


