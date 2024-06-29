
data "aws_region" "current" {}  # to know the current aws region

#myvpc
resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support =  true
  enable_dns_hostnames = true

  tags = {
    Name = "3tier_vpc"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    "Name" = "${var.project_name}-igw"

  }
}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

#public subnets 
resource "aws_subnet" "pubsubnet1a" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    cidr_block = var.pubsub1a_cidr_block
    map_public_ip_on_launch = true



  tags = {
    Name = "pubsubnet_us_east_1a"
  }
}

resource "aws_subnet" "pubsubnet1b" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    cidr_block = var.pubsub1b_cidr_block
    map_public_ip_on_launch = true



  tags = {
    Name = "pubsubnet_us_east_1b"
  }
}

#private subnets
resource "aws_subnet" "prisubnet1a" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    cidr_block = var.prisub1a_cidr_block
    map_public_ip_on_launch = false



  tags = {
    Name = "prisubnet_us_east_1a"
  }
}

resource "aws_subnet" "prisubnet1b" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    cidr_block = var.prisub1b_cidr_block
    map_public_ip_on_launch = false



  tags = {
    Name = "prisubnet_us_east_1b"
  }
}

#secure subnets  (not connected to IGW or NAT)

resource "aws_subnet" "secsubnet1a" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    cidr_block = var.secsub1a_cidr_block
    map_public_ip_on_launch = false



  tags = {
    Name = "secsubnet_us_east_1a"
  }
}

resource "aws_subnet" "secsubnet1b" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    cidr_block = var.secsub1b_cidr_block
    map_public_ip_on_launch = false



  tags = {
    Name = "secsubnet_us_east_1b"
  }
}

# public Route tables 

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  
  tags = {
    Name = "public_rt"
  }
}

#public route table association 

resource "aws_route_table_association" "publicsubnet1a_association" {
  subnet_id = aws_subnet.pubsubnet1a.id
  route_table_id = aws_route_table.public_rt.id
 
}

resource "aws_route_table_association" "publicsubnet1b_association" {
  subnet_id      = aws_subnet.pubsubnet1b.id
  route_table_id = aws_route_table.public_rt.id
}

#elasticip  for NAT gateway in the public subnet pub-sub-1a
resource "aws_eip" "eip-nat-a" {
  domain = "vpc"

    

  tags   = {
    Name = "eip-nat-a"
  }
}

# allocate elastic ip this eip will be used for the nat-gateway in the public subnet pub-sub-1b
resource "aws_eip" "eip-nat-b" {
  domain = "vpc"


  tags   = {
    Name = "eip-nat-b"
  }
}

#NAT creation and eip's allocation for both 1a and 1b

resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = aws_subnet.pubsubnet1a.id 

  tags   = {
    Name = "nat-a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = aws_subnet.pubsubnet1b.id 

  tags   = {
    Name = "nat-b"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_internet_gateway.igw]
}

#PRIVATE routetable creation for  1a

resource "aws_route_table" "private_rt_1a" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-a.id
  }

  
  tags = {
    Name = "private_rt_1a"
  }
}

#routetable association with private subnet 1a 

resource "aws_route_table_association" "private_subnet_1a_association" {
  subnet_id = aws_subnet.prisubnet1a.id
  route_table_id = aws_route_table.private_rt_1a.id
  
}

#PRIVATE routetable creation for 1b

resource "aws_route_table" "private_rt_1b" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-b.id
  }

  
  tags = {
    Name = "private_rt_1b"
  }
}

#routetable association with private subnet  1b 

resource "aws_route_table_association" "private_subnet_1b_association" {
  subnet_id = aws_subnet.prisubnet1b.id
  route_table_id = aws_route_table.private_rt_1b.id
  
}
/*
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.myvpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  subnet_ids        = [aws_subnet.prisubnet1a.id,aws_subnet.prisubnet1b.id]
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [var.ssm_endpoint_sg_id]
  tags = {
    Name = "ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.myvpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
    vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [var.ssm_endpoint_sg_id]
  subnet_ids        = [aws_subnet.prisubnet1a.id,aws_subnet.prisubnet1b.id]
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.myvpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [var.ssm_endpoint_sg_id]
  subnet_ids        = [aws_subnet.prisubnet1a.id,aws_subnet.prisubnet1b.id]
}
*/