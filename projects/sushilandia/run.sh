#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/\+//')"
echo "+$PHONE"


RESULT=$(curl -s --retry 3 'https://xn--80aikcmnyq9bye.xn--p1ai/index.php?route=module/sms_reg/SmsCheck' \
           -H 'authority: xn--80aikcmnyq9bye.xn--p1ai' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'dnt: 1' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'user-agent: Mozilla/5.0 (Windows NT 10.23; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4844.51 Safari/537.36' \
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
