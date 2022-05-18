#! /bin/bash

# install Nginx cho distro Ubuntu

# install nginx
sudo apt update
sudo apt install nginx

# Adjusting the Firewall
sudo ufw app list

# sudo ufw allow 'Nginx HTTP'
sudo ufw status

systemctl status nginx

sudo systemctl start nginx

# cau hinh: them vao file nginx.conf:
# X-XSS-Protection: 
# add_header X-XSS-Protection "1; mode=block"
echo "add_header X-XSS-Protection "1; mode=block"" >> nginx.conf
# restart lai nginx

# HTTP Strict Transport Security
# add_header Strict-Transport-Security 'max-age=31536000; 
# restart lai nginx

# X-Frame-Options: them vao file nginx.conf
# add_header X-Frame-Options “DENY”;
# systemctl restart nginx.service

# X-Content-Type-Options
# add_header X-Content-Type-Options nosniff;
# systemctl restart nginx.service

# Content Security Policy
# add_header Content-Security-Policy "default-src 'self'";
# systemctl restart nginx.service