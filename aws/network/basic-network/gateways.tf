resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "ngw" {
  count          = var.count
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "eip" {
  count = var.count
  vpc   = true
}