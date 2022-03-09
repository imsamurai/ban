#!/bin/bash

PHONE=$(echo "$1" | sed -E 's/^\+([0-9]{1})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1+(\2)+\3-\4\5/')
MESSAGE="$(printf %s 'Бегите из Украины, мрази! Вам пизда' |jq -sRr @uri)"

curl -s 'http://ossinfo.ru/functions/custom.php' \
 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0' \
 -H 'Accept: */*' \
 -H 'Accept-Language: en-US,en;q=0.5' \
 --compressed \
 -H 'Referer: http://ossinfo.ru/otpravit-sms-na-mts.html' \
 -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
 -H 'X-Requested-With: XMLHttpRequest' \
 -H 'Origin: http://ossinfo.ru' \
 -H 'Connection: keep-alive' \
 -H 'Cookie: PHPSESSID=fa0b4e1414c12554e94f8e754894f9fe; __gads=ID=256d92ef6c7269f4-223aeb8158cd0013:T=1646854659:RT=1646854659:S=ALNI_Ma9-YMTL5dHvQtqvJakSXAv4EMgbA; _ym_uid=1646854660124292432; _ym_d=1646854660; _ym_isad=2' \
 --data-urlencod 'method=sendSms' \
 --data-urlencod 'method=sendSms' \
 --data-urlencod 'method=sendSms' \
 --data-urlencod 'method=sendSms' \
 --data-raw 'method=sendSms&params%5Bmessage%5D='"$MESSAGE"'&params%5Bnumber%5D=%2B'"$PHONE"'&params%5Btransliterate%5D=false' | grep '{' | jq -c

echo ""

pkill -sighup tor 2>/dev/null
