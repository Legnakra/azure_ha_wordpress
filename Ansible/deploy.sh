#!/bin/bash
echo "--- Deploying Ansible ---"
echo "-------------------------"
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i inventories/hosts wordpress.yml