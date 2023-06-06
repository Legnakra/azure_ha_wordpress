#!/bin/bash
echo "-------------------------------"
echo "Configuring Azure subscription"
echo "-------------------------------"
export ARM_CLIENT_ID="88eab221-311e-42db-a9e5-c30a5d256b52"
export ARM_CLIENT_SECRET="5xv8Q~3SjBCN.sGvbI0DvXnYdS6s5qcvvFYJPaFN"
export ARM_SUBSCRIPTION_ID="d70917c9-fb73-4754-bc57-31731e67aae9"
export ARM_TENANT_ID="aed54a73-bc10-45e1-b209-388b019ed0ef"
echo "-------------------------------"
echo "Launching Terraform plan"
echo "-------------------------------"
cd ../../Terraform/environments/dev && terraform init
terraform plan
