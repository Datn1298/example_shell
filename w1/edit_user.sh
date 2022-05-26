#! /bin/bash

# thay doi thong tin cho user

echo "===== GRANT SUDO PERMISSION FOR USER ====="
echo -n "Enter the user: "
read edit_user

if [[ ! $(cat /etc/passwd | grep "$edit_user") ]];
then
	echo "user $edit_user is not exist!"
else
	usermod -aG sudo $edit_user
fi