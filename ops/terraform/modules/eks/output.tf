output "kubernetes_conf" {
  value = module.eks.kubeconfig_filename
}

output "kubernetes_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "workers_sg_id" {
  value = aws_security_group.workers.id
}
