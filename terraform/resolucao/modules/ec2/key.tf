resource "aws_key_pair" "deployer" {
  key_name   = "public"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}