#!/usr/bin/bash

create_user(){
	while :
		do
			read -p "Enter user name:" user
			if id $user &> /etc/null 
			then
				echo "User already exist...(try again with another name)"
			else
				useradd $user
				echo "$user created successfully"
				return 0
			fi
		done
}


set_pass()
{
	read -p "enter user_name:" user
	read -p "enter passwords:" password	
	echo "$password" | passwd --stdin $user 
}


view()
{
	users=$(awk -F: '$7=="/bin/bash" { print $1}' /etc/passwd)
	for user in $users
	do
		echo "User: $user , $(id $user | cut -d " " -f 1)"
	done
}


lock()
{
	while :
	do
		read -p "Enter your user_name to lock password:" user
		if [ -z $user ]
		then
			echo "Username can't be empty, please enter user_name..."
		else
			if id $user &> /etc/null
			then
				passwd -l $user
			        echo "successfully done...."	
				return 0
			else
				echo "provide valid user_name, user $user does not exist"
			fi
		fi
	done
}


backup()
{
	read -p "Enter user_name: " user
	echo "searching for home directory of $user"
	homedir=$(grep ${user}: /etc/passwd | cut -d ":" -f 6)
	echo "Home directory for $user is $homedir "
	echo "creating backup file (.tar).."
	ts=$(date +%F)
	tar -cf ${user}-${ts}.tar $homedir
	echo "$user backup success... "
	return 0
}

while :
do
	echo "
	      1. Create new user 
	      2. Set password 
	      3. Lock Password 
	      4. Create user backup 
	      5. View user-id
	      6. exit"
        read -p "Enter your choice:" choice


	case $choice in 
		1) create_user ;;
	  2) set_pass
		  echo "Password successfully updated.....";;
		3) lock ;;
		4) backup ;;
		5) view ;;
		6) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done