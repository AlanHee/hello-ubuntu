#!/bin/bash
if [[ "$1" =~ ^-?[0-9]+$ ]]; then
	# is number kill as PID
	kill -9 $1
else
	# is string kill as app name
	killall $1
fi
