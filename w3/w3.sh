#!/usr/bin/bash

echo "===== CREATE NEW USER ====="
ansible-playbook ansible/check_package_sudoers.yaml

echo "===== PREVENT PASSWORD DETECTION ====="
ansible-playbook ansible/config_password.yaml

echo "===== CONFIG TIMESTAMP FOR NORMAL USER ====="
ansible-playbook ansible/timestamp_for_normal_user.yaml

echo "===== CONFIG TIMESTAMP FOR ROOT USER ====="
ansible-playbook ansible/timestamp_for_root_user.yaml

echo "===== CONFIG APACHE ====="
ansible-playbook config_apache/config.yaml

echo "===== CONFIG NGINX ====="
ansible-playbook config_nginx/config.yaml