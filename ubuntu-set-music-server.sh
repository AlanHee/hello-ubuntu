#!/bin/bash
# e.g: set-music-server.sh music

# determine if music fold has craeted
if [ -e ~/$1/docker-compose.yaml ]; then
	echo 'Opp music config file esisted.'
	exit 1
fi
# determine if install docker
if ! docker $cmd &>/dev/null; then
	apt install -qyy docker
fi
# determine if install docker-compose
if ! docker-compose $cmd &>/dev/null; then
	apt install -qyy docker-compose
fi

cat <<EOF >config
version: "3"
services:
  navidrome:
    image: deluan/navidrome:latest
    user: root:0
    restart: unless-stopped
    ports:
      - "4533:4533"
    environment:
      # Optional: put your config options customization here. Examples:
      ND_SCANSCHEDULE: 1h
      ND_LOGLEVEL: info  
      ND_SESSIONTIMEOUT: 24h
      ND_BASEURL: ""
    volumes:
      - "/root/music/db:/data"
      - "/root/music/asset:/music:ro"
EOF

mkdir -p ~/$1/{db,asset}
mv $config ~/$1/docker-compose.yaml
cd ~/$1
docker-compose up -d .
echo 'Music server setup.'
