#! /bin/bash

# tao nguoi dung moi
# input: user
# output: user


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
				# passwd $create_user
				return 0
			fi
		done