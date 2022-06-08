#!/usr/bin/bash

check_package_sudoers(){
	echo "===== CREATE NEW USER ====="
    ansible-playbook config/check_package_sudoers.yaml
}

config_password(){
	echo "===== PREVENT PASSWORD DETECTION ====="
    ansible-playbook config/config_password.yaml
}

config_timestamp(){
	echo "===== CONFIG TIMESTAMP FOR NORMAL USER ====="
    ansible-playbook config/timestamp_for_normal_user.yaml

    echo "===== CONFIG TIMESTAMP FOR ROOT USER ====="
    ansible-playbook config/timestamp_for_root_user.yaml
}


config_apache(){
    echo "===== CONFIG APACHE ====="
    ansible-playbook config_apache/config.yaml
}

config_nginx(){
	echo "===== CONFIG NGINX ====="
    ansible-playbook config_nginx/config.yaml
}

while :
do
	echo "
		1. Check package sudo 
		2. Config password
		3. Config timestamp
		4. Config Apache
		5. Config Nginx
		6. exit"
		read -p "Enter your choice: " choicNe

	case $choice in 
		1) check_package_sudoers ;;
		2) config_password ;;
		3) config_timestamp ;;
		4) config_apache ;;
		5) config_nginx ;;
		6) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done