# This is a test module.
module "vpc" {
  source = "./2_13/vpc"
}
#second line added to find git diff
module "subnet" {
  source = "./2_13/subnet"
  vpc_id = "${module.vpc.npn_vpc_id}"
}

module "internet_gateway" {
  source = "./2_13/internetgateway"
  vpcid  = "${module.vpc.npn_vpc_id}"
}

module "route_table" {
  source      = "./2_13/routetable"
  vpc_id      = "${module.vpc.npn_vpc_id}"
  igtway_id   = "${module.internet_gateway.intGW}"
  npn_sub_001 = "${module.subnet.npn_sub001}"
  npn_sub_002 = "${module.subnet.npn_sub002}"
  npn_sub_003 = "${module.subnet.npn_sub003}"
  npn_sub_004 = "${module.subnet.npn_sub004}"
  natinst_id  = "${module.nat_instance.nat_id}"
}

module "Security_Grp" {
  source = "./2_13/securityGrp"
  vpcid  = "${module.vpc.npn_vpc_id}"
}

module "ec2_dmc" {
  source = "./2_13/ec2_dmc"

  vpcid              = "${module.vpc.npn_vpc_id}"
  npn_sub_001        = "${module.subnet.npn_sub001}"
  npn_sub_002        = "${module.subnet.npn_sub002}"
  security_group_dmc = "${module.Security_Grp.sec_grp_dmc}"
}

/*
module "ec2_app2_web" {
  source = "./2_13/app2/ec2_web"
  
  vpcid              = "${module.vpc.npn_vpc_id}"
  npn_sub_003        = "${module.subnet.npn_sub003}"
  npn_sub_004        = "${module.subnet.npn_sub004}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}

module "app2_elb" {
  source = "./2_13/app2/elb"

  # ec2_app2_w1_id = "${module.ec2_app2_web.web1_id}"
  # ec2_app2_w2_id = "${module.ec2_app2_web.web2_id}"
  npn_sub_001 = "${module.subnet.npn_sub001}"

  npn_sub_002        = "${module.subnet.npn_sub002}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}


module "app2_autoscale" {
  source = "./2_13/app2/autoscaling"
  
  load_balancer = "${module.app2_elb.app2_elb_id}"
  npn_sub_003        = "${module.subnet.npn_sub003}"
  npn_sub_004        = "${module.subnet.npn_sub004}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}
*/

module "nat_instance" {
  source = "./2_13/app2/natinstance"

  vpcid              = "${module.vpc.npn_vpc_id}"
  npn_sub_001        = "${module.subnet.npn_sub001}"
  security_group_nat = "${module.Security_Grp.nat_secgrp}"
}

output "dmc1_pvt_ip" {
  value = "${module.ec2_dmc.dmc1_pvt_ip}"
}

output "dmc1_pub_ip" {
  value = "${module.ec2_dmc.dmc1_pub_ip}"
}

output "dmc2_pvt_ip" {
  value = "${module.ec2_dmc.dmc2_pvt_ip}"
}

output "dmc2_pub_ip" {
  value = "${module.ec2_dmc.dmc2_pub_ip}"
}

/*
output "app2_web1_ip" {
  value = "${module.ec2_app2_web.web1_ip}"
}
output "app2_web2_ip" {
  value = "${module.ec2_app2_web.web2_ip}"
}
*/

