module "VPC" {
    source = "./module/VPC"
    region = "us-east-1"

    vpc_cidr_block = "10.0.0.0/16"

    pubsub1a_cidr_block="10.0.1.0/24"

    pubsub1b_cidr_block="10.0.2.0/24"

    project_name="3tierDeployment"

    prisub1a_cidr_block="10.0.3.0/24"
    prisub1b_cidr_block="10.0.4.0/24"
    secsub1a_cidr_block ="10.0.5.0/24"
    secsub1b_cidr_block="10.0.6.0/24"

}

module "ALB" {
    source = "./module/ALB"
    publicsubnet1a_id = module.VPC.publicsubnet1a_id
    publicsubnet1b_id = module.VPC.privatesubnet1b_id
    lb_sg_id = module.Resources.lb_sg_id
    project_name=module.VPC.project_name



}


module "Resources" {
    source = "./module/Resources"
    vpc_id        = module.VPC.vpc_id

}