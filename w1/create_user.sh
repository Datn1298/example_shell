#! /bin/bash

# tao nguoi dung moi
# input: user
# output: user


echo "Enter the User-name :"
read create_user
if [[ $(sudo cat /etc/passwd | grep "$create_user") ]];
then
	echo "user $create_user already exist!"
else
	sudo useradd $create_user
	sudo mkdir /home/$create_user/.ssh
	sudo chown $create_user:$create_user /home/$create_user/.ssh
	sudo chmod 700 /home/$create_user/.ssh
	sudo ssh-keygen -t rsa -N "" -f /home/$create_user/.ssh/id_rsa 2>/dev/null
	sudo chown $create_user:$create_user /home/$create_user/.ssh/id_rsa
	sudo chown $create_user:$create_user /home/$create_user/.ssh/id_rsa.pub
	sudo touch /home/$create_user/.ssh/authorized_keys
	sudo cp /home/$create_user/.ssh/id_rsa.pub /home/$create_user/.ssh/authorized_keys
	sudo chmod 600 /home/$create_user/.ssh/authorized_keys
	sudo chown $create_user:$create_user /home/$create_user/.ssh/authorized_keys
fi