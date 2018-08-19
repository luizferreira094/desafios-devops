resource "aws_security_group" "http_rule" {
  name        = "${var.http_rule_name}"
  description = "Allow all http traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["${var.http_vpc_cidr}"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["${var.http_vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "http_id" {
  value = "${aws_security_group.http_rule.id}"
}