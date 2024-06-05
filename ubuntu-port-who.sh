#!/bin/bash

if [ ! -e /usr/sbin/lsof ]; then
	sudo apt-get update -y
	sudo apt-get install lsof -y
fi

lsof -P | grep '$1'
