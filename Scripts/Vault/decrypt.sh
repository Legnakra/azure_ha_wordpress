#!/bin/bash
echo "-----------------------------------"
read -sp "Enter Ansible Vault Password: " vault_pass
echo ""
echo $vault_pass > vault_pass.txt
chmod 600 vault_pass.txt
echo ""
echo "-----------------------------------"
echo "Decrypting Terraform scripts"
echo "-----------------------------------"
ansible-vault decrypt ../Terraform/apply.sh --vault-password-file vault_pass.txt &> /dev/null
ansible-vault decrypt ../Terraform/destroy.sh --vault-password-file vault_pass.txt &> /dev/null
ansible-vault decrypt ../Terraform/plan.sh --vault-password-file vault_pass.txt &> /dev/null
chmod 770 ../Terraform/*
echo "-----------------------------------"
echo "Decrypting Ansible var files"
echo "-----------------------------------"
ansible-vault decrypt ../../Ansible/inventories/group_vars/all --vault-password-file vault_pass.txt &> /dev/null
ansible-vault decrypt ../../Ansible/inventories/group_vars/ha_wordpress --vault-password-file vault_pass.txt &> /dev/null
chmod 770 ../Ansible/deploy.sh
rm vault_pass.txt