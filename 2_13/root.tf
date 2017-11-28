module "vpc" {
  source = "./vpc"
}

module "subnet" {
  source = "./subnet"
  vpc_id = "${module.vpc.npn_vpc_id}"
}

module "internet_gateway" {
  source = "./internetgateway"
  vpcid  = "${module.vpc.npn_vpc_id}"
}

module "route_table" {
  source      = "./routetable"
  vpc_id      = "${module.vpc.npn_vpc_id}"
  igtway_id   = "${module.internet_gateway.intGW}"
  npn_sub_001 = "${module.subnet.npn_sub001}"
  npn_sub_002 = "${module.subnet.npn_sub002}"
  npn_sub_003 = "${module.subnet.npn_sub003}"
  npn_sub_004 = "${module.subnet.npn_sub004}"
}

module "Security_Grp" {
  source = "./securityGrp"
  vpcid  = "${module.vpc.npn_vpc_id}"
}

module "ec2_dmc" {
  source = "./ec2_dmc"

  vpcid              = "${module.vpc.npn_vpc_id}"
  npn_sub_001        = "${module.subnet.npn_sub001}"
  npn_sub_002        = "${module.subnet.npn_sub002}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}

module "ec2_app1_web" {
  source = "./app1/ec2_web"
  
  vpcid              = "${module.vpc.npn_vpc_id}"
  npn_sub_003        = "${module.subnet.npn_sub003}"
  npn_sub_004        = "${module.subnet.npn_sub004}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}

module "app1_elb" {
  source = "./app1/elb"
  
  ec2_app1_w1_id = "${module.ec2_app1_web.web1_id}"
  ec2_app1_w2_id = "${module.ec2_app1_web.web2_id}"
  npn_sub_003        = "${module.subnet.npn_sub003}"
  npn_sub_004        = "${module.subnet.npn_sub004}"
  security_group_web = "${module.Security_Grp.sec_grp_web}"
}