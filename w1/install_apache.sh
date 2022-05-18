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

# Create a directory for $your_domain
your_domain=""

mkdir -p /var/www/$your_domain/html
chown -R $USER:$USER /var/www/$your_domain/html
chmod -R 755 /var/www/$your_domain

# Make a sample page for your website
touch /var/www/$your_domain/html/index.html
# 

# Create a virtual host file
touch /etc/apache2/sites-available/$your_domain.conf


echo "<VirtualHost *:80>
	ServerAdmin admin@$your_domain
	ServerName $your_domain
	ServerAlias $your_domain
	DocumentRoot /var/www/$your_domain/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/$your_domain.conf

# Activate virtual host configuration file
a2ensite $your_domain.conf
a2dissite 000-default.conf


# cau hinh: them vao file apache2.conf hoac httpd.conf
# X-XSS-Protection: 
# Header set X-XSS-Protection "1; mode=block"
echo "
# X-XSS-Protection: 
Header set X-XSS-Protection "1; mode=block"
" >> httpd.conf
# systemctl restart apache2.service

# HTTP Strict Transport Security
# Header set Strict-Transport-Security "max-age=31536000;includeSubDomains; preload"
# systemctl restart apache2.service
echo "
# HTTP Strict Transport Security
Header set Strict-Transport-Security "max-age=31536000;includeSubDomains; preload"
" >> httpd.conf

# X-Frame-Options: them vao file nginx.conf
# Header always append X-Frame-Options DENY
# systemctl restart apache2.service
echo "
# X-Frame-Options: them vao file nginx.conf
Header always append X-Frame-Options DENY
" >> httpd.conf

# X-Content-Type-Options
# Header set X-Content-Type-Options nosniff
# systemctl restart apache2.service
echo "
# X-Content-Type-Options
Header set X-Content-Type-Options nosniff
" >> httpd.conf

# Content Security Policy
# Header set Content-Security-Policy "default-src 'self';"
# systemctl restart apache2.service
echo "
# Content Security Policy
Header set Content-Security-Policy "default-src 'self';"
" >> httpd.conf