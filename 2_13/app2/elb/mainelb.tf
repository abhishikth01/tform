#variable "ec2_app2_w1_id" {}
#variable "npn_sub_003" {}
#variable "npn_sub_004" {}
variable "npn_sub_001" {}
variable "npn_sub_002" {}
#variable "ec2_app2_w2_id" {}
variable "security_group_web" {}

# Create a new load balancer
resource "aws_elb" "app2_lb" {
  name               = "abhishikth-app2-elb"
  subnets = ["${var.npn_sub_001}","${var.npn_sub_002}"]
  security_groups = ["${var.security_group_web}"]
  internal = "false"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

# instances                   = ["${var.ec2_app2_w1_id}", "${var.ec2_app2_w2_id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "app1_elb"
  }
}

output "app2_elb_id" {
  value = "${aws_elb.app2_lb.id}"
}