provider "docker" {
}
resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  security_groups = ["${var.security_groups}"]
  key_name = "${aws_key_pair.deployer.key_name}"

}
# Create a container
resource "docker_container" "apache" {
  image = "${docker_image.apache.latest}"
  name  = "apache"
  ports = {
      internal = 80,
      external = 80
  }
}


resource "docker_image" "apache" {
  name = "httpd:2.4"
}
resource "aws_eip" "lb" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

output "public_ip" {
  value = "${aws_eip.lb.public_ip}"
}