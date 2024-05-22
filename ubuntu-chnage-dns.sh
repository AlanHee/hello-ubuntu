#!/bin/bash
# check if run in root 
# Resolve error: Got socket error trying to find package lints at https://pub.dev.
if [[ $EUID -ne 0 ]]; then                                                  echo "the script should run in root" 1>&2
   exit 1
fi
# backup 1st
cp /etc/resolv.conf /etc/resolv.conf.bak
# then replace 
cat << EOF | sudo tee /etc/resolv.conf > /dev/null
nameserver 8.8.8.8
# If your need more dsn record
# nameserver 8.8.4.4
EOF
echo "Current DNS is 8.8.8.8"
