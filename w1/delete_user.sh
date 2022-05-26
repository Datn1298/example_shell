#! /bin/bash

# xoa nguoi dung
# input: user
# output: user

echo "===== DELETE USER ====="
echo -n "Enter the user: "
read del_user

if [[ ! $(cat /etc/passwd | grep "$del_user") ]];
then
	echo "user $del_user is not exist!"
else
	userdel -r $del_user
fi