#!/bin/sh/

EPUB=$1

CONTENT=$(unzip -l "$EPUB" | grep -o "[A-Za-z/]*content.opf")

FILES=$(unzip -c "$EPUB" "$CONTENT" | grep -o "[A-Za-z0-9_]*[.]xhtml")

for file in $FILES ; do
    #echo "$file"
    TEXT=$(unzip -l "$EPUB" | grep -o "[A-Za-z0-9_/]*$file")
    unzip -c "$EPUB" "$TEXT" | sed 's/<\/p>/\'$'\n''/g' | sed 's/<[^>]*>/ /g' | sed "s/Archive:  $EPUB//g" | sed "s/inflating: [A-Za-z0-9_\/]*$file//g" | sed 's/<style>[^>]*<\/style>//g' >> temp.txt
done