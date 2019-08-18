provider "aws" {
  region  = var.region
  version = "~> 2.14"
}

variable "env" {
  description = "Environment name"
  default = "dev"
}

variable "region" {
  description = "Region to deploy infrastructure"
  default     = "us-east-1"
}

variable "azs" {
  description = "Availability Zones at eu-west-1 region"
  type        = "list"
  default     = ["a", "b", "c"]
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default = "192.168.0.0/16"
}

variable "key_pair_name" {
  description = "Key name for SSH access in EC2 instances"
  default = "devops"
}

variable "key_pair_public_key" {
  description = "Public key for SSH access in EC2 instances"
}
