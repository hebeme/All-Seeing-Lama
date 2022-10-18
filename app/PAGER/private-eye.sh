#!/bin/bash
# To download the highlight script: 
# git clone https://github.com/kepkin/dev-shell-essentials.git

source ../dev-shell-essentials/dev-shell-essentials.sh
nc -l -u localhost 7355 | sox -t raw -esigned-integer -b 16 -r 48000 - -esigned-integer -b 16 -r 22050 -t raw - | multimon-ng -t raw -a FLEX -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha - | highlight green '\[' | highlight green '\]' | highlight cyan 'FLEX' | highlight blue 'ALN' | highlight blue 'NUM ' | highlight blue 'TON' | highlight blue '-' | highlight blue ':' | highlight red 'Msg*' | highlight red 'Subj' | highlight yellow 'SMS' | highlight yellow 'google' | highlight yellow 'Google' | highlight  magenta 'UNK' | highlight blue '[/]' | highlight blue '[.]' | highlight blue '_'



