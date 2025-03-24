#!/bin/bash

# Başlangıç değerleri
MAX_FREQ="10000000"
OUTPUT_FILE="word_frequencies.txt"
SESSION_ID="" # Login olduktan sonra kendi sessionid çerez'inizi buraya yazın. {32 karakter hexadecimal}

# Dosyayı temizle
> $OUTPUT_FILE

# Döngü başlat
while true; do
    # URL'yi oluştur
    URL="https://app.sketchengine.eu/bonito/run.cgi/wordlist?corpname=preloaded%2Ftrtenten20_tm2&results_url=https%3A%2F%2Fapp.sketchengine.eu%2F%23wordlist%3Fcorpname%3Dpreloaded%252Ftrtenten20_tm2%26tab%3Dadvanced%26wlattr%3Dlc%26wlmaxfreq%3D1860%26itemsPerPage%3D1001%26showresults%3D1%26cols%3D%255B%2522frq%2522%255D%26diaattr%3D%26showtimelineabs%3D0%26timelinesthreshold%3D5%26showresults%3D1&wlmaxitems=20000&wlsort=frq&wlattr=lc&wlpat=.*&wlminfreq=5&wlicase=1&wlmaxfreq=$MAX_FREQ&wltype=simple&include_nonwords=0&random=0&relfreq=1&reldocf=1&wlpage=1"

    # Veriyi al
    RESPONSE=$(curl "$URL" \
        --compressed \
        -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0' \
        -H 'Accept: */*' \
        -H 'Accept-Language: en-US,en;q=0.5' \
        -H 'Accept-Encoding: gzip, deflate, br, zstd' \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -H 'Connection: keep-alive' \
        -H 'Referer: https://app.sketchengine.eu/' \
        -H "Cookie: sessionid=$SESSION_ID" \
        -H 'Sec-Fetch-Dest: empty' \
        -H 'Sec-Fetch-Mode: cors' \
        -H 'Sec-Fetch-Site: same-origin' \
        -H 'TE: trailers')

    # JSON'dan son elemanı al
    LAST_ITEM=$(echo $RESPONSE | jq -r '.Items[-1]')

    # Son elemanın frq değerini al
    NEXT_MAX_FREQ=$(echo $LAST_ITEM | jq -r '.frq')

    # Eğer son elemanın frq değeri 5'ten küçükse döngüyü bitir
    if [ "$NEXT_MAX_FREQ" -lt 5 ]; then
        break
    fi

    # MAX_FREQ'i güncelle
    MAX_FREQ=$NEXT_MAX_FREQ

    # Tüm kelimeleri dosyaya yaz
    echo $RESPONSE | jq -r '.Items[] | "\(.str) \(.frq)"' >> $OUTPUT_FILE

    # Bir sonraki sorguya hazırlan
    sleep 1 # API'ye yük bindirmek için bekleyebilirsiniz
done

# Tekrarlayan satırları sil
awk '!seen[$0]++' $OUTPUT_FILE > temp_file && mv temp_file $OUTPUT_FILE

echo "Scraping tamamlandı. Kelime frekansları $OUTPUT_FILE dosyasına kaydedildi."
