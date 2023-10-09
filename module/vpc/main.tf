//create VPC

resource "aws_vpc" "demo-vpc" { 

  cidr_block = var.vpc_cidr   

} 

//create subnet
resource "aws_subnet" "demo-subnet1" { 
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block =  var.subnet1_cidr 
  availability_zone = "${var.aws_region}a"
} 
resource "aws_subnet" "demo-subnet2" { 
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block =  var.subnet2_cidr 
  availability_zone = "${var.aws_region}b"
} 

//create internet gateway

resource "aws_internet_gateway" "demo-ig" {
  vpc_id = aws_vpc.demo-vpc.id
}
//create a route table

resource "aws_route_table" "demo-rt" { 
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = var.rt_cidr 
    gateway_id = aws_internet_gateway.demo-ig.id
  }
} 

//create a subnet association


resource "aws_route_table_association" "demo-rt-association-subnet1" {
  subnet_id      = aws_subnet.demo-subnet1.id
  route_table_id = aws_route_table.demo-rt.id
}

resource "aws_route_table_association" "demo-rt-association-subnet2" {
  subnet_id      = aws_subnet.demo-subnet2.id
  route_table_id = aws_route_table.demo-rt.id
}



//create security groups

resource "aws_security_group" "demo-sg" {
   name =  var.sgname
   description = "Allow TLS inbound traffic"
   vpc_id = aws_vpc.demo-vpc.id
ingress {
     description = "TLS from VPC"
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks=["::/0"]
} 
ingress {
     description = "TLS from VPC"  
     from_port = 80 
     to_port = 80
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"]  
     ipv6_cidr_blocks=["::/0"] 
} 
ingress {
     description = "TLS from VPC"  
     from_port = 443
     to_port = 443
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"]  
     ipv6_cidr_blocks=["::/0"] 
} 
egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
}
}
