variable "vpcid" {}
variable "npn_sub_001" {}
variable "npn_sub_002" {}
variable "security_group_dmc" {}

resource "aws_instance" "dmc1" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_001}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_dmc}"]
  availability_zone      = "${var.az1}"

  tags {
    Name = "dmc1"
  }
}

resource "aws_instance" "dmc2" {
  ami                    = "${var.ami_id2}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_002}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_dmc}"]
  availability_zone      = "${var.az2}"

  tags {
    Name = "dmc2"
  }
}

################################################
/*
resource "aws_instance" "web1" {

  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  subnet_id      = "${var.npn_sub_001}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone = "${var.az1}"

  tags {
   Name = "web1"
  }
}

resource "aws_instance" "web2" {

  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  subnet_id      = "${var.npn_sub_002}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_web}"]
  availability_zone = "${var.az2}"

  tags {
   Name = "web1"
  }
}
*/
#######################################################333
output "dmc1_id" {
  value = "${aws_instance.dmc1.id}"
}

output "dmc2_id" {
  value = "${aws_instance.dmc2.id}"
}

output "dmc1_pvt_ip" {
  value = "${aws_instance.dmc1.private_ip}"
}

output "dmc2_pvt_ip" {
  value = "${aws_instance.dmc2.private_ip}"
}

output "dmc1_pub_ip" {
  value = "${aws_instance.dmc1.public_ip}"
}

output "dmc2_pub_ip" {
  value = "${aws_instance.dmc2.public_ip}"
}


/*
output "web1_id" {
  value = "${aws_instance.web1.id}"
}
output "web2_id" {
  value = "${aws_instance.web2.id}"
}
*/

