resource "aws_eip" "eks_vpc_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eks_vpc_eip.id
  subnet_id     = aws_subnet.eks_public_subnet[0].id

  depends_on = [aws_internet_gateway.gw]
}