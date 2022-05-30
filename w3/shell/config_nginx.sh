#! /bin/bash

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

systemctl restart nginx.service