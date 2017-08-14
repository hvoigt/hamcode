#!/bin/bash

for i in 00 01 02 03 04 05 06 07 08 09 10
do
    cat deutsch.txt | ./wordmix.pl >cwwords_$i.txt
    cat cwwords_$i.txt | ebook2cw -w 12 -f 800 -o cwwords_${i}_
done
