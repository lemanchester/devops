variable "env" {}
variable "cluster_name" {}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
}

variable "vpc_id" {}

variable "worker_groups" {
  default = []
}

variable "worker_additional_security_group_ids" {
  default = []
}

variable "cluster_version" {
  default = "1.13"
}
