provider "aws" {
  region     = "${var.region}"
}
/* Application */
resource "aws_instance" "app" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ssh.id}", "${aws_security_group.web.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  connection {
    user = "ubuntu"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t app -A POSTROUTING -j MASQUERADE",
      "echo '1' | sudo tee /proc/sys/net/ipv4/ip_forward",
      /* Install docker */
      "curl -sSL https://get.docker.com/ | sudo sh",
      /* Initialize apache container */
      "sudo docker run -dit --name my-apache-app -p 80:80 httpd:2.4",
      ]
  }
}

/* Load balancer */
resource "aws_elb" "lb" {
  name = "app-elb"
  subnets = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.web.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  instances = ["${aws_instance.app.*.id}"]
}