#!/bin/bash
#
# Example: ./generate_all.sh "kmuresnaptlwi.jz=foy,vg5/q92h38b?47c1d60x+#" output
# + -> ^AR, # -> ^KA, < -> ^ERROR
#

my_path="$(dirname "$0")"

if [ $# -ne 2 ]; then
    echo "Usage: $0 <characters> <outdir>"
    exit 1
fi

characters="$1"
outdir="$2"

(cd "$my_path" &&
 ./gencw_lettermix.sh "$characters" &&
 mkdir -p 1_letter && mv *_*.txt *_*.mp3 1_letter/ &&
# ./gencw_qsomix.sh "$characters" &&
# mkdir -p 2_qso && mv *_*.txt *_*.mp3 2_qso/ &&
# ./gencw_texts.sh "$characters" &&
# mkdir -p 3_text && mv *_*.txt *_*.mp3 3_text/ &&
 echo "#Letters" >0_Exercises.txt &&
 find 1_letter -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
# echo "#QSOs" >>0_Exercises.txt &&
# find 2_qso -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt &&
# echo "#Texts" >>0_Exercises.txt &&
# find 3_text -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
) &&
mkdir -p "$outdir" &&
rm -rf "$outdir/1_letter" "$outdir/2_qso" "$outdir/3_text" &&
#mv "$my_path/1_letter" "$my_path/2_qso" "$my_path/3_text" "$outdir/" &&
mv "$my_path/1_letter" "$outdir/" &&
echo "$characters" >"$outdir/0_Letters.txt" &&
mv "$my_path/0_Exercises.txt" "$outdir/" &&
cp -r "$my_path/html/"* "$outdir/"
