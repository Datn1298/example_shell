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
	usermod -aG sudo $edit_user
fi

# Sửa lại file /etc/login.def để giới hạn thời gian sử dụng password cũ
# https://man7.org/linux/man-pages/man5/login.defs.5.html
# https://programmer.group/linux-account-password-expiration-security-policy-settings.html

echo --------Check whether to set the minimum number of days between password changes-----
MINDAY = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MIN_DAYS | awk  '{print $1 }' `
 sed -i '' $MINDAY 's/.*PASS_MIN_DAYS.*/PASS_MIN_DAYS 6/'/etc/login.defs
 echo  "Check the minimum number of days between password changes completed" 
echo --Check whether the number of days to warn before password expiration is set ---
WARNAGE = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_WARN_AGE | awk  '{print $1 }' `
 sed -i '' $WARNAGE 's/.*PASS_WARN.*/PASS_WARN_AGE 30/'/etc/login.defs
 echo  "Check the number of warning days before the password expires complete"

echo ---Check password life cycle------
MAXDAY = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MAX_DAYS | awk  '{print $1 }' `
 sed -i '' $MAXDAY 's/.*PASS_MAX.*/PASS_MAX_DAYS 90/'/etc/login.defs
 echo  "Check password life cycle completed"

echo ---Check the minimum password length----
MINLEN = ` cat -n/etc/login.defs |  grep -v ".*#.*" |  grep PASS_MIN_LEN | awk  '{print $1 }' `
 sed -i '' $MINLEN 's/.*PASS_MIN_LEN.*/PASS_MIN_ LEN 6/'/etc/login.defs
 echo  "Check the minimum password length"






















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

