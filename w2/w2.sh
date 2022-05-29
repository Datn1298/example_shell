#!/usr/bin/bash

create_user(){
	echo "===== CREATE NEW USER ====="
	echo -n "Enter the Username: "
	read create_user
	echo -n "Enter the Password: "
	read password
	

	sed 's/${_user}/'$create_user'/g' user/create_user/vars/template.yaml > user/create_user/vars/template.yaml/default.yaml
	sed 's/${_password}/'$password'/g' user/create_user/vars/template.yaml > user/create_user/vars/template.yaml/default.yaml

	ansible-playbook user/create_user/create_user.yaml
}

delete_user(){
	echo "===== DELETE USER ====="
	echo -n "Enter the user:"
	read del_user

	sed 's/${_user}/'$del_user'/g' user/delete_user/vars/template.yaml > user/delete_user/vars/template.yaml/default.yaml

	ansible-playbook user/delete_user/delete_user.yaml
}

edit_user_permission(){
	echo "===== GRANT SUDO PERMISSION FOR USER ====="
	echo -n "Enter the user: "
	read edit_user

	sed 's/${_user}/'$edit_user'/g' user/edit_user_permission/vars/template.yaml > user/edit_user_permission/vars/template.yaml/default.yaml

	ansible-playbook user/edit_user_permission/edit_user_permission.yaml
}


list_user(){
	echo "===== LIST USER ====="
	ansible-playbook user/list_user.yaml
}

list_group(){
	echo "===== LIST GROUP ====="
	ansible-playbook user/list_group.yaml
}

check_file_permission(){
	echo "===== CHECK PERMISSION OF FILE ====="
	echo -n "Enter file name: "

	read file

	sed 's/${_path}/'$file'/g' file/check_file_permission/vars/template.yaml > file/check_file_permission/vars/default.yaml

	ansible-playbook file/check_file_permission.yaml
}

edit_file_permission(){
	echo "===== CHANGE FILE PERMISSION ====="
	echo -n "Enter file name: "
	read filename
	echo -n "Permission: "
	read permission

	sed 's/${_path}/'$file'/g' file/edit_file_permission/vars/template.yaml > file/edit_file_permission/vars/default.yaml
	sed 's/${_permission}/'$permission'/g' file/edit_file_permission/vars/template.yaml > file/edit_file_permission/vars/default.yaml

	ansible-playbook file/edit_file_permission.yaml
}

install_apache(){
  echo "===== INSTALL APACHE2 ====="


	ansible-playbook install/install_apache/install_apache.yaml

}

config_apache2(){
	echo "===== CONFIGUARE APACHE2 ====="

}

install_nginx(){
	echo "===== INSTALL NGINX ====="

	
	ansible-playbook install/install_mysql/install_nginx.yaml
}

config_nginx(){
	echo "===== CONFIGUARE NGINX ====="
	
}

install_php(){
	echo "===== CONFIGUARE PHP ====="

	ansible-playbook install/install_php.yaml
}

install_mysql(){
	echo "===== CONFIGUARE MYSQL ====="
	
	ansible-playbook install/install_mysql.yaml
}
while :
do
	echo "
		1. Create new user 
		2. Delete user
		3. Edit user permission
		4. List user
		5. List group
		6. Check file permission
		7. Edit file permission
		8. Install Apache2
		9. Install Nginx
		10. Install PHP
		11. Install MySQL
		12. Configuare Apache2
		13. Configuare Nginx
		14. exit"
		read -p "Enter your choice: " choice


	case $choice in 
		1) create_user ;;
		2) delete_user ;;
		3) edit_user_permission ;;
		4) list_user ;;
		5) list_group ;;
		6) check_file_permission ;;
		7) edit_file_permission ;;
		8) install_apache ;;
		9) install_nginx ;;
		10) install_php ;;
		11) install_mysql ;;
		12) config_apache2 ;;
		13) config_nginx ;;
		14) echo "ThankYou, have a nice day...."
		   exit 1 ;;
		*) echo "invalid input...";;
	esac	
	sleep 4
	clear
done