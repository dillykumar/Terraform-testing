variable "access_key" {}
variable "secret_key" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "igw_name" {}
variable "region" {}
variable "env" {}
variable "public_subnets" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "public_cidrs" {
  type    = list(any)
  default = ["10.70.1.0/24", "10.70.2.0/24", "10.70.3.0/24", "10.70.4.0/24", "10.70.5.0/24", "10.70.6.0/24"]
}
variable "private_subnets" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "private_cidrs" {
  type    = list(any)
  default = ["10.70.10.0/24", "10.70.20.0/24", "10.70.30.0/24", "10.70.40.0/24", "10.70.50.0/24", "10.70.60.0/24"]
}
variable "amis" {
  description = "AMIs by region"
  default = {
    us-east-1 = "ami-0b0af3577fe5e3532" #RHEL
    us-east-2 = "ami-0ba62214afa52bec7" #RHEL
  }
}
