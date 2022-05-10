resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myvpcgw.id
  }
  tags = {
    Name = "Public-Routing-Table"
  }
}

resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.myvpc.id


  tags = {
    Name = "Private-Routing-Table"
  }
}

resource "aws_route_table_association" "terraform-public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public-routing-table.id
}

resource "aws_route_table_association" "terraform-private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.private-routing-table.id
}