## certbot-desec-docker
deSEC (https://desec.io/) DNS Authenticator for Certbot on Docker.

## Forewords
According to the used underlying architecture (here armv7) it is necessary to select the right image (certbot/certbot:arm32v6-*) beforehand, otherwise _pip install certbot-dns-desec_ will fail (ErrorMessage: _exec container process /bin/sh: Exec format error_).

## Build
Change to directory where the Dockerfile is located and execute: 
* docker build -t certbot:latest 
* buildah bud -f Dockerfile -t certbot:latest (for Podman)

You can choose the tag (-t) on your own. The builded image is automatically added to your local docker/podman image repository.

## Configuration
Configure your Secret with deSec token as described under [Request Certificate](https://github.com/desec-io/certbot-dns-desec#request-certificate). The $DOMAIN.ini has to be saved under the volume path ( -v /path/to/etc/letsencrypt ).
For the first run, the eMail Adress is also needed.

# Starting
with Docker:
```bash
docker run -d --name certbot \
        -v /path/to/etc/letsencrypt:/etc/letsencrypt \
        -v /path/to/var/lib/letsencrypt:/var/lib/letsencrypt \
        ghcr.io/cub0n/certbot-desec-docker:latest certonly --non-interactive --agree-tos --email $EMAIL \
        --authenticator dns-desec \
        --dns-desec-propagation-seconds 300 \
        --dns-desec-credentials /etc/letsencrypt/secrets/$DOMAIN.ini \
        -d "$DOMAIN" \
        -d "*.$DOMAIN"
```

with Podman:
```bash
podman run -d --name certbot \
        -v /path/to/etc/letsencrypt:/etc/letsencrypt:Z \
        -v /path/to/var/lib/letsencrypt:/var/lib/letsencrypt:Z \
        ghcr.io/cub0n/certbot-desec-docker:latest certonly --non-interactive --agree-tos --email $EMAIL \
        --authenticator dns-desec \
        --dns-desec-propagation-seconds 300 \
        --dns-desec-credentials /etc/letsencrypt/secrets/$DOMAIN.ini \
        -d "$DOMAIN" \
        -d "*.$DOMAIN"
```
Increase the wait time with --dns-desec-propagation-seconds 300 to guarantee a certificate renewel. (https://talk.desec.io/t/failing-to-get-the-certificates-generated-by-letsencrypt-according-to-the-documentation/1479/8)
