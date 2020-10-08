docker pull certbot/certbot

docker run -it --rm --name certbot \
-v "/etc/letsencrypt:/etc/letsencrypt" \
-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
certbot/certbot \
certonly --manual --agree-tos -d "linuxwork.in" --server https://acme-v02.api.letsencrypt.org/directory