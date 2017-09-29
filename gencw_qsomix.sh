#!/bin/bash

for i in 00 01 02 03 04 05 06 07 08 09 10
do
    ./prosign_convert.pl 300USAqso/300USAqso-*.txt | ./wordmix.pl >cwqso_$i.txt
    cat cwqso_$i.txt | ebook2cw -w 12 -f 800 \
	    -o cwqso_${i} -t "DH3IKO CW Wordmix $i"
done
