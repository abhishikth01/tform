variable "vpcid" {}

resource "aws_internet_gateway" "gw_npn" {
  vpc_id = "${var.vpcid}"
}

output "intGW" {
  value = "${aws_internet_gateway.gw_npn.id}"
}
