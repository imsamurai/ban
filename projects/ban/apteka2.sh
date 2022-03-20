#!/bin/bash

RESULT="$(curl -skiv 'https://apteka.ru/search/?q=%3C%F0%9F%87%BA%F0%9F%87%A6%3E%3F%23%25%24%21%26%2a%5C%5C%5C%2F%2F%2F%28%29_%2B%60%60%60%00&q=%3C%3E%3F%23%25%24%21%26%2a%5C%5C%5C%2F%2F%2F%28%29_%2B%60%60%60%00&q=sd&q=we&q=wer')"

echo "$RESULT" # | grep title
pkill -sighup tor 2>/dev/null
