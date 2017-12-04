variable "vpc_id" {}
variable "igtway_id" {}
variable "npn_sub_001" {}
variable "npn_sub_002" {}
variable "npn_sub_003" {}
variable "npn_sub_004" {}
variable "natinst_id" {}

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

resource "aws_route_table" "route_table2" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${var.natinst_id}"
  }

  tags {
    Name = "nat_route"
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


resource "aws_route_table_association" "a3" {
  subnet_id      = "${var.npn_sub_003}"
  route_table_id = "${aws_route_table.route_table2.id}"
}

resource "aws_route_table_association" "a4" {
  subnet_id      = "${var.npn_sub_004}"
  route_table_id = "${aws_route_table.route_table2.id}"
}

