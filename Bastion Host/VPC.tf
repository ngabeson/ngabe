resource "aws_vpc" "EasyLife-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "EasyLife"
  }
}