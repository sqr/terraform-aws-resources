resource "aws_subnet" "scandiSubnet" {
  vpc_id            = aws_vpc.scandiVpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Scandi Subnet"
  }
}
