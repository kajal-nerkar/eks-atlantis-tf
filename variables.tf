variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "atlantis-eks"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.27" # Updated from 1.24 to 1.27 (LTS as of 2023)
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Private subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "atlantis_chart_version" {
  description = "Atlantis Helm chart version"
  type        = string
  default     = "4.4.0"
}

variable "github_user" {
  description = "GitHub username"
  type        = string
  default     = "kajal-nerkar"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
  default     = "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"
}

variable "github_repo" {
  description = "GitHub repository in format 'owner/repo'"
  type        = string
  default     = "kajal-nerkar/terraform-eks-atlantis-homework"
}

variable "github_webhook_secret" {
  description = "GitHub webhook secret"
  type        = string
  sensitive   = true
  default     = "fcb70c47ae65e2d2e41bc0548b999cd3"
}
