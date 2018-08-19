output "challenge.ip" {
  value = "${aws_instance.challenge.public_ip}"
}