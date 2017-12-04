variable "vpcid" {}
variable "npn_sub_003" {}
variable "npn_sub_004" {}
variable "security_group_web" {}

################################################

resource "aws_instance" "web1" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_003}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az1}"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              echo "Hello world, its time to move on" >/var/www/html/index.html
              service apache2 start
              EOF

  tags {
    Name = "app2_web1"
  }
}

resource "aws_instance" "web2" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_004}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az2}"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              echo "Hello world, its time to move on" >/var/www/html/index.html
              service apache2 start
              EOF

  tags {
    Name = "app2_web2"
  }
}

#######################################################333
output "web1_id" {
  value = "${aws_instance.web1.id}"
}

output "web2_id" {
  value = "${aws_instance.web2.id}"
}

output "web1_ip" {
  value = "${aws_instance.web1.private_ip}"
}
output "web2_ip" {
  value = "${aws_instance.web2.private_ip}"
}