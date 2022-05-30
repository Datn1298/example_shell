#! /bin/bash

echo -n "Enter your domain: "
read your_domain

cat <<EOF | tee -a /
<VirtualHost *:80>
	ServerAdmin admin@$your_domain
	ServerName $your_domain
	ServerAlias $your_domain
	DocumentRoot /var/www/$your_domain/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

cat <<EOF | tee -a apache.conf
# X-XSS-Protection: 
Header set X-XSS-Protection "1; mode=block"

# HTTP Strict Transport Security
Header set Strict-Transport-Security "max-age=31536000;includeSubDomains; preload"

# X-Frame-Options: them vao file nginx.conf
Header always append X-Frame-Options DENY

# X-Content-Type-Options
Header set X-Content-Type-Options nosniff

# Content Security Policy
Header set Content-Security-Policy "default-src 'self';"

ServerSignature Off
ServerTokens Prod
EOF

systemctl restart apache2.service


