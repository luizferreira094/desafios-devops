variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "172.31.0.0/16"
}
variable "region" {}

variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-1 = "ami-049d8641"
    us-east-1 = "ami-a6b8e7ce"
    eu-west-1 = "ami-47a23a30"
  }
}
