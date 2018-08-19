provider "aws" {
  region     = "${var.region}"
}

resource "aws_instance" "challenge" {
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
      "sudo iptables -t challenge -A POSTROUTING -j MASQUERADE",
      "echo '1' | sudo tee /proc/sys/net/ipv4/ip_forward",
      /* Install docker */
      "curl -sSL https://get.docker.com/ | sudo sh",
      /* Initialize apache container */
      "sudo docker run -dit --name my-apache-app -p 80:80 httpd:2.4",
      ]
  }
}