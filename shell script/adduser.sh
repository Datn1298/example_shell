#!/bin/bash

servers=$(cat servers.txt)
echo -n "Enter the username: "
read userName
echo -n "Enter the user id: "
read userID

for i in $servers; do
echo $i
ssh $i "sudo useradd -m -u $userID $userName"
if [ $? -eq 0 ]; then
echo "User $userName added on $i"
else
echo "Error on $i"
fi
done