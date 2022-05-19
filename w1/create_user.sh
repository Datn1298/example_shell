#! /bin/bash

# tao nguoi dung moi
# input: user
# output: user


echo -n "Enter the User-name: "
read create_user
if [[ $(cat /etc/passwd | grep "$create_user") ]];
then
	echo "user $create_user already exist!"
else
	adduser $create_user
fi