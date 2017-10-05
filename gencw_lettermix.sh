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

do_mix() {
    i=$1
    options="$2"
    out=lettermix_$i.txt
    printf "vvv# " >$out
    ./lettermix "$characters" >>$out
    echo " +" >> $out
    cat $out | ebook2cw -p $options -f 800 \
	-o lettermix_${i} -t "DH3IKO CW Lettermix $i"
}

for i in 00 01 02 03 04 05 06 07 08 09 10
do
    do_mix $i "-e 8 -w 12"
done

for i in 10 11 12 13 14 15 16 17 18 19 20
do
    do_mix $i "-e 10 -w 12"
done
