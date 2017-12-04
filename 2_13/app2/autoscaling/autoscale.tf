variable "load_balancer" {}
variable "npn_sub_003" {}
variable "npn_sub_004" {}
variable "security_group_web" {}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "${var.app2_ami_id}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_group_web}"]


  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              echo "Hello world, its time to move on" >/var/www/html/index.html
              service apache2 start
              EOF

  enable_monitoring = "false"

  

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  min_size             = 2
  max_size             = 4
  load_balancers = ["${var.load_balancer}"]
  vpc_zone_identifier = ["${var.npn_sub_003}","${var.npn_sub_004}"]

  health_check_type = "ELB"

  lifecycle {
    create_before_destroy = true
  }

   tags {
    key = "Name"
    value = "app2_web"
    propagate_at_launch = true
   }
}

resource "aws_autoscaling_policy" "bar_policy" {
  name                   = "autoScale-test-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.bar.name}"
}

resource "aws_autoscaling_policy" "bar_policy_decrease" {
  name                   = "autoScale-test-policy2"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = "${aws_autoscaling_group.bar.name}"
}


resource "aws_cloudwatch_metric_alarm" "bar_alarm" {
  alarm_name                = "app2_alarm_cpu_up"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 cpu utilization"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.bar.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.bar_policy.arn}"]


}



resource "aws_cloudwatch_metric_alarm" "bar_alarm_less" {
  alarm_name                = "app2_alarm_cpu_down"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "20"
  alarm_description         = "This metric monitors ec2 cpu utilization"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.bar.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.bar_policy_decrease.arn}"]


}

variable extra_tags {
  default = [
    {
      key = "Foo"
      value = "Bar"
      propagate_at_launch = true
    },
    {
      key = "Baz"
      value = "Bam"
      propagate_at_launch = true
    },
  ]
}