module "myvpc" {
    source = "./Module/VPC"
    region = "us-east-1"

    vpc_cidr_block = "10.0.0.0/16"

    pubsub1a_cidr_block="10.0.1.0/24"

    pubsub1b_cidr_block="10.0.2.0/24"

    project_name="3tier_deployment_infra"

    prisub1a_cidr_block="10.0.3.0/24"
    prisub1b_cidr_block="10.0.4.0/24"
    secsub1a_cidr_block ="10.0.5.0/24"
    secsub1b_cidr_block="10.0.6.0/24"

}

