#!/bin/bash
#
# Example: ./generate_all.sh "kmuresnaptlwi.jz=foy,vg5/q92h38b?47c1d60x+#" output
# + -> ^AR, # -> ^KA
#

my_path="$(dirname "$0")"

if [ $# -ne 2 ]; then
    echo "Usage: $0 <characters> <outdir>"
    exit 1
fi

characters="$1"
outdir="$2"

(cd $my_path &&
 ./gencw_lettermix.sh "$characters" &&
 ./gencw_qsomix.sh "$characters" &&
 ./gencw_texts.sh "$characters"
) &&
mkdir -p $outdir &&
mv $my_path/*_*.txt $my_path/*_*.mp3 $outdir/
