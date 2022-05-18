#! /bin/bash

# install Apache cho distro Ubuntu

# cau hinh: them vao file apache2.conf hoac httpd.conf
# X-XSS-Protection: 
# Header set X-XSS-Protection "1; mode=block"
# systemctl restart apache2.service

# HTTP Strict Transport Security
# Header set Strict-Transport-Security "max-age=31536000;includeSubDomains; preload"
# systemctl restart apache2.service

# X-Frame-Options: them vao file nginx.conf
# Header always append X-Frame-Options DENY
# systemctl restart apache2.service

# X-Content-Type-Options
# Header set X-Content-Type-Options nosniff
# systemctl restart apache2.service

# Content Security Policy
# Header set Content-Security-Policy "default-src 'self';"
# systemctl restart apache2.service