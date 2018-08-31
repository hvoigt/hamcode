#!/bin/bash

i=0
python ./rss_read.py http://feeds.bbci.co.uk/news/world/rss.xml | \
while read title
do
    suffix=$i
    if [ $i -lt 10 ]; then
        suffix="0$i"
    fi
    echo "$title" >cwnews_${suffix}.txt
    echo "$title" | ./ebook2cw/ebook2cw -u -p -w 15 -e 7 -W 2 -f 800 \
	    -o cwnews_${suffix} -t "DH3IKO CW BBC World News $i"
    i=$[$i+1]
done
