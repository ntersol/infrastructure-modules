resource "aws_subnet" "public" {
  count             = var.count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnets(aws_vpc.main.cidr_block,4,4,4,4)[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_subnet" "private" {
  count             = var.count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnets(aws_vpc.main.cidr_block,4,4,4,4)[sum([count.index,2])]
  availability_zone = data.aws_availability_zones.available.names[count.index]
}