output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data"
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_worker_role_arn" {
  description = "ARN of the worker node IAM role"
  value       = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
output "atlantis_url" {
  value = "http://${data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].hostname}"
}