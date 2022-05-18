#! /bin/bash

# tao nguoi dung moi
# input: user
# output: user


echo "Enter the User-name :"
read create_user
if [[ $(cat /etc/passwd | grep "$create_user") ]];
then
	echo "user $create_user already exist!"
else
	useradd $create_user
	mkdir /home/$create_user/.ssh
	chown $create_user:$create_user /home/$create_user/.ssh
	chmod 700 /home/$create_user/.ssh
	ssh-keygen -t rsa -N "" -f /home/$create_user/.ssh/id_rsa 2>/dev/null
	chown $create_user:$create_user /home/$create_user/.ssh/id_rsa
	chown $create_user:$create_user /home/$create_user/.ssh/id_rsa.pub
	touch /home/$create_user/.ssh/authorized_keys
	cp /home/$create_user/.ssh/id_rsa.pub /home/$create_user/.ssh/authorized_keys
	chmod 600 /home/$create_user/.ssh/authorized_keys
	chown $create_user:$create_user /home/$create_user/.ssh/authorized_keys
fi