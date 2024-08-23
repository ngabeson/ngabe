resource "aws_subnet" "priv_sn" {
  vpc_id = aws_vpc.EasyLife-vpc.id
  cidr_block = "11.0.2.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_route_table" "priv-rt" {
  vpc_id = "aws_vpc.EasyLife-vpc.id"
  tags = {
    name = "private-rt"
  }
}


resource "aws_route_table_association" "priv-rt-ass" {
route_table_id = aws_route_table.priv-rt.id
subnet_id = aws_subnet.priv_sn.id 
}

resource "aws_security_group" "Priv-SG" {
vpc_id = aws_vpc.EasyLife-vpc.id
ingress {
  from_port = 22 
  to_port = 22
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

resource "aws_key_pair" "Priv-Keys" {
key_name = "private-keys"
public_key =file("~/.ssh/id_rsa.pub") 
}

resource "aws_instance" "priv-ec2" {
  ami = "0490fddec0cbeb88b"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.priv_sn.id
  key_name = "private-keys"
  tags = {
    name = "EasyLife-priv"
  }
}
