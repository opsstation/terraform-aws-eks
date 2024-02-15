output "cluster_arn" {
  value       = module.eks.cluster_arn
  description = "The Amazon Resource Name (ARN) of the cluster"
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Base64 encoded certificate data required to communicate with the cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Endpoint for your Kubernetes API server"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
}

output "cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
}

output "cluster_platform_version" {
  value       = module.eks.cluster_platform_version
  description = "Platform version for the cluster"
}

output "cluster_status" {
  value       = module.eks.cluster_status
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
}

output "cluster_primary_security_group_id" {
  value       = module.eks.cluster_primary_security_group_id
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use default security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
}

output "node_security_group_arn" {
  value       = module.eks.node_security_group_arn
  description = "Amazon Resource Name (ARN) of the node shared security group"
}

output "node_security_group_id" {
  value       = module.eks.node_security_group_id
  description = "ID of the node shared security group"
}

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
}

output "cluster_iam_role_name" {
  value       = module.eks.node_group_iam_role_name
  description = "IAM role name of the EKS cluster"
}

output "cluster_iam_role_arn" {
  value       = module.eks.node_group_iam_role_arn
  description = "IAM role ARN of the EKS cluster"
}

output "cluster_iam_role_unique_id" {
  value       = module.eks.cluster_iam_role_unique_id
  description = "Stable and unique string identifying the IAM role"
}

output "node_group_iam_role_name" {
  value       = module.eks.node_group_iam_role_name
  description = "IAM role name of the EKS cluster"
}

output "node_group_iam_role_arn" {
  value       = module.eks.node_group_iam_role_arn
  description = "IAM role ARN of the EKS cluster"
}

output "node_group_iam_role_unique_id" {
  value       = module.eks.cluster_iam_role_unique_id
  description = "Stable and unique string identifying the IAM role"
}

output "tags" {
  value = module.eks.tags
}

output "cluster_name" {
  value = module.eks.cluster_name
}