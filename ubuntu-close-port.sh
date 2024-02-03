#!/bin/bash

if [ ! -e /usr/sbin/ufw ]; then
	sudo apt-get update -y
	sudo apt-get install ufw -y
fi

if sudo ufw status | grep -q "$1"; then
	sudo ufw delete allow $1/tcp
	echo "$1 port success closed"
else
	echo "$1 port has closed"
fi
