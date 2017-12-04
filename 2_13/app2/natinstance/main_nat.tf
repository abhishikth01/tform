variable "vpcid" {}
variable "npn_sub_001" {}
variable "security_group_nat" {}

################################################

resource "aws_instance" "nat" {
  ami                    = "${var.ami_id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.npn_sub_001}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group_nat}"]
  availability_zone      = "${var.az1}"
  source_dest_check = "false"


  tags {
    Name = "nat_inst"
  }
}

#######################################################333
output "nat_id" {
  value = "${aws_instance.nat.id}"
}
output "nat_pub_ip" {
  value = "${aws_instance.nat.public_ip}"
}
output "nat_pvt_ip" {
  value = "${aws_instance.nat.private_ip}"
}