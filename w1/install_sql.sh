#! /bin/bash

# install mysql cho distro Ubuntu
echo "===== CONFIGUARE MYSQL ====="
apt update

apt install mysql-server -y

mysql_secure_installation