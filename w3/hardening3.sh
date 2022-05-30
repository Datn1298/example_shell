#!/usr/bin/bash

check_package_installed(){
  if [ !(dpkg -s sudoers) -eq 0 ]; then
    apt update -y 
    apt install sudo -y
  fi
  echo "===== PACKAGE SUDOERS IS INSTALLED! ====="
}

edit_user_permission(){
	echo "===== GRANT SUDO PERMISSION FOR USER ====="
	echo -n "Enter the user: "
	read edit_user

	if [[ ! $(cat /etc/passwd | grep "$edit_user") ]];
	then
		echo "user $edit_user is not exist!"
	else
		usermod -aG sudo $edit_user
	fi
}


set_password_expiration()
{
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
  sed -i '' $MINDAY 's/.*PASS_MIN_LEN.*/PASS_MIN_ LEN 6/'/etc/login.defs
  echo  "Check the minimum password length"
}

prevent_outside_access(){
  while :
  do
    echo "
      1. Check Package Sudoers
      2. Grant Sudo Permission for user
      3. Setup Linux account password expiration
      4. exit"
      read -p "Enter your choice: " choice


    case $choice in 
      1) check_package_installed ;;
      2) edit_user_permission ;;
      3) set_password_expiration ;;
      4) echo "Thanks!"
        exit 1 ;;
      *) echo "invalid input...";;
    esac	
    sleep 4
    clear
  done
}

while :
do
	echo "
    1. Prevent outside access to the system

    read -p "Enter your choice:" choice


	case $choice in 
		1) prevent_outside_access ;;
		2) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done