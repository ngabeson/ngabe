resource "aws_internet_gateway" "easylife-igw" {
  vpc_id = aws_vpc.EasyLife-vpc.id
  tags = {
    name="Life"
  }

}