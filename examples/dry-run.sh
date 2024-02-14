#!/bin/bash

# see https://github.com/Cub0n/certbot-desec-docker

# docker build -t yourdockeraccount/certbot certbot-desec-docker/

EMAIL=your.email.tld
DOMAIN=your.domain.tld
# if you like to, you add more domains to your certificate
ADDITIONAL_DOMAINS="-d domain1.tld -d *.domain1.tld -d domain2.tld -d *.domain2.tld"


docker run -it --rm --name certbot \
        -v /etc/letsencrypt:/etc/letsencrypt \
        -v /var/lib/letsencrypt:/var/lib/letsencrypt \
        ghcr.io/cub0n/certbot-desec-docker:latest certonly --non-interactive --agree-tos --email $EMAIL \
        --authenticator dns-desec \
        --dns-desec-credentials /etc/letsencrypt/secrets/$DOMAIN.ini \
        -d "$DOMAIN" \
        -d "*.$DOMAIN" \
        ${ADDITIONAL_DOMAINS}
        --dry-run
