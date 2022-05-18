#! /bin/bash

# thay doi thong tin cho user

echo -n "Enter user: "
read edit_user

if [[ ! $(cat /etc/passwd | grep "$edit_user") ]];
then
	echo "user $edit_user is not exist!"
else
	echo "$edit_user  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username
fi