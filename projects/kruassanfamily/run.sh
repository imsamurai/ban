#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+7([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/7+(\1)+\2-\3-\4/')"
echo "+$PHONE"


RESULT=$(curl -s --retry 3 'https://kruassanfamily.ru/ajax/authorize.php?action=code' \
           -H 'authority: kruassanfamily.ru' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'dnt: 1' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'user-agent: Mozilla/5.0 (Windows NT 12.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
           -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
           -H 'accept: application/json, text/javascript, */*; q=0.01' \
           -H 'x-requested-with: XMLHttpRequest' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'origin: https://kruassanfamily.ru' \
           -H 'sec-fetch-site: same-origin' \
           -H 'sec-fetch-mode: cors' \
           -H 'sec-fetch-dest: empty' \
           -H 'referer: https://kruassanfamily.ru/auth/' \
           -H 'accept-language: ru-UA,ru;q=0.9' \
           --data-raw "trigger=&backurl=%2Fauth%2F&AUTH_FORM=Y&TYPE=AUTH&POPUP_AUTH=N&USER_LOGIN=%2B$PHONE&USER_LOGIN_CHECK=&USER_LAST_NAME=&USER_NAME=&USER_RESIDENT_KALININGRAD=Y&USER_PERSONAL_BIRTHDAY=&USER_PERSONAL_GENDER=&USER_EMAIL=&PB_CARD=&PB_CASHBOX=&PB_SHOP=")

echo "$RESULT"

if [ "$(echo "$RESULT" | grep -c '"Status":true')" = "0" ]; then
  pkill -sighup tor 2>/dev/null
fi
