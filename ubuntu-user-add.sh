#!/bin/bash

while true; do
	read -p 'enter your name:' userName
	if [ ! -e=$userName ]; then
		echo 'can not be empty name'
		break
	else
		# `id` cmd show users uid gid groug
		echo "hello $userName"
		# while make `useradd` add record in:
		# /etc/passwd
		# /etc/shadow

		useradd -m $userName
		passwd $userName
		echo "Added user $userName"
		break
	fi
done

#TODO process user group
# more cmd: usermod userdel
# how to append group?
# useradd -g group1 user1
# groupadd group1
# usermod -g group1 user1
# groupdel
