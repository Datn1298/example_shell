#! /bin/bash

# install Apache cho distro Ubuntu
# Update
apt update

# Install Apache2
apt install apache2 -y

# Firewall configuration
# ufw app list
ufw allow 'Apache'

# systemctl status apache2

# Create a directory for your domain
# mkdir -p /var/www/your domain/html
# chown -R $USER:$USER /var/www/your domain/html
# chmod -R 755 /var/www/your domain

# Make a sample page for your website
# touch /var/www/info.net/html/index.html
# 

# Create a virtual host file
# touch /etc/apache2/sites-available/info.net.conf
# <VirtualHost *:80>
# ServerAdmin admin@info.net
# ServerName info.net
# ServerAlias info.net
# DocumentRoot /var/www/info.net/html
# ErrorLog ${APACHE_LOG_DIR}/error.log
# CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>

# Activate virtual host configuration file
# a2ensite info.net.conf
# a2dissite 000-default.conf


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