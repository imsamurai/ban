#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+7([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/%28\1%29+\2-\3-\4/')"

echo "+$PHONE"

RESULT=$(curl -s --retry 3 'https://lk.superbankrot.ru/db_registration.php' \
  -H 'authority: lk.superbankrot.ru' \
  -H 'cache-control: max-age=0' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'origin: https://lk.superbankrot.ru' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'dnt: 1' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-user: ?1' \
  -H 'sec-fetch-dest: document' \
  -H 'referer: https://lk.superbankrot.ru/register.php' \
  -H 'accept-language: ru-UA,ru;q=0.9' \
  --data-raw "user_email=$PHONE&promo=&login=%D0%97%D0%B0%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D1%82%D1%8C%D1%81%D1%8F" \
  --compressed)

if [ "$(echo "$RESULT" | grep -c 'поступит звонок')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
