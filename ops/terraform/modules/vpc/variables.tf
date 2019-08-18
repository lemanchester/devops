variable "env" {
  description = "Environment name"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
}

variable "region" {
  description = "Region to set up"
}

variable "azs" {
  description = "List of AZ letters in a region (ex.: a, b, c)"
  default     = []
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
