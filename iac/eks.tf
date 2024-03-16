resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    endpoint_private_access = true
    subnet_ids = aws_subnet.eks_private_subnet.*.id
  }

  depends_on = [aws_iam_role.eks_role]
}