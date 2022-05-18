#!bin/bash

# kiem tra da cai dat Sudoer
if [ (dpkg -s sudoers) -eq 0 ]; then
    echo "Package Sudoer is installed!"
else
    echo "Package Sudoer is NOT installed!"
    apt update -y 
    apt install sudo -y
fi
# neu da cai dat => bo qua
# neu chua cai dat => cai dat

# cap quyen sudo cho user cu the
# nhap nguoi dung can cap quyen sudo
# kiem tra nguoi dung co phai la root k
# neu la root thi nhap lai
# neu k la root => cap quyen root
# neu k ton tai => bao k ton tai
# exit => tiep
echo -n "Enter user: "
read edit_user

if [[ ! $(cat /etc/passwd | grep "$edit_user") ]];
then
	echo "user $edit_user is not exist!"
else
	echo "$edit_user  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/username
fi

# Sửa lại file /etc/login.def để giới hạn thời gian sử dụng password cũ
# https://man7.org/linux/man-pages/man5/login.defs.5.html
# https://programmer.group/linux-account-password-expiration-security-policy-settings.html



# 2.5
# them tham so sau vao trong httpd.conf
# ServerSignature Off
# ServerTokens Prod

# them tham so sau vao php.ini
# expose_php = Off


# 2.7
# doi voi user binh thuong
# config_timestamp_bash-history.sh
# doi voi root hay super user

