#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <characters>"
    exit 1
fi

characters="$1"

if [ ! -f ./lettermix ]; then
    echo "Please compile 'lettermix' first with make"
    exit 1
fi

for i in 00 01 02 03 04 05 06 07 08 09 10
do
    ./lettermix "$characters" >lettermix_$i.txt
    cat lettermix_$i.txt | ebook2cw -p -e 10 -w 14 -f 800 \
	-o lettermix_${i} -t "DH3IKO CW Lettermix $i"
done
