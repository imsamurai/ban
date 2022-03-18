#!/bin/bash

PHONE="$(echo "$1" | sed -E 's/^\+([0-9]{1,2})([0-9]{3})([0-9]{3})([0-9]{2})([0-9]{2})$/+\1 (\2) \3-\4-\5/')"

echo "$PHONE"


RESULT=$(curl -sk --retry 3 'https://api.apteka.ru/Auth/Auth_Code?cityId=5e57979c57dec70001a6e153' \
-H 'Connection: close' \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
-H 'DNT: 1' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json, text/plain, */*' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36' \
-H 'sec-ch-ua-platform: "Windows"' \
-H 'Origin: https://apteka.ru' \
-H 'Sec-Fetch-Site: same-site' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Referer: https://apteka.ru/' \
-H 'Accept-Language: ru-UA,ru;q=0.9' \
-H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ZjQ2ZWI3NS0zZmY2LTQ0MDAtODBmYy0yNGU2OWRkOGM3MmMiLCJqdGkiOiI2MjM0ZGQwN2UzNTFmYTQ3OTk2ZTk1NjEiLCJleHAiOjE2NjMxODM2MjMsIm5iZiI6MTY0NzYzMTYyMywicm9sZSI6IlNoYWRvd1VzZXIiLCJpYXQiOjE2NDc2MzE2MjN9.MhWYurUckYjMuNnvj_gTgSfvtiLE6nwLG6MW_s4JkkNmUCEHUxRCBs0u2dId5AzZAXa4hZegY35aFHW3IbmfSXRxU5aTx39SM0mqXtiCITGejAxOm5nBALCy1gW9YsfmJxAuW-Ux1ZuIibuu3APOFOZXzuEplipBtggtaNxnaPODiFzqTqwcEyl8LLs2bL8X94aHcUuN-HqEudAxGCMrTgXJJa0WXdhnCWCxnFV8KK2UCjPeSPOBz2Tc3rtFc1qQacl2TL_fbb2AZhAW2nP92tMCYO2ygTad9Ft6zrrwRRbMYKQNfH6QHI0j9NkEsHq7tkQppo4Vyrj47ggERy2mbZxdHhDdwRVypDkBWA0uQxLSVYiUj5lliH5_EuP2dJltZ1SvE5OniwszS_nl8cF0yCP49Skqt9f5GbP71g0cj93hhLGxQmfyr80I6_f8QuWD_FiLf4ffo-rW7_JUXNdI4U5YZB8Zc54GtijCvzMWaCY3ndYPP4ZIKOvW0Edd-sqDt4R6H1Mf9k-DgKcO2OLWRzw68jtFw3mYJmf5nzXCso08W7ZayXOR27xRfeSP8eGADaytuNwvcyzaoVkLwCS65Onxmn8LQFRhkSm42ZRKJ5FNlC_pPCFAU026fNI0bbvq4xE3k0lxQeHHzKimUwNghdnpHar2szmxhvJZriP-l8o' \
--data-raw '{"phone":"'"$PHONE"'","u":"U"}' \
--compressed)

if [ "$(echo "$RESULT" | grep -c 'newUser')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
