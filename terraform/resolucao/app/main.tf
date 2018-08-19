provider "aws" {
  region = "${var.region}"
}

module "vpc_conf" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.vpc_conf.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
}

module "http_sg" {
  source = "../modules/http_security_group" 
  vpc_id      = "${module.vpc_conf.vpc_id}"
}

module "ssh_sg" {
  source = "../modules/ssh_security_group" 
  vpc_id      = "${module.vpc_conf.vpc_id}"
}

module "app_instance" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id     = "${module.vpc_conf.subnet_id}"
  security_groups = ["${module.http_sg.http_id}","${module.ssh_sg.ssh_id}"]
}

output "public_ip" {
  value = "${module.app_instance.public_ip}"
}
