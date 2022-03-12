#!/bin/bash

PHONE="$1"
echo "$PHONE"

RESULT=$(curl -s --retry 3 "https://findclone.ru/register?phone=$PHONE" \
           -H 'Connection: keep-alive' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'Accept: application/json, text/plain, */*' \
           -H 'DNT: 1' \
           -H 'X-Requested-With: XMLHttpRequest' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'User-Agent: Mozilla/5.0 (Windows NT 11.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/536.36' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'Sec-Fetch-Site: same-origin' \
           -H 'Sec-Fetch-Mode: cors' \
           -H 'Sec-Fetch-Dest: empty' \
           -H 'Referer: https://findclone.ru/' \
           -H 'Accept-Language: ru-UA,ru;q=0.9' \
           --compressed)

echo "$RESULT"

if [ "$(echo "$RESULT" | grep pin_size -c)" != '1' ]; then
  pkill -sighup tor 2>/dev/null
fi
