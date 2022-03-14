#!/bin/bash

PHONE="$(echo "$1" | sed  's/+//')"

echo "+$PHONE"

RESULT="$(curl -s --retry 3 'https://godekan-has.ru/mob_auth.php?key=1' \
                             -H 'authority: godekan-has.ru' \
                             -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
                             -H 'dnt: 1' \
                             -H 'sec-ch-ua-mobile: ?0' \
                             -H 'user-agent: Mozilla/5.0 (Windows NT 20.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
                             -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
                             -H 'accept: */*' \
                             -H 'x-requested-with: XMLHttpRequest' \
                             -H 'sec-ch-ua-platform: "Windows"' \
                             -H 'origin: https://godekan-has.ru' \
                             -H 'sec-fetch-site: same-origin' \
                             -H 'sec-fetch-mode: cors' \
                             -H 'sec-fetch-dest: empty' \
                             -H 'referer: https://godekan-has.ru/personal/profile/' \
                             -H 'accept-language: ru-UA,ru;q=0.9' \
                             --data-raw "phone=%2B$PHONE")"

if [ "$(echo "$RESULT" | grep -c 'message_sent')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
