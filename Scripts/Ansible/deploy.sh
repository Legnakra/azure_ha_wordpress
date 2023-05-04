#!/bin/bash
echo "-----------------------------------"
echo "Deploying Wordpress"
echo "-----------------------------------"
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ../../Ansible/inventories/hosts ../../Ansible/wordpress.yml
