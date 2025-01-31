#!/bin/bash

# get
docker pull jellyfin/jellyfin

# run
docker run -d \
  --name jellyfin \
	-p 8096:8096 \
 	-v ~/jellyfin/config:/config \
	-v ~/jellyfin/media:/media \
	jellyfin/jellyfin
