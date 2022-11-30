FROM docker.io/certbot/certbot:arm32v6-v1.32.0

# Install the DNS plugin
RUN pip install certbot-dns-desec==1.2.0
