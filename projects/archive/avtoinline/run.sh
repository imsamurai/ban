#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1(\2)\3-\4-\5/')"
INFO="$(cat personal.txt | shuf | head -1)"
NAME_RAW="$(echo "$INFO" | cut -f2) $(echo "$INFO" | cut -f1) $(echo "$INFO" | cut -f3)"
NAME="$(echo "NAME_RAW" |jq -sRr @uri)"
echo "+$PHONE $NAME_RAW"

COOKIEFILE="$RANDOM"cookie.txt

TOKEN=$(curl -s --retry 3 'https://avtoinline.com/' -c "$COOKIEFILE" -b "$COOKIEFILE" | grep 'csrfmiddlewaretoken' | sed -E 's/.*value="([^"]+)".*/\1/' | head -1)

RESULT=$(curl -s --retry 3 'https://avtoinline.com/create_lead/' \
           -c "$COOKIEFILE" -b "$COOKIEFILE" \
           -H 'Connection: keep-alive' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'DNT: 1' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'User-Agent: Mozilla/5.0 (Windows NT 3.11; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.2844.51 Safari/527.36' \
           -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
           -H 'Accept: */*' \
           -H 'X-Requested-With: XMLHttpRequest' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'Origin: https://avtoinline.com' \
           -H 'Sec-Fetch-Site: same-origin' \
           -H 'Sec-Fetch-Mode: cors' \
           -H 'Sec-Fetch-Dest: empty' \
           -H 'Referer: https://avtoinline.com/' \
           -H 'Accept-Language: ru-UA,ru;q=0.9' \
           --data-raw "csrfmiddlewaretoken=$TOKEN&name=$NAME&phone=%2B$PHONE&ch1=on&message=stopwar" \
           --compressed)

rm -rf "$COOKIEFILE"
echo "$RESULT"

if [ "$(echo "$RESULT" | grep -c '{"success": true}')" = "0" ]; then
  pkill -sighup tor 2>/dev/null
fi
