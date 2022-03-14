#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1+(\2)+\3-\4-\5/')"

echo "+$PHONE"

RESULT=$(curl -s --retry 3 'https://autotown.ru/local/ajax/phone_code.php' \
-H 'authority: autotown.ru' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'dnt: 1' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'accept: application/json, text/javascript, */*; q=0.01' \
-H 'x-requested-with: XMLHttpRequest' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'origin: https://autotown.ru' \
-H 'sec-fetch-site: same-origin' \
-H 'sec-fetch-mode: cors' \
-H 'sec-fetch-dest: empty' \
-H 'referer: https://autotown.ru/personal/discount/' \
-H 'accept-language: ru-UA,ru;q=0.9' \
--data-raw "register_submit_button=Y&REG_FORM=Y&REGISTER%5BEMAIL%5D=&REGISTER%5BPERSONAL_PHONE%5D=%2B$PHONE&sms_code=&REGISTER%5BNAME%5D=&REGISTER%5BLOGIN%5D=&REGISTER%5BPASSWORD%5D=&REGISTER%5BCONFIRM_PASSWORD%5D=&transport=phone&type=send_code" \
--compressed)

if [ "$(echo "$RESULT" | grep -c '"STATUS":"Y"')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
