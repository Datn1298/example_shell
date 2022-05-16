#!/bin/bash

Adding_Users () {
	echo "Enter the User-name : $1"
	if [[ $(sudo cat /etc/passwd | grep "$1") ]];then
		echo "user $1 already exist!"
	else
# them nguoi dung
		sudo useradd $1
# tao thu muc .ssh
		sudo mkdir /home/$1/.ssh
# doi user:group
		sudo chown $1:$1 /home/$1/.ssh
# cap quyen rwx cho user
		sudo chmod 700 /home/$1/.ssh
# sinh bo key-gen de ssh
		sudo ssh-keygen -t rsa -N "" -f /home/$1/.ssh/id_rsa 2>/dev/null
# doi user:group
		sudo chown $1:$1 /home/$1/.ssh/id_rsa
		sudo chown $1:$1 /home/$1/.ssh/id_rsa.pub
# tao file authorized_keys
		sudo touch /home/$1/.ssh/authorized_keys
# copy public key vaof authorized_keys
		sudo cp /home/$1/.ssh/id_rsa.pub /home/$1/.ssh/authorized_keys
# cap quyen rw cho user
		sudo chmod 600 /home/$1/.ssh/authorized_keys
# doi user:group
		sudo chown $1:$1 /home/$1/.ssh/authorized_keys
	fi
}

Adding_Users $1
