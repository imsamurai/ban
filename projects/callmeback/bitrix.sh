#!/bin/bash

FILE=./ph.txt

lc=$(wc -l "$FILE" | grep -Eo '[0-9]+')


while true
do
	# get a random number between 1 and $lc
	rnd=$RANDOM
	let "rnd %= $lc"
	((rnd++))

	# traverse file and find line number $rnd
	i=0
	while read -r line; do
 	((i++))
 	[ $i -eq $rnd ] && break
	done < $FILE

	PHONE="$line"
	NAME=$(cat names.txt | shuf | head -n 1)

  pkill -sighup tor 2>/dev/null

  echo "$NAME - $PHONE"
	curl -s -XPOST --data "values={\"LEAD_NAME\":[\"$NAME\"],\"LEAD_PHONE\":[\"$PHONE\"]}&consents={\"AGREEMENT_2\":\"Y\"}&recaptcha=undefined&timeZoneOffset=-120&id=60&trace={}&sec=gczezk" https://profav.bitrix24.ru/bitrix/services/main/ajax.php?action=crm.site.form.fill | jq -c '.result' 2> /dev/null || echo "error"
done

