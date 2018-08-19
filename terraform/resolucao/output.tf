output "aws_elb.ip" {
  value = "${aws_elb.lb.public_ip}"
}