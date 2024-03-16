variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
  default = "eks-desafio"
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.small", "t3.small"]
}

variable "public_subnet_cidr" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
