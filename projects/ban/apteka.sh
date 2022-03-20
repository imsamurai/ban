#!/bin/bash

RESULT="$(curl -ski 'https://api.apteka.ru/Feedback?cityId=5e57803249af4c0001d64407' -0 \
                      -H 'Range: bytes=18-18446744073709551615' \
                      -H 'Connection: keep-alive' \
                      -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
                      -H 'X-ACTIVE-EXP: xiIfUJebR_OcLrbj56nRag:0' \
                      -H 'DNT: 1' \
                      -H 'sec-ch-ua-mobile: ?0' \
                      -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxZmRkOTJmZi05Y2E2LTRjMDctOWI2NC1mNWE0NDEwZGQ2ZWMiLCJqdGkiOiI2MjM2MWNhNDUzMTkwODRlYTZlMzMzMTIiLCJleHAiOjE2NjMyNjU0NDQsIm5iZiI6MTY0NzcxMzQ0NCwicm9sZSI6IlNoYWRvd1VzZXIiLCJpYXQiOjE2NDc3MTM0NDR9.mzKODbSKVIgoh8_2qWnijIj83RL9z8srWskb9rseABkkN_35b12GbPvt9m0wkN_GK5S7ztszH5zTI-JQ_fmPhKOmrO5Zuz-KXJ5V1_h08zOrjlVVmu3dYeTCIvE-fsYzaltj8uQ_5Zw5LjJVEcn1jJaPvH88WueYKNXlNHs59jm-EUx3LcGFQvcU9s_BSAxOaa9-7clWE18KVxUB57DbNNoz_6dmZsEYOZyTgcF6-cYMMxiy2sV1qGF98NScXtHEPzhjVrCcPeVW5mROKgbk6h4nJy_VYsjiYRm0z_WhuaZyuht5EU2McCasxGt_2utlUW2c3-OpXYCSEOtDNAawvWrJPIWJQti_dZ_GorXCrvKbEB_51csOmZHzi57dfYNrHKfHf9Xioj0NM96Qp16Ni3isDIqWBqAzl-ppc96CqYM6HsQqz-qckxbDc1rolfTOKi8Z8dCAARylslvOuuxCfLt4vPnTAGBjUQ05WdqvyipCpFogl2uoVA-wE9EgDBi8KRjivn8mC52n1eV2AOlnjulNxxcVxm-K6N3xowlj4r_IxuHPtGt05qQItVXIeqB5rUNdfub4D9TdHQJi-K9xBwEQi1ZhACpCq-jrzUoWQlF28VYDga7gHcnzRClt6as-ulX0DOuPLy4g1-IU80V7bfI6fT37svx3LydlRwaUmRI' \
                      -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryVF4iAgmE788e6Uct' \
                      -H 'Accept: application/json, text/plain, */*' \
                      -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36' \
                      -H 'sec-ch-ua-platform: "Windows"' \
                      -H 'Origin: https://apteka.ru' \
                      -H 'Sec-Fetch-Site: same-site' \
                      -H 'Sec-Fetch-Mode: cors' \
                      -H 'Sec-Fetch-Dest: empty' \
                      -H 'Referer: https://apteka.ru/' \
                      -H 'Accept-Language: ru-UA,ru;q=0.9' \
                      --data-binary '@apteka.txt' \
                      --compressed)"

if [ "$(echo "$RESULT" | grep -c 'Feedback')" = "0" ]; then
  echo "$RESULT" | grep HTTP | head -1
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "$RESULT" | grep Feedback
  echo "true"
fi
