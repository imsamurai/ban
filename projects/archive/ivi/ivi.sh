#!/bin/bash

PHONE=$(echo "$1" | sed -E 's/[-_\(\) ]//g' | sed -E 's/.*(\+[0-9]{11}).*/\1/g')

PHONE1=$(echo "$PHONE" | sed -E 's/^\+([0-9]{1})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/+\1 \2 \3-\4-\5/')

PHONE2=$(echo "$PHONE" | sed -E 's/^\+([0-9]{1})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/\1+\2+\3-\4-\5/')
echo "$PHONE"

DATA=$(curl  --retry 5 -is "https://www.ivi.tv/")

SESSION_DATA=$(echo "$DATA" | grep 'session_data=' | sed -E 's/.*session_data=([^;]+).*/\1/')

SESSIVI=$(echo "$DATA" | grep 'sessivi=' | sed -E 's/.*sessivi=([^;]+).*/\1/')

#echo "$SESSION_DATA"
#echo "$SESSIVI"

KEY=$(curl  --retry 5 -s 'https://api2.ivi.ru/mobileapi/timestamp/v5/?app_version=870&session='"$SESSIVI"'&session_data='"$SESSION_DATA" \
  -H 'authority: api2.ivi.ru' \
  -H 'pragma: no-cache' \
  -H 'cache-control: no-cache' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'accept: application/json, text/javascript, */*; q=0.01' \
  -H 'dnt: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://www.ivi.tv' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.ivi.tv/' \
  -H 'accept-language: ru-UA,ru;q=0.9' \
  --compressed | jq '.result' -r )

#echo "$KEY"

URL_TO_SIGN="app_version=870&delivery_method=call&device=Windows Chrome v.99.0.4844.51 34e61&phone=$PHONE1&session=$SESSIVI&session_data=$SESSION_DATA&ts=$KEY/user/register/phone/v6/?"

#echo "$URL_TO_SIGN"

SIG=$(node ivisig.js "$URL_TO_SIGN")

#echo "$SIG"

curl -s  --retry 5 'https://api2.ivi.ru/mobileapi/user/register/phone/v6/' \
  -H 'authority: api2.ivi.ru' \
  -H 'pragma: no-cache' \
  -H 'cache-control: no-cache' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'accept: application/json, text/javascript, */*; q=0.01' \
  -H 'dnt: 1' \
  -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://www.ivi.tv' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.ivi.tv/' \
  -H 'accept-language: ru-UA,ru;q=0.9' \
  --data-raw 'phone=%2B'"$PHONE2"'&device=Windows+Chrome+v.99.0.4844.51+34e61&delivery_method=call&ts='"$KEY"'&sign='"$SIG"'&app_version=870&session='"$SESSIVI"'&session_data='"$SESSION_DATA" \
  --compressed

echo ""

pkill -sighup tor 2>/dev/null
