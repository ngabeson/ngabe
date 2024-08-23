resource "aws_subnet" "pub_sn" {
  vpc_id = aws_vpc.EasyLife-vpc.id
  cidr_block = "11.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "pub-rt" {
  vpc_id = "aws_vpc.EasyLife-vpc.id"
  tags = {
    name = "public-rt"
  }
}

resource "aws_route" "pub-route" {
  route_table_id = aws_route_table.pub-rt.id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.easylife-igw.id
}

resource "aws_route_table_association" "pub-rt-ass" {
route_table_id = aws_route_table.pub-rt.id
subnet_id = aws_subnet.pub_sn.id 
}

resource "aws_security_group" "Pub-SG" {
vpc_id = aws_vpc.EasyLife-vpc.id
ingress {
  from_port = 22 
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"] 
}
tags = {
  name = "Priv-SG"
}
}

resource "aws_key_pair" "Pub-Keys" {
key_name = "public-keys"
public_key =file("~/.ssh/id_rsa.pub") 
}

resource "aws_instance" "pub-ec2" {
  ami = "0490fddec0cbeb88b"
  instance_type = "t2.micro"
  key_name = "public-keys"
  subnet_id = aws_subnet.pub_sn.id
  tags = {
    name = "EasyLife-pub"
  }
}
 