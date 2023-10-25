resource "aws_vpc" "demo-vpc" { 

  cidr_block = "10.0.0.0/16"

} 

//create subnet
resource "aws_subnet" "demo-subnet1" { 

  vpc_id     = aws_vpc.demo-vpc.id

  cidr_block = var.demo-subnet1

  tags = {

    Name = "demo-subnet"

  }

} 
resource "aws_subnet" "demo-subnet2" { 

  vpc_id     = aws_vpc.demo-vpc.id

  cidr_block = var.demo-subnet2

  tags = {

    Name = "demo-subnet"

  }

} 

//create internet gateway

resource "aws_internet_gateway" "demo-ig" {

  vpc_id = aws_vpc.demo-vpc.id

  tags = {

    Name = "demo-ig"

  }

}
//create a route table

resource "aws_route_table" "demo-rt" { 

  vpc_id = aws_vpc.demo-vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    # gateway_id = aws_internet_gateway.demo-ig.id
    gateway_id = aws_nat_gateway.nat.id

  }

    tags = {

    Name = "demo-rt"

  }

} 

//create a subnet association

resource "aws_route_table_association" "demo-rt-association1" {

  subnet_id = aws_subnet.demo-subnet1.id
  route_table_id = aws_route_table.demo-rt.id

} 
resource "aws_route_table_association" "demo-rt-association2" {

  subnet_id = aws_subnet.demo-subnet2.id
  route_table_id = aws_route_table.demo-rt.id

} 

//create security groups

resource "aws_security_group" "demo-sg" {

   name = "demo-sg"
   description = "Allow TLS inbound traffic"
   vpc_id = aws_vpc.demo-vpc.id
   ingress {
     description = "TLS from VPC"
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  } 
   ingress {
     description = "TLS from VPC" 
     from_port = 80 
     to_port = 80
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"]       
  } 
   ingress {
     description = "TLS from VPC"  
     from_port = 443
     to_port = 443
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"]  
}   
   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.demo-subnet1.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.demo-ig]
}
resource "aws_eip" "eip" {
  domain   = "vpc"
}
