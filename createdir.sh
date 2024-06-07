#!/bin/bash

cd /pdf2html
for file in *.pdf; do
		if [[ ${file%.pdf} != "*" ]]; then
#				/pdf2htmlEX/pdf2htmlEX --zoom 1.3 --last-page 5 "$file" "result/_${file%.pdf}.html"
				/pdf2htmlEX/pdf2htmlEX --zoom 1 --last-page 10 --embed-css 1 --embed-font 1 --embed-javascript 0 "$file" "result/_${file%.pdf}.html"

#				sed -E 's/<span[^>]*_ _[0-9]+[^>]*>([^<]*)<\/span>([^<0-9]{1})/\1\2/g' "result/_${file%.pdf}.html" > "result/full_${file%.pdf}.html"
#				sed -E 's/<span[^>]*_ _[0-9]+[^>]*>([ -]*)<\/span>/\1/g' "result/full_${file%.pdf}.html" > "result/_${file%.pdf}.html"
#				sed -E 's/<span[^>]*[^>]*>([ -.]+)<\/span>/\1/g' "result/full_${file%.pdf}.html" > "result/_${file%.pdf}.html"
				sed -E 's/([. ]+)(h[0-9]+)/\1doc-\2/g' "result/_${file%.pdf}.html" > "result/full_${file%.pdf}.html"
#				rm "result/_${file%.pdf}.html"
				sed -i 's/[\x00-\x09\x0B-\x1F\x7F]//g' "result/full_${file%.pdf}.html"
#				sed -i 's/[^a-zA-Z0-9<>\/=".,#\[\]&@\*\? ]//g' "result/full_${file%.pdf}.html"
				sed -i 's// /g' "result/full_${file%.pdf}.html"
				sed -i 's// /g' "result/full_${file%.pdf}.html"
				sed -i 's// /g' "result/full_${file%.pdf}.html"
				sed -i 's// /g' "result/full_${file%.pdf}.html"
				sed -E 's/<[!]--.*-->//g' "result/full_${file%.pdf}.html" > "result/_${file%.pdf}.html"
				sed -E 's/\/\*[!]*.*\*\///g' "result/_${file%.pdf}.html" > "result/full_${file%.pdf}.html"
				sed -i 's/#page-container/#page-container__del/g' "result/full_${file%.pdf}.html"
				sed -i 's/#sidebar/#sidebar__del/g' "result/full_${file%.pdf}.html"
#				sed -i 's/<div[^>]*outline[^>]*>/,/<\/div>/d' "result/full_${file%.pdf}.html"
				sed -E 's/(sidebar|page-container|outline)/b-document-pdf2html__\1/g' "result/full_${file%.pdf}.html" > "result/${file%.pdf}.html"
				sed -i 's/<\/*html[^>]*>//g' "result/${file%.pdf}.html"
				sed -E 's/([^<]{1})(html|body)[_]+/\1pdf2html__\2/g' "result/${file%.pdf}.html" > "result/_${file%.pdf}.html"
				sed -E 's/<body>/<div class="b-document-pdf2html__body">/g' "result/_${file%.pdf}.html" > "result/${file%.pdf}.html"
				sed -i 's/<\/body>/<\/div">/g' "result/_${file%.pdf}.html"
#				sed -i 's/<\/*meta[^>]*>//g' "result/${file%.pdf}.html"
				#sed -E 's/#(.*)\*\///g' "result/_${file%.pdf}.html" > "result/md_${file%.pdf}.html"
				sed -i 's/<[!]DOCTYPE.*>//g' "result/${file%.pdf}.html"
				sed -i 's/<\/*head>//g' "result/${file%.pdf}.html"

				rm "result/_${file%.pdf}.html"
				rm "result/full_${file%.pdf}.html"

				rm "$file"

        # Получаем текущую дату и время
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
		    echo -e "\n[$current_datetime] - файл: /pdf2html/result/${file%.pdf}.html"
		fi
done