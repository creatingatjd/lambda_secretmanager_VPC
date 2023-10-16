# VPC

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
    tags = {
    Name = "myapp-vpc"
  }
}

# Subnets
# - Public
resource "aws_subnet" "subnet1_public" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-2a"
  cidr_block              = "10.0.0.0/21"
  map_public_ip_on_launch = true
  tags = {
    Name = "myapp-subnet1-public"
  }
}
resource "aws_subnet" "subnet2_public" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-2b"
  cidr_block              = "10.0.16.0/21"
  map_public_ip_on_launch = true
  tags = {
    Name = "myapp-subnet2-publc"
  }
}


# Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "myapp-igw"
  }
}

# Routes tables
# - Public
resource "aws_route_table" "route_table1_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "myapp-rtb-public"
  }
}


resource "aws_route_table_association" "route_table_association1_public" {
  subnet_id      = aws_subnet.subnet1_public.id
  route_table_id = aws_route_table.route_table1_public.id
}
resource "aws_route_table_association" "route_table_association2_public" {
  subnet_id      = aws_subnet.subnet2_public.id
  route_table_id = aws_route_table.route_table1_public.id
}


resource "aws_eip" "eip1" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "myapp-eip1"
  }
}



resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.subnet1_public.id

  tags = {
    Name = "myapp-ngw1"
  }
}

resource "aws_default_network_acl" "default_network_acl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  subnet_ids             = [aws_subnet.subnet1_public.id, aws_subnet.subnet2_public.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "myapp-default-network-acl"
  }
}


resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    # self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myapp-default-sg"
  }
}


