#!/bin/bash
new_hostname=$1
sudo hostnamectl set-hostname $new_hostname
echo "host name now is:${new_hostname}"
