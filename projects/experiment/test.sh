#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+(7[0-9]{10})$/\1/')"
echo "+$PHONE"

curl 'https://nskavtovokzal.ru/api/signup/call' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'DNT: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 9.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.1.4844.51 Safari/537.36' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Origin: https://nskavtovokzal.ru' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://nskavtovokzal.ru/buy-online' \
  -H 'Accept-Language: ru-UA,ru;q=0.9' \
  --data-raw "phone=$PHONE"
