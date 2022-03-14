#!/bin/bash

PHONE="$(echo "$1" | sed 's/+//')"

echo "+$PHONE"

RESULT=$(curl -ks 'https://www.zonatelecom.ru/api/identify' \
                    -H 'Connection: keep-alive' \
                    -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
                    -H 'DNT: 1' \
                    -H 'sec-ch-ua-mobile: ?0' \
                    -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
                    -H 'sec-ch-ua-platform: "Windows"' \
                    -H 'Content-Type: application/json' \
                    -H 'Accept: */*' \
                    -H 'Origin: https://www.zonatelecom.ru' \
                    -H 'Sec-Fetch-Site: same-origin' \
                    -H 'Sec-Fetch-Mode: cors' \
                    -H 'Sec-Fetch-Dest: empty' \
                    -H 'Referer: https://www.zonatelecom.ru/' \
                    -H 'Accept-Language: ru-UA,ru;q=0.9' \
                    --data-raw '{"act":"auth","g-recaptcha-response":"","method":"call","phone":"'"$PHONE"'"}' \
                    --compressed)

if [ "$(echo "$RESULT" | grep -c '"success":true')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
