# cai apache2
apt install apache2 -y;
cd /var/www/; 
# tai va giai nen file nextcloud
wget https://download.nextcloud.com/server/releases/nextcloud-21.0.0.zip
unzip nextcloud-21.0.0.zip;

# cai dat cac thu vien kem theo
apt install mariadb-server php7.4 php7.4-mysql php7.4-xml php7.4-zip php7.4-gd php7.4-curl php7.4-mbstring -y

# cau hinh apache2

sudo nano /etc/apache2/sites-available/nextcloud.conf
  <VirtualHost *:80>
	ServerName nextcloud.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/nextcloud
	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	#Include conf-available/serve-cgi-bin.conf
  </VirtualHost>

# link 2 file  
ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf
service apache2 restart

# doi user:group
chown -R www-data:www-data /var/www/nextcloud/

#Database Configuration
mysql -u root -p
	CREATE DATABASE nextcloud;
	GRANT ALL ON nextcloud.* to 'nextcloudusr'@'localhost' IDENTIFIED BY 'nextcloud_password';
	FLUSH PRIVILEGES;
	EXIT;

# Go to -> http://[IP]/