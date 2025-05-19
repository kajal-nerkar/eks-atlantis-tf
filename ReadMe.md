
***Atlantis ****
=======
# Atlantis on AWS EKS using Terraform and Helm

This repository provisions a complete **Atlantis on EKS** setup using **Terraform**, **Helm**, and **Kubernetes**.

Atlantis is a GitOps tool for Terraform that automatically plans and applies infrastructure changes based on pull requests.

---

---

## 🔧 Prerequisites

Ensure the following are installed and configured:

| Tool        | Required Version | Notes |
|-------------|------------------|-------|
| Terraform   | >= 1.3           | [Install Terraform](https://developer.hashicorp.com/terraform/downloads) |
| AWS CLI     | >= 2.x           | [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) |
| kubectl     | >= 1.25          | [Install kubectl](https://kubernetes.io/docs/tasks/tools/) |
| helm        | >= 3.0           | [Install Helm](https://helm.sh/docs/intro/install/) |
| GitHub PAT  | Required         | Classic token with `repo`, `admin:repo_hook` scopes |

---

## 📁 Project Structure

├── atlantis-values.yaml # Custom values for the Helm chart
├── atlantis.yaml # Atlantis configuration for project/workflow
├── eks.tf # Creates EKS cluster
├── helm_atlantis.tf # Deploys Atlantis via Helm chart
├── iam.tf # IAM roles and policies for EKS/AWS
├── main.tf # Entry point for Terraform
├── namespace.tf # Creates the 'atlantis' Kubernetes namespace
├── outputs.tf # Exposes key outputs (e.g., Atlantis LB URL)
├── storageclass.tf # Optional: EBS StorageClass for EKS
├── variables.tf # Input variable definitions
├── vpc.tf # VPC, subnets, NAT gateways, etc.
└── deploy_atlantis.sh # Script to deploy entire stack

## 🔐 Setup Secrets as Environment Variables

```bash
export TF_VAR_github_token="your_github_personal_access_token"
export TF_VAR_github_webhook_secret="your_webhook_secret"
export TF_VAR_cluster_name="atlantis-cluster"
export TF_VAR_region="us-east-1"
```
## 🚀 Deployment Steps (Automated)
```
git clone https://github.com/<your-username>/terraform-eks-atlantis-homework.git
cd terraform-eks-atlantis-homework
chmod +x deploy_atlantis.sh
./deploy_atlantis.sh
```

## Web Hook Setup ##
```
Click on ⚙️ Settings (top menu)

In the left sidebar, click Webhooks

Click the green Add webhook button

Fill in the Webhook Configuration

Field	Value
Payload URL	http://<ATLANTIS-EXTERNAL-URL>/events
Content type	application/json
Secret	Use the same value as TF_VAR_github_webhook_secret
SSL verification	Optional (choose "Disable SSL verification" if using HTTP)
Which events trigger	Select Let me select individual events, then check:
☑️ Pull requests
☑️ Push
Active	✅ Leave checked
<img width="560" alt="image" src="https://github.com/user-attachments/assets/aa0fcd09-a155-47fc-911b-00fbc978778c" />

```
