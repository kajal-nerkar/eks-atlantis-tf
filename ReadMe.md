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
```
terraform-eks-atlantis-homework/
├── .gitignore
├── atlantis-values.yaml          # Helm chart values for customizing Atlantis
├── atlantis.yaml                 # Atlantis workflow and project definitions
├── encoded.txt                   # (Optional) File to store encoded secrets (e.g., base64)
├── eks.tf                        # EKS cluster and node group definitions
├── helm_atlantis.tf             # Helm chart deployment for Atlantis
├── iam.tf                        # IAM roles and policies for EKS, RBAC setup
├── main.tf                       # Root module entry point
├── namespace.tf                 # Defines 'atlantis' namespace in Kubernetes
├── outputs.tf                   # Terraform outputs including Atlantis LoadBalancer URL
├── storageclass.tf             # (Optional) EBS volume class definition
├── terraform.tfstate           # (Generated) Terraform state file (ignore in VCS)
├── terraform.tfvars            # (Optional) Variable file for runtime values
├── variables.tf                # Input variable declarations
├── k8s/atlantis/                # (Optional) Raw K8s manifests (alternative to Helm)
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── namespace.yaml
│   ├── secret.yaml
│   └── service.yaml
├── scripts/                     # Utility scripts (e.g., deployment automation)
│   └── deploy_atlantis.sh      # End-to-end deployment script
└── README.md                    # This documentation file
```
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
## 🔗 GitHub Webhook Configuration

To allow **Atlantis** to automatically trigger Terraform `plan` and `apply` on pull requests, you need to configure a **webhook** in your GitHub repository:

### 🔧 Steps to Configure the Webhook

1. Navigate to your **GitHub repository**.
2. Click on **⚙️ Settings** (top-right corner).
3. From the left sidebar, click **Webhooks**.
4. Click the **➕ Add webhook** button.
5. Fill in the following configuration fields:

| Field               | Value                                                              |
|--------------------|--------------------------------------------------------------------|
| **Payload URL**     | `http://<ATLANTIS-EXTERNAL-URL>/events`                           |
| **Content type**    | `application/json`                                                |
| **Secret**          | Use the same value as `TF_VAR_github_webhook_secret`              |
| **SSL verification**| Optional (you can **Disable SSL verification** if using HTTP)     |
| **Events to trigger** | Select **Let me select individual events**, then check:<br>☑️ Push<br>☑️ Pull requests |
| **Active**          | ✅ Enabled                                                        |

6. Click **Add webhook** to save the configuration.

### ✅ Screenshot Example

![Webhook Setup Example](https://github.com/user-attachments/assets/aa0fcd09-a155-47fc-911b-00fbc978778c)

> **Note**: Replace `<ATLANTIS-EXTERNAL-URL>` with the actual **LoadBalancer DNS name** for the Atlantis service retrieved via:
>
> ```bash
> kubectl get svc -n atlantis
> ```
/>

```
