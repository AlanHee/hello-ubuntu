#!/bin/bash

if [ -z $1 ] || [ -z $2 ]; then
  echo "usage: ubuntu-server-webdav.sh admin password"	
	exit 0
fi

WEBDAV_USER="$1"
WEBDAV_PASSWORD="$2"
WEBDAV_PORT=8081
WEBDAV_DATA_DIR="webdav-server"
mkdir -p ~/$WEBDAV_DATA_DIR

docker pull bytemark/webdav

docker run -d --name webdavserver \
  -p $WEBDAV_PORT:80 \
	-v ~/$WEBDAV_DATA_DIR:/var/lib/dav \
	-e AUTH_TYPE=Basic \
  -e USERNAME=$WEBDAV_USER \
  -e PASSWORD=$WEBDAV_PASSWORD \
  bytemark/webdav

# verified
if docker ps -f "name=webdavserver" --quiet; then
  echo "WebDAV success runing, http://localhost:$WEBDAV_PORT"
else
  echo "WebDAV server no runing"
  exit 1
fi
