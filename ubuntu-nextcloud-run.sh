#!/bin/bash
# AlanHee (alan.hee@outlook.com) 2024.02.07
# what is nextcloud?
# 	free write in php
# 	suport file share
# 	suport webdav
# 	suport muilt platfrom

sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
docker run -d -p 8080:80 nextcloud
echo 'done'
echo 'nextcloud is runing localhost:8080'
