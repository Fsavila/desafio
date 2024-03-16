resource "aws_subnet" "eks_private_subnet" {
  count      = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.private_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "eks-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "eks_public_subnet" {
  count      = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.public_subnet_cidr[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "eks-public-subnet-${count.index}"
  }
}