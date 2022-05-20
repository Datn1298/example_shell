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
		8. exit"
		read -p "Enter your choice:" choice


	case $choice in 
		1) create_user ;;
	  2) delete_user ;;
		3) edit_user_permission ;;
		4) list_user ;;
		5) list_group ;;
		6) check_file_permission ;;
		7) edit_file_permission ;;
		8) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done