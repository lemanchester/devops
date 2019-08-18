output "webapp_repository" {
  value = aws_ecr_repository.webapp.repository_url
}

output "public_subnets" {
  value = module.vpc.public_subnet_cidrs
}
