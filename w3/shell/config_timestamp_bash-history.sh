#! /bin/bash

# ktra user
# neu user thuong
	# Tạo folder chứa log
	# mkdir -p /var/log/users_history/
	# Thêm quyền cho thư mục vùa tạo
	# chmod +t /var/log/users_history/
	# Tạo một file shell cho các user khác với nội dung bên dưới
	# cp ./users_history.sh /etc/profile.d/users_history.sh
	# chmod 770 /etc/profile.d/users_history.sh
	# source /etc/profile.d/users_history.sh

# neu user root
	# Tạo folder chứa log
	# mkdir -p /var/log/sudo_history/
	# them vao .bashrc
	# export HISTSIZE=10000
	# export HISTTIMEFORMAT='%F %T'
	# export HISTFILE=/var/log/sudo_history/history-sudo-$(who am I | awk '{print $1}';exit)-$(date +%F)
	# export PROMPT_COMMAND='history -a'
	# source .bashrc

if [[ $(/usr/bin/id -u) != "0" ]]; then
  mkdir -p /var/log/users_history/
	chmod +t /var/log/users_history/
	cp ./users_history.sh /etc/profile.d/users_history.sh
	chmod 770 /etc/profile.d/users_history.sh
	source /etc/profile.d/users_history.sh
else
	mkdir -p /var/log/sudo_history/
	cat <<EOF | tee -a .bashrc
	export HISTSIZE=10000
	export HISTTIMEFORMAT='%F %T'
	export HISTFILE=/var/log/sudo_history/history-sudo-$(who am I | awk '{print $1}';exit)-$(date +%F)
	export PROMPT_COMMAND='history -a'
	EOF
	
	source .bashrc
fi