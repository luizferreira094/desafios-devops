variable "region" {}

variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-1 = "ami-049d8641"
    us-east-1 = "ami-0ff8a91507f77f867"
    eu-west-1 = "ami-47a23a30"
  }
}