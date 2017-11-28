variable "vpcid" {}
variable "npn_sub_003" {}
variable "npn_sub_004" {}
variable "security_group_web" {}

/*
resource "aws_instance" "dmc1" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_001}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az1}"

  tags {
    Name = "dmc1"
  }
}

resource "aws_instance" "dmc2" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_002}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az2}"

  tags {
    Name = "dmc2"
  }
}
*/
################################################

resource "aws_instance" "web1" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_003}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az1}"

  tags {
    Name = "app1_web1"
  }
}

resource "aws_instance" "web2" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_004}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone      = "${var.az2}"

  tags {
    Name = "app1_web2"
  }
}

#######################################################333
/*
output "dmc1_id" {
  value = "${aws_instance.dmc1.id}"
}

output "dmc2_id" {
  value = "${aws_instance.dmc2.id}"
}

*/

output "web1_id" {
  value = "${aws_instance.web1.id}"
}

output "web2_id" {
  value = "${aws_instance.web2.id}"
}