resource "aws_instance" "scandiMagento" {
  ami               = "ami-0bd743b91a719d0a2"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "scandiKey"

  network_interface {
    device_index                 = 0
    network_network_interface_id = aws_network_interface.scandiInterface.id
  }
}

resource "aws_instance" "scandiVarnish" {
  ami               = "ami-0cfde60e1b01d45c2"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "scandiKey"

  network_interface {
    device_index                 = 0
    network_network_interface_id = aws_network_interface.scandiInterface.id
  }
}
