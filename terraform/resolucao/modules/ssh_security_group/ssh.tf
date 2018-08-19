resource "aws_security_group" "ssh_rule" {
  name        = "${var.ssh_rule_name}"
  description = "Allow ssh traffic"
  vpc_id      = "${var.vpc_id}"
  
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${var.ssh_vpc_cidr}"]
  }

}

output "ssh_id" {
  value = "${aws_security_group.ssh_rule.id}"
}