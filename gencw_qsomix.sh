#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <characters>"
    exit 1
fi

characters="$1"

for i in 00 01 02 03 04 05 06 07 08 09 10
do
    ./prosign_convert.pl 300USAqso/300USAqso-*.txt | \
	./wordmix.pl "$characters" >cwqso_$i.txt
    cat cwqso_$i.txt | ./ebook2cw/ebook2cw -u -p -w 15 -e 7 -W 0.3 -f 800 \
	    -o cwqso_${i} -t "DH3IKO CW Wordmix $i"
done
