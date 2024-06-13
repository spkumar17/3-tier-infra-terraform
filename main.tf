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
    project_name=module.VPC.project_name
    vpc_id        = module.VPC.vpc_id
    alb_sg_id = module.Resources.alb_sg_id

}


module "Resources" {
    source = "./module/Resources"
    vpc_id        = module.VPC.vpc_id
}

module "ASG" {

    source = "./module/ASG"
    image_id ="ami-08d6190e60b833cc4"
    instance_type = "t2.micro"
    instance_name = "mainservers"
    asg_sg_id=module.Resources.asg_sg_id
    privatesubnet1a_id=module.VPC.privatesubnet1a_id
    privatesubnet1b_id=module.VPC.privatesubnet1b_id
    aws_iam_instance_profile=module.Resources.aws_iam_instance_profile_name


}