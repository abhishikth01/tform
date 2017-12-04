variable "vpc_id" {}

resource "aws_subnet" "sub_001" {
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.az_1a}"
  cidr_block              = "${var.cidr_sub001}"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "sub_002" {
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.az_1b}"
  cidr_block              = "${var.cidr_sub002}"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "sub_003" {
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.az_1a}"
  cidr_block              = "${var.cidr_sub003}"
  map_public_ip_on_launch = "false"
}

resource "aws_subnet" "sub_004" {
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.az_1b}"
  cidr_block              = "${var.cidr_sub004}"
  map_public_ip_on_launch = "false"
}


output "npn_sub001" {
  value = "${aws_subnet.sub_001.id}"
}

output "npn_sub002" {
  value = "${aws_subnet.sub_002.id}"
}

output "npn_sub003" {
  value = "${aws_subnet.sub_003.id}"
}

output "npn_sub004" {
  value = "${aws_subnet.sub_004.id}"
}

/*
resource "aws_subnet" "sub_101" {
  vpc_id            = "${aws_vpc.vpc_npn.id}"
  availability_zone = "${var.az2}"
  cidr_block        = "${var.subnet101_cidr}"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "sub_200" {
  vpc_id            = "${aws_vpc.vpc_npn.id}"
  availability_zone = "${var.az1}"
  cidr_block        = "${var.subnet200_cidr}"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "sub_201" {
  vpc_id            = "${aws_vpc.vpc_npn.id}"
  availability_zone = "${var.az2}"
  cidr_block        = "${var.subnet201_cidr}"
  map_public_ip_on_launch = "true"
}
*/

