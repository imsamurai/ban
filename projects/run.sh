#!/bin/bash

echo "ExitNodes {ru}">> /etc/tor/torrc
echo "StrictNodes 1" >> /etc/tor/torrc
service tor restart


