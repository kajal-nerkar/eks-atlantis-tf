#!/bin/bash

set -e  # Exit on error
set -o pipefail

# Optional: Set environment variables here or export before running
export TF_VAR_github_token="your_github_token"
export TF_VAR_github_webhook_secret="your_webhook_secret"

# Set Kubernetes context (optional)
echo "✅ Setting Kubernetes context..."
kubectl config use-context <your-eks-context-name>

# Step 1: Terraform init
echo "🚀 Initializing Terraform..."
terraform init

# Step 2: Terraform validate
echo "🔍 Validating Terraform configuration..."
terraform validate

# Step 3: Terraform plan
echo "📦 Planning Terraform deployment..."
terraform plan -out=tfplan

# Step 4: Terraform apply
echo "🚀 Applying Terraform deployment..."
terraform apply -auto-approve tfplan

# Step 5: Wait for Atlantis LoadBalancer
echo "⏳ Waiting for Atlantis LoadBalancer IP..."
sleep 30  # Adjust based on EKS responsiveness

kubectl get svc -n atlantis

echo "✅ Deployment Complete!"
