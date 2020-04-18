## EIP
resource "aws_eip" "web_server" {
  vpc = true

  instance = aws_instance.web_server.id
}
