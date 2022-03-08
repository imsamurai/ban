#!/bin/bash
PHONE="$(echo "$1" | sed -E 's/^\+7([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/+7 (\1) \2-\3-\4/' )"
echo "$PHONE"

COOKIEFILE="$RANDOM"cookie.txt

curl -s 'https://www.letu.ru/rest/model/atg/rest/SessionConfirmationActor/getSessionConfirmationNumber' \
  --retry 5 \
  -c "$COOKIEFILE" -b "$COOKIEFILE" \
  -H 'authority: www.letu.ru' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.letu.ru/browse/clean-beauty' \
  -H 'accept-language: ru-UA,ru;q=0.9,en-US;q=0.8,en;q=0.7,ru-RU;q=0.6' \
  --compressed > /dev/null

#cat cookie.txt

curl -s 'https://www.letu.ru/s/api/user/account/v1/confirmations/phone?pushSite=storeMobileRU' \
  --retry 5 \
  -c "$COOKIEFILE" -b "$COOKIEFILE" \
  -H 'authority: www.letu.ru' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'content-type: application/json' \
  -H 'accept: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://www.letu.ru' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.letu.ru/browse/clean-beauty' \
  -H 'accept-language: ru-UA,ru;q=0.9,en-US;q=0.8,en;q=0.7,ru-RU;q=0.6' \
  --data-raw '{"phoneNumber":"'"$PHONE"'","captcha":false}' \
  --compressed

rm -rf "$COOKIEFILE"
pkill -sighup tor 2>/dev/null
