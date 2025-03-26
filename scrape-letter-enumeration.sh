#!/bin/bash

# Başlangıç değerleri
MAX_FREQ="344" # Önceki betiğin tekrara düştüğü değer
MIN_FREQ="5"
OUTPUT_FILE="word_frequencies.txt"
SESSION_ID="" # Login olduktan sonra kendi sessionid çerez'inizi buraya yazın.

# Dosyayı temizle
# > $OUTPUT_FILE

# Alfabe harflerini döngüye al
for LETTER in $(echo $ALPHABET | grep -o .); do
    MAX_FREQ="344"
    while true; do
        # URL'yi oluştur
        URL="https://app.sketchengine.eu/bonito/run.cgi/wordlist?corpname=preloaded%2Ftrtenten20_tm2&wlmaxitems=20000&wlsort=frq&wlattr=lc&wlpat=(${LETTER}.*)&wlminfreq=$MIN_FREQ&wlicase=1&wlmaxfreq=$MAX_FREQ&wltype=simple&include_nonwords=1&random=0&relfreq=1&reldocf=1&wlpage=1"

        # Veriyi al
        RESPONSE=$(curl "$URL" \
            --compressed \
            -X POST \
            -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0' \
            -H 'Accept: */*' \
            -H 'Accept-Language: en-US,en;q=0.5' \
            -H 'Accept-Encoding: gzip, deflate, br, zstd' \
            -H 'Content-Type: application/x-www-form-urlencoded' \
            -H 'Origin: https://app.sketchengine.eu' \
            -H 'Connection: keep-alive' \
            -H 'Referer: https://app.sketchengine.eu/' \
            -H "Cookie: sessionid=$SESSION_ID; ske_cookieSettingsSaved=yes; ske_cookieSetting_analytics=yes; ske_cookieSetting_marketing=yes" \
            -H 'Sec-Fetch-Dest: empty' \
            -H 'Sec-Fetch-Mode: cors' \
            -H 'Sec-Fetch-Site: same-origin' \
            -H 'Priority: u=0')

        # echo $RESPONSE;
        # exit
        # JSON'dan Items array'ini al
        ITEMS=$(echo $RESPONSE | jq -r '.Items')

        # Eğer Items array'i boş ise döngüyü bitir
        if [[  "$ITEMS" = "[]"  ]]; then
            break
        fi

        # JSON'dan son elemanı al
        LAST_ITEM=$(echo $RESPONSE | jq -r '.Items[-1]')

        # Son elemanın frq değerini al
        NEXT_MAX_FREQ=$(echo $LAST_ITEM | jq -r '.frq')

        # Eğer son elemanın frq değeri 5'ten küçükse döngüyü bitir
        if [[  "$NEXT_MAX_FREQ" -lt 5  ]]; then
            break
        fi

        echo "letter $LETTER max $MAX_FREQ için $OUTPUT_FILE dosyasına kaydedildi."

        if [[  "$MAX_FREQ" -eq "$NEXT_MAX_FREQ"  ]]; then
            NEXT_MAX_FREQ=$(( $NEXT_MAX_FREQ - 1 ))
        fi

        # MAX_FREQ'i güncelle
        MAX_FREQ=$NEXT_MAX_FREQ

        # Tüm kelimeleri dosyaya yaz
        echo $RESPONSE | jq -r '.Items[] | "\(.str) \(.frq)"' >> $OUTPUT_FILE

        # Bir sonraki sorguya hazırlan
        sleep 3 # API'ye yük bindirmek için bekleyebilirsiniz
    done
done

echo "Scraping tamamlandı. Kelime frekansları $OUTPUT_FILE dosyasına kaydedildi."
