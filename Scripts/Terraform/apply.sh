#!/bin/bash
echo "-------------------------------"
echo "Configuring Azure subscription"
echo "-------------------------------"
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "-------------------------------"
echo "Deploying Terraform resources"
echo "-------------------------------"
cd ../../Terraform/environments/dev && terraform init
terraform apply -auto-approve
