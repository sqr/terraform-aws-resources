resource "aws_internet_gateway" "scandiIG" {
  vpc_id = aws_vpc.scandiVpc.id
}