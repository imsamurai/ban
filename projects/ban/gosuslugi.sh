curl -ksi 'https://www.gosuslugi.ru/api/opentracing' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
  -H 'DNT: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  -H 'Origin: https://www.gosuslugi.ru' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://www.gosuslugi.ru/' \
  -H 'Accept-Language: ru-UA,ru;q=0.9' \
  -H 'Cookie: c_PR0U9Phollo3=4E01F33FE3D7B662878D9D5A6E90A33E; c_PR0U9Phollo3_2=23088; c_PR0U9Phollo3_3=1373634892; userSelectedLanguage=ru; nau=376b5eba-a66f-1587-568f-2334bfb6221e; usi_portal=rBopZmJF/+KFjGpuDemTAg==; loc=B; ns-nlb=ffffffffaf12361245525d5f4f58455e445a4a423660; _ym_uid=1648754677102981099; _ym_d=1648754677; _ym_isad=1; NSC_q00qhvtubu=ffffffffaf12375045525d5f4f58455e445a4a423660; TS014d06c8=01474e7625f00e25998adf62a443d7c7a21a82ef26258a150dda90e1c77e885aa1a8858196b22100f7296219bfdf0cda56f9dca6edcfa05e901e8d541d4badad2dbf05257d7de473b42e2516be4ded0b3ed39575d620d10dc79610ea68a2f68d4bb9e7d64392ec2577d06bbb9c07b2e905b3074ca63053f894ea594f92d87b289a08dd3aafc3bfc1d8be15c9729c52a85581ddf47d468f43fa6d9f48b0341f166450d90ff3' \
  --data-raw '[{"traceId":"db010fc6bc0caabf","id":"db010fc6bc0caabf","name":"get","kind":"CLIENT","timestamp":1648754995555000,"duration":1002000,"localEndpoint":{"serviceName":"form-frontend"},"remoteEndpoint":{"serviceName":"form-backend"},"tags":{"http.path":"//www.gosuslugi.ru/api/mainpage/v4","http.status_code":"200","serviceCode":"","userId":"userId","env":"env"}},{"traceId":"db010fc6bc0caabf","parentId":"db010fc6bc0caabf","id":"7bcc354d426c0344","name":"get","kind":"CLIENT","timestamp":1648754996581000,"duration":800000,"localEndpoint":{"serviceName":"form-frontend"},"remoteEndpoint":{"serviceName":"form-backend"},"tags":{"http.path":"//www.gosuslugi.ru/api/nsi/v1/epgu/detectRegion","http.status_code":"204","serviceCode":"","userId":"userId","env":"env"}}]' \
  --compressed
