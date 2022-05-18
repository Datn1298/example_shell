#! /bin/bash

# tao nguoi dung moi
# input: user
# output: user


echo -n "Enter the User-name :"
read create_user
if [[ $(cat /etc/passwd | grep "$create_user") ]];
then
	echo "user $create_user already exist!"
else
	useradd $create_user
	echo -n "Enter the password"
	read password
	echo "$password" | passwd --stdin $create_user
fi