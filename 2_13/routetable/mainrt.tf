variable "vpc_id" {}

variable "igtway_id" {}

variable "npn_sub_001" {}

variable "npn_sub_002" {}

variable "npn_sub_003" {}

variable "npn_sub_004" {}

resource "aws_route_table" "route_table1" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igtway_id}"
  }

  tags {
    Name = "pub_route"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = "${var.npn_sub_001}"
  route_table_id = "${aws_route_table.route_table1.id}"
}

resource "aws_route_table_association" "a2" {
  subnet_id      = "${var.npn_sub_002}"
  route_table_id = "${aws_route_table.route_table1.id}"
}
