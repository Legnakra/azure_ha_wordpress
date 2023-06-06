#!/bin/bash
echo "-----------------------------------"
read -sp "Enter Ansible Vault Password: " vault_pass
echo ""
echo $vault_pass > vault_pass.txt
chmod 600 vault_pass.txt
echo ""
echo "-----------------------------------"
echo "Encripting Terraform scripts"
echo "-----------------------------------"
ansible-vault encrypt ../Terraform/apply.sh --vault-password-file vault_pass.txt &> /dev/null
ansible-vault encrypt ../Terraform/destroy.sh --vault-password-file vault_pass.txt &> /dev/null
ansible-vault encrypt ../Terraform/plan.sh --vault-password-file vault_pass.txt &> /dev/null
echo "-----------------------------------"
echo "Encripting Ansible var files"
echo "-----------------------------------"
ansible-vault encrypt ../../Ansible/inventories/group_vars/all --vault-password-file vault_pass.txt &> /dev/null
ansible-vault encrypt ../../Ansible/inventories/group_vars/ha_wordpress --vault-password-file vault_pass.txt &> /dev/null
rm vault_pass.txt