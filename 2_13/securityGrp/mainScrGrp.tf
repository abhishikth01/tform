variable "vpcid" {}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpcid}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "web_sg"
  }
}

output "sec_grp_web" {
  value = "${aws_security_group.web_sg.id}"
}

#####################################################
resource "aws_security_group" "dmc_sg" {
  name        = "dmc_sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpcid}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "dmc_sg"
  }
}

output "sec_grp_dmc" {
  value = "${aws_security_group.dmc_sg.id}"
}
