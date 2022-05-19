#! /bin/bash

# install php cho distro Ubuntu

apt update

# check installed apache2
# if installed
# sudo apt install php libapache2-mod-php
# sudo systemctl restart apache2
if [ (dpkg -s apache2) -eq 0 ]; then
  apt install php libapache2-mod-php -y
	systemctl restart apache2
fi

# check installed nginx
# if installed
# sudo apt install php-fpm
# sudo systemctl restart nginx

if [ (dpkg -s nginx) -eq 0 ]; then
  apt install php php8.0-fpm
	systemctl restart nginx
fi