#! /bin/bash

# xoa nguoi dung
# input: user
# output: user

echo -n "User to be deleted:"
read del_user
sudo userdel -r $del_user

if [[ ! $(sudo cat /etc/passwd | grep "$del_user") ]];
then
	echo "user $del_user is not exist!"
else
	sudo userdel -r $del_user
fi