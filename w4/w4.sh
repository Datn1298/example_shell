#!/usr/bin/bash

check_package_sudoers(){
	echo "===== CHECK PACKAGE SUDO ====="
    ansible-playbook check_package_sudoers.yaml
}

check_config_password(){
	echo "===== CHECK CONFIG PASSWORD ====="
    ansible-playbook check_config_password.yaml
}

check_config_timestamp(){
	echo "===== CHECK CONFIG TIMESTAMP ====="
    ansible-playbook check_config_timestamps.yaml

}


check_config_apache(){
    echo "===== CHECK CONFIG APACHE ====="
    ansible-playbook check_config_apache.yaml
}

check_config_nginx(){
	echo "===== CHECK CONFIG NGINX ====="
	ansible-playbook check_config_nginx.yaml
}

while :
do
	echo "
		1. Check package sudo 
		2. Check config password
		3. Check config timestamp
		4. Check config Apache
		5. Check config Nginx
		6. exit"
		read -p "Enter your choice: " choicNe

	case $choice in 
		1) check_package_sudoers ;;
		2) check_config_password ;;
		3) check_config_timestamp ;;
		4) check_config_apache ;;
		5) check_config_nginx ;;
		6) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done


1. fhovpn.fpt.com.vn/ tải về
2. cài
3. chạy 
4. kết nối đến fhovpn.fpt.com.vn
5. tải VMware horizol client
6. đăng nhập bthg