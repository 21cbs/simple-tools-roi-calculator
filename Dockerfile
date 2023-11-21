FROM  ghcr.io/kycloudtech/nginx:1.23.4
COPY dist /opt/static/
COPY nginx.conf /etc/nginx/nginx.conf
