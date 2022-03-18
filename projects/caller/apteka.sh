#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/+\1 (\2) \3-\4-\5/')"

echo "$PHONE"


RESULT=$(curl -sk --retry 3 'https://api.apteka.ru/Auth/Auth_Code?cityId=5e57803249af4c0001d64407' \
-H 'Connection: keep-alive' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'DNT: 1' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json, text/plain, */*' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'Origin: https://apteka.ru' \
-H 'Sec-Fetch-Site: same-site' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Referer: https://apteka.ru/' \
-H 'Accept-Language: ru-UA,ru;q=0.9' \
--data-raw '{"phone":"'"$PHONE"'","u":"U"}' \
--compressed)


if [ "$(echo "$RESULT" | grep -c 'newUser')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
