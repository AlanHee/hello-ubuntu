#!/bin/bash
read -p 'set host name:' new_hostname
sudo hostnamectl set-hostname $new_hostname
echo "host name now is:${new_hostname}"
