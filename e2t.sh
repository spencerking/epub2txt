#!/bin/sh

if [ "$1" = "" ]; then
    echo "Please provide an epub file."
    exit
fi

EPUB=$1

CONTENT=$(unzip -l "$EPUB" | grep -o "[A-Za-z/]*content.opf")

FILES=$(unzip -c "$EPUB" "$CONTENT" | grep -o "[A-Za-z0-9_]*[.][x]\{0,1\}html")

for file in $FILES ; do
    TEXT=$(unzip -l "$EPUB" | grep -o "[A-Za-z0-9_/]*$file")
    unzip -c "$EPUB" "$TEXT" | sed 's/<\/p>/\'$'\n''/g' | sed "s/Archive:  $EPUB//g" | sed "s/inflating: [A-Za-z0-9_\/]*$file//g" >> temp.txt
    awk '/<style>/{p=1;print}/<\/style>/{p=0}!p' temp.txt | sed 's/<[^>]*>/ /g' >> "$EPUB".txt
    rm temp.txt
done
