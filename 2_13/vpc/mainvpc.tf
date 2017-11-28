resource "aws_vpc" "ggn_npn" {
  cidr_block = "10.1.0.0/16"
}

output "npn_vpc_id" {
  value = "${aws_vpc.ggn_npn.id}"
}
