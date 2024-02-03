#!/bin/bash

if [ ! -e /usr/sbin/ufw ]; then
	sudo apt-get update -y
	sudo apt-get install ufw -y
fi

if sudo ufw status | grep -q "$1"; then
	echo "$1 port has open"
else
	sudo ufw allow $1/tcp
	echo "success open port $1"
fi
