#!/bin/bash

if [ -z $1 ]; then
	echo "gave me a space to save your email data config etc.."
	echo "eg: docker-email-server.sh email-server"
	exit 0
fi
 
DOMAIN="2025have.fun"
ADMIN_EMAIL="admin@$DOMAIN"

# create docker-compose.yml 
mkdir $1
cat <<EOL > ~/$1/docker-compose.yml
services:
  mailserver:
    image: docker.io/mailserver/docker-mailserver:latest
    hostname: mail
    domainname: "$DOMAIN"
    container_name: mailserver
    env_file:
      - mailserver.env
    ports:
      - "25:25"
      - "143:143"
      - "587:587"
      - "993:993"
    volumes:
      - ./maildata:/var/mail
      - ./mailstate:/var/mail-state
      - ./config:/tmp/docker-mailserver
    cap_add:
      - NET_ADMIN
      - SYS_PTRACE
    restart: always
EOL

# create  mailserver.env
cat <<EOL > ~/$1/mailserver.env
HOSTNAME=$DOMAIN
POSTMASTER_ADDRESS=$ADMIN_EMAIL
TZ=Asia/Shanghai

# Optional: Enable SSL/TLS (you need to provide certificates)
# DMS_SSL_TYPE=manual
# DMS_SSL_CERT=/path/to/your/cert.pem
# DMS_SSL_KEY=/path/to/your/key.pem

# Optional: Configure SPF, DKIM, DMARC (you need to set up keys and records)
# ONE_DIR=1 # Enable this if you want to use a single directory for DKIM keys
# DKIM_SELECTOR=mail # Change this to your preferred selector
# DKIM_DOMAIN=$DOMAIN
# DKIM_KEYLENGTH=2048

# Other configurations...
EOL

mkdir -p ~/$1/{maildata,mailstate,config}

docker-compose up -d

# add user
# docker exec mailserver setup mail user@domain.com password

# add alias
# docker exec mailserver setup alias anothername@domain.com user@domain.com
echo "Mail server setup."
