#!/bin/bash

lettermix_options=
fast_lettermix=
intro_letters=0
while test $# -gt 1
do
    case "$1" in
    -e)
        lettermix_options="-e"
        shift
        ;;
    -f)
        fast_lettermix=t
        shift
        ;;
    -i)
        intro_letters=$2
        shift 2
        ;;
    *)
        break
    esac
done

if [ $# -ne 1 ]; then
    echo "Usage: $0 [-e] [-f] <characters>"
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
    do_mix_lettermix_options="$3"
    out=lettermix_$i.txt
    printf "vvv# " >$out
    ./lettermix $do_mix_lettermix_options "$characters" >>$out
    echo " +" >> $out
    cat $out | ./ebook2cw/ebook2cw -p $options -f 800 \
	-o lettermix_${i} -t "DH3IKO CW Lettermix $i"
}

for i in 00 01 02 03 04 05 06 07 08 09
do
    do_mix $i "-e 8 -w 12"
done

if [ $intro_letters -gt 0 ];then
    i=00
    intro=${characters: -$intro_letters}
    out=lettermix_$i.txt
    options="-e 8 -w 12"

    printf "vvv# " >$out
    for r in $(seq 0 2)
    do
        for l in $(seq 0 $[$intro_letters-1])
        do
            for x in $(seq 1 5)
            do
                printf ${intro:$l:1} >>$out
            done
                printf " " >>$out
        done
    done
    echo "+" >> $out
    cat $out | ./ebook2cw/ebook2cw -p $options -f 800 \
	-o lettermix_${i} -t "DH3IKO CW Lettermix $i"
fi

for i in 10 11 12 13 14 15 16 17 18 19
do
    do_mix $i "-e 10 -w 12" $lettermix_options
done

for i in 20 21 22 23 24 25 26 27 28 29
do
    do_mix $i "-e 12 -w 12" $lettermix_options
done

if [ "$fast_lettermix" ]; then
    for i in 30 31 33 33 34 35 36 37 38 39
    do
        do_mix $i "-e 16 -w 16" $lettermix_options
    done
fi
