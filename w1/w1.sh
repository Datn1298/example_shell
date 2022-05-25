#!/usr/bin/bash

create_user(){
	echo "===== CREATE NEW USER ====="
	while :
		do
			echo -n "Enter the Username: "
			read create_user
			if [[ $(cat /etc/passwd | grep "$create_user") ]];
			then
				echo "user $create_user already exist!"
			else
				adduser $create_user
				passwd $create_user
				return 0
			fi
		done
}

delete_user(){
	echo "===== DELETE USER ====="
	echo -n "Enter the user:"
	read del_user

	if [[ ! $(cat /etc/passwd | grep "$del_user") ]];
	then
		echo "user $del_user is not exist!"
	else
		userdel -r $del_user
	fi
}

edit_user_permission(){
	echo "===== GRANT SUDO PERMISSION FOR USER ====="
	echo -n "Enter the user: "
	read edit_user

	if [[ ! $(cat /etc/passwd | grep "$edit_user") ]];
	then
		echo "user $edit_user is not exist!"
	else
		usermod -aG sudo $edit_user
	fi
}


list_user(){
	echo "===== LIST USER ====="
	cat /etc/passwd
}

list_group(){
	echo "===== LIST GROUP ====="
	cat /etc/group
}

check_file_permission(){
	echo "===== CHECK PERMISSION OF FILE ====="
	echo -n "Enter file name: "

	read file
	ls -la | grep $file

	path=${file%/*}
	name=${file##*/}

	if [$path -eq $name]
	then
		ls -la | grep $name
	else
		temp=$PWD
		cd $path
		ls -la | grep $name
		cd $temp
	fi
}

edit_file_permission(){
	echo "===== CHANGE FILE PERMISSION ====="
	echo -n "Enter file name: "
	read filename
	echo -n "Permission: "
	read permission
	chmod $permission $filename
}

install_apache(){
  echo "===== INSTALL APACHE2 ====="
	apt update
	# Install Apache2
	apt install apache2 -y
	# Firewall configuration
	# ufw app list
	ufw allow 'Apache'

	# config_apache2
}

config_apache2(){
	echo "===== CONFIGUARE APACHE2 ====="

	# echo -n "Enter your domain: "
	# read your_domain

	# mkdir -p /var/www/$your_domain/html
	# chown -R $USER:$USER /var/www/$your_domain/html
	# chmod -R 755 /var/www/$your_domain

	# # Make a sample page for your website
	# touch /var/www/$your_domain/html/index.html
	# cat <<EOF | tee /var/www/$your_domain/html/index.html
	# <html>
	# 	<head>
	# 		<title>Welcome to Your_domain!</title>
	# 	</head>
	# 	<body>
	# 		<h1>Success!  The your_domain virtual host is working!</h1>
	# 	</body>
	# </html>
	# EOF
	# #

	# # Create a virtual host file
	# touch /etc/apache2/sites-available/$your_domain.conf
	# cat <<EOF | tee /etc/apache2/sites-available/$your_domain.conf
	# echo "<VirtualHost *:80>
	# 	ServerAdmin admin@$your_domain
	# 	ServerName $your_domain
	# 	ServerAlias $your_domain
	# 	DocumentRoot /var/www/$your_domain/html
	# 	ErrorLog ${APACHE_LOG_DIR}/error.log
	# 	CustomLog ${APACHE_LOG_DIR}/access.log combined
	# </VirtualHost>"
	# EOF

	# # Activate virtual host configuration file
	# a2ensite $your_domain.conf
	# a2dissite 000-default.conf

	# cat <<EOF | tee -a apache.conf
	# # X-XSS-Protection: 
	# Header set X-XSS-Protection "1; mode=block"

	# # HTTP Strict Transport Security
	# Header set Strict-Transport-Security "max-age=31536000;includeSubDomains; preload"

	# # X-Frame-Options: them vao file nginx.conf
	# Header always append X-Frame-Options DENY

	# # X-Content-Type-Options
	# Header set X-Content-Type-Options nosniff

	# # Content Security Policy
	# Header set Content-Security-Policy "default-src 'self';"

	# ServerSignature Off
	# ServerTokens Prod
	# EOF

	# systemctl restart apache2.service
}

install_nginx(){
	echo "===== INSTALL NGINX ====="
	# install nginx
	apt update
	apt install nginx -y
	# Adjusting the Firewall
	# ufw app list
	ufw allow 'Nginx HTTP'

	# config_nginx
}

config_nginx(){
	echo "===== CONFIGUARE NGINX ====="
	# cat <<EOF | tee -a nginx.conf

	# # X-XSS-Protection: 
	# add_header X-XSS-Protection "1; mode=block"

	# # HTTP Strict Transport Security
	# add_header Strict-Transport-Security 'max-age=31536000; 

	# # X-Frame-Options
	# add_header X-Frame-Options “DENY”;

	# # X-Content-Type-Options
	# add_header X-Content-Type-Options nosniff;

	# # Content Security Policy
	# add_header Content-Security-Policy "default-src 'self'";
	# EOF

	# systemctl restart nginx
}

install_php(){
	echo "===== CONFIGUARE PHP ====="
	apt update
	apt install php -y
}

install_mysql(){
	echo "===== CONFIGUARE MYSQL ====="
	apt update
	apt install mysql-server -y
	mysql_secure_installation
}
while :
do
	echo "
		1. Create new user 
		2. Delete user
		3. Edit user permission
		4. List user
		5. List group
		6. Check file permission
		7. Edit file permission
		8. Install Apache2
		9. Install Nginx
		10. Install PHP
		11. Install MySQL
		12. Configuare Apache2
		13. Configuare Nginx
		14. exit"
		read -p "Enter your choice: " choice


	case $choice in 
		1) create_user ;;
	  2) delete_user ;;
		3) edit_user_permission ;;
		4) list_user ;;
		5) list_group ;;
		6) check_file_permission ;;
		7) edit_file_permission ;;
		8) install_apache ;;
		9) install_nginx ;;
		10) install_php ;;
		11) install_mysql ;;
		12) config_apache2 ;;
		13) config_nginx ;;
		14) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done