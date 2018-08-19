resource "aws_key_pair" "deployer" {
  key_name   = "public"
  public_key = "${var.public-key}"
}