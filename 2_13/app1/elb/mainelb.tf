variable "ec2_app1_w1_id" {}
variable "npn_sub_003" {}
variable "npn_sub_004" {}
variable "ec2_app1_w2_id" {}
variable "security_group_web" {}

# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "abhishikth-elb"
  subnets = ["${var.npn_sub_003}","${var.npn_sub_004}"]
  security_groups = ["${var.security_group_web}"]

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
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${var.ec2_app1_w1_id}", "${var.ec2_app1_w2_id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "app1_elb"
  }
}
