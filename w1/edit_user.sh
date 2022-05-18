#! /bin/bash

# thay doi thong tin cho user

echo -n "User to be deleted:"
read edit_user

echo "$edit_user  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username