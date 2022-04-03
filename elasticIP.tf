resource "aws_eip" "scandiEIP" {
  vpc                       = true
  network_interface         = aws_network_interface.scandiInterface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.scandiIG]
}
