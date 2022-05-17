#! /bin/bash

# xoa nguoi dung
# input: user
# output: user

echo -e "User to be deleted:"
            read del_user
            sudo userdel -r $del_user