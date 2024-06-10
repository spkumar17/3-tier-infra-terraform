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



  tags = {
    Name = "prisubnet_us_east_1a"
  }
}

resource "aws_subnet" "prisubnet1b" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    cidr_block = var.prisub1b_cidr_block



  tags = {
    Name = "prisubnet_us_east_1b"
  }
}

#secure subnets  (not connected to IGW or NAT)

resource "aws_subnet" "secsubnet1a" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    cidr_block = var.secsub1a_cidr_block



  tags = {
    Name = "secsubnet_us_east_1a"
  }
}

resource "aws_subnet" "secsubnet1b" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    cidr_block = var.secsub1b_cidr_block



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

resource "aws_eip" "eip-nat-a" {
  domain = "vpc"

    

  tags   = {
    Name = "eip-nat-a"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-2-b
resource "aws_eip" "eip-nat-b" {
  domain = "vpc"


  tags   = {
    Name = "eip-nat-b"
  }
}

#NAT creation and eip allocation

resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = aws_subnet.prisubnet1a.id 

  tags   = {
    Name = "nat-a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = aws_subnet.prisubnet1b.id 

  tags   = {
    Name = "nat-b"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [aws_internet_gateway.igw]
}
