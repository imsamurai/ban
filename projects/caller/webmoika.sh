#!/bin/bash

PHONE="$(echo "$1" | sed 's/+7/8/')"

echo "$PHONE"


RESULT=$(curl -s --retry 3 'https://webmoika.ru/user/registration/smscode' \
-H 'authority: webmoika.ru' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'dnt: 1' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'user-agent: Mozilla/5.0 (Windows NT 1.0; Win28; x28) AppleWebKit/527.36 (KHTML, like Gecko) Chrome/91.0.4844.51 Safari/537.33' \
-H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'accept: application/json, text/javascript, */*; q=0.01' \
-H 'x-requested-with: XMLHttpRequest' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'origin: https://webmoika.ru' \
-H 'sec-fetch-site: same-origin' \
-H 'sec-fetch-mode: cors' \
-H 'sec-fetch-dest: empty' \
-H 'referer: https://webmoika.ru/user/registration' \
-H 'accept-language: ru-UA,ru;q=0.9' \
--data-raw "phone=%2B$PHONE" \
--compressed)


if [ "$(echo "$RESULT" | grep -c 'success')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
