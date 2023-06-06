#!/bin/bash
echo "-------------------------------"
echo "Configuring Azure subscription"
echo "-------------------------------"
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "-------------------------------"
echo "Launching Terraform plan"
echo "-------------------------------"
cd ../../Terraform/environments/dev && terraform init
terraform plan
