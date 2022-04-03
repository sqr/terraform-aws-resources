resource "aws_network_interface" "scandiInterface" {
  subnet_id       = aws_subnet.scandiSubnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allowWeb.id]
}
