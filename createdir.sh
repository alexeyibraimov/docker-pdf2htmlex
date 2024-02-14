#!/bin/bash
cd /pdf2html
for file in *.pdf; do
    /pdf2htmlEX/pdf2htmlEX --zoom 1.3 "$file" "result/_${file%.pdf}.html"
#    sed -E 's/<span[^>]*_ _[0-9]+[^>]*><\/span>//g' "result/_${file%.pdf}.html" > "result/${file%.pdf}.html"
#    sed -i 's/<span[^>]*>\|<\/span>//g' "result/${file%.pdf}.html"
    sed -E 's/<span[^>]*_ _[0-9]+[^>]*>([^<]*)<\/span>([^<0-9]{1})/\1\2/g' "result/_${file%.pdf}.html" > "result/${file%.pdf}.html"
    rm "result/_${file%.pdf}.html"
    sed -i 's/[\x00-\x09\x0B-\x1F\x7F]//g' "result/${file%.pdf}.html"
    sed -i 's/[^a-zA-Z0-9<>\/=".,#\[\]&@\*\? ]//g' "result/${file%.pdf}.html"
    sed -i 's// /g' "result/${file%.pdf}.html"
    sed -i 's// /g' "result/${file%.pdf}.html"
    sed -i 's// /g' "result/${file%.pdf}.html"
    sed -i 's// /g' "result/${file%.pdf}.html"
    rm "$file"

#    echo -e "\n файл: /pdf2html/result/".${file%.pdf}.".html"
done