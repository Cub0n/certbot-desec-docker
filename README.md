## certbot-desec-docker
Project for Building a deSEC DNS Authenticator plugin for Certbot (https://desec.io/).

## Forewords
* [certbot-dns-desec](https://pypi.org/project/certbot-dns-desec/) works only with Certbot < 2.0.0, otherwise a failure with zope module not found is thrown.
Therefore the Docker image is built with Certbot-Image _certbot/certbot:v1.32.0_ (see https://hub.docker.com/r/certbot/certbot/tags).
* According to the used underlying architecture (here armv7) it is necessary to select the right image (certbot/certbot:arm32v6-v1.32.0) beforehand, otherwise _pip install certbot-dns-desec_ will fail (ErrorMessage: _exec container process /bin/sh: Exec format error_).

## Build
Change to directory where the Dockerfile is located and execute: 
* docker build -t certbot:latest 
* buildah bud -f Dockerfile -t certbot:latest (for Podman)

You can choose the tag (-t) on your own. The builded image is automatically added to your local docker/podman image repository.

## Configuration
Configure your Secret with deSec token as described under [Request Certificate](https://pypi.org/project/certbot-dns-desec).
For the first run, the eMail Adress is also needed.

# Starting
with Docker:
```bash
docker run -d --name certbot \
        -v /path/to/etc/letsencrypt:/etc/letsencrypt \
        -v /path/to/var/lib/letsencrypt:/var/lib/letsencrypt \
        localhost/certbot:latest certonly --non-interactive --agree-tos --email $EMAIL \
        --authenticator dns-desec \
        --dns-desec-credentials /etc/letsencrypt/secrets/$DOMAIN.ini \
        -d "$DOMAIN" \
        -d "*.$DOMAIN"
```

with Podman:
```bash
podman run -d --name certbot \
        -v /path/to/etc/letsencrypt:/etc/letsencrypt:Z \
        -v /path/to/var/lib/letsencrypt:/var/lib/letsencrypt:Z \
        localhost/certbot:latest certonly --non-interactive --agree-tos --email $EMAIL \
        --authenticator dns-desec \
        --dns-desec-credentials /etc/letsencrypt/secrets/$DOMAIN.ini \
        -d "$DOMAIN" \
        -d "*.$DOMAIN"
```
