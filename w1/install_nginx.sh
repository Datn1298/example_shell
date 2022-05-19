#! /bin/bash

# install Nginx cho distro Ubuntu

# install nginx
apt update
apt install nginx

# Adjusting the Firewall
ufw app list

# sudo ufw allow 'Nginx HTTP'
ufw status

systemctl status nginx

systemctl start nginx

cat <<EOF | tee -a nginx.conf

# X-XSS-Protection: 
add_header X-XSS-Protection "1; mode=block"

# HTTP Strict Transport Security
add_header Strict-Transport-Security 'max-age=31536000; 

# X-Frame-Options
add_header X-Frame-Options “DENY”;

# X-Content-Type-Options
add_header X-Content-Type-Options nosniff;

# Content Security Policy
add_header Content-Security-Policy "default-src 'self'";
EOF

systemctl restart nginx