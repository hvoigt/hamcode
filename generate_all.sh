#!/bin/bash
#
# Example: ./generate_all.sh "kmuresnaptlwi.jz=foy,vg5/q92h38b?47c1d60x+#" output
# + -> ^AR, # -> ^KA, < -> ^ERROR
#

my_path="$(dirname "$0")"

lettermix_options=
generate_texts=
generate_qsomix=
while test $# -gt 2
do
    case "$1" in
    -e)
        if [ "$lettermix_options" ]; then
            lettermix_options="$lettermix_options -e"
        else
            lettermix_options="-e"
        fi
        shift
        ;;
    -f)
        if [ "$lettermix_options" ]; then
            lettermix_options="$lettermix_options -f"
        else
            lettermix_options="-f"
        fi
        shift
        ;;
    -i)
        if [ "$lettermix_options" ]; then
            lettermix_options="$lettermix_options -i $2"
        else
            lettermix_options="-i $2"
        fi
        shift 2
        ;;
    -t)
        generate_texts=t
        shift
        ;;
    -n)
        generate_news=t
        shift
        ;;
    -q)
        generate_qsomix=t
        shift
        ;;
    *)
        break
    esac
done

if [ $# -ne 2 ]; then
    echo "Usage: $0 <characters> <outdir>"
    exit 1
fi

characters="$1"
outdir="$2"

(cd "$my_path" &&
 ./gencw_lettermix.sh $lettermix_options "$characters" &&
 mkdir -p 1_letter && mv *_*.txt *_*.mp3 1_letter/ &&
 if [ "$generate_qsomix" ]; then
     ./gencw_qsomix.sh "$characters" &&
     mkdir -p 2_qso && mv *_*.txt *_*.mp3 2_qso/
 fi &&
 if [ "$generate_texts" ]; then
     ./gencw_texts.sh "$characters" &&
     mkdir -p 3_text && mv *_*.txt *_*.mp3 3_text/
 fi &&
 if [ "$generate_news" ]; then
     ./gencw_news.sh &&
     mkdir -p 4_news && mv *_*.txt *_*.mp3 4_news/
 fi &&
 echo "#Letters" >0_Exercises.txt &&
 find 1_letter -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
 if [ "$generate_qsomix" ]; then
     echo "#QSOs" >>0_Exercises.txt &&
     find 2_qso -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
 fi &&
 if [ "$generate_texts" ]; then
     echo "#Texts" >>0_Exercises.txt &&
     find 3_text -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
 fi &&
 if [ "$generate_news" ]; then
     echo "#News" >>0_Exercises.txt &&
     find 4_news -name "*.txt" | sort | cut -f1 -d. >>0_Exercises.txt
 fi
) &&
mkdir -p "$outdir" &&
rm -rf "$outdir/1_letter" "$outdir/2_qso" "$outdir/3_text" "$outdir/4_news" &&
mv "$my_path/1_letter" "$outdir/" &&
if [ "$generate_qsomix" ]; then
    mv "$my_path/2_qso" "$outdir/"
fi &&
if [ "$generate_texts" ]; then
    mv "$my_path/3_text" "$outdir/"
fi &&
if [ "$generate_news" ]; then
    mv "$my_path/4_news" "$outdir/"
fi &&
echo "$characters" >"$outdir/0_Letters.txt" &&
mv "$my_path/0_Exercises.txt" "$outdir/" &&
cp -r "$my_path/html/"* "$outdir/"
