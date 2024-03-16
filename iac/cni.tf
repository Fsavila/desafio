resource "aws_eks_addon" "cni_eks_cluster" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "vpc-cni"
  addon_version = "v1.16.4-eksbuild.2"
  
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [data.tls_certificate.thumbprint_oidc_url.certificates.0.sha1_fingerprint]
}

data "tls_certificate" "thumbprint_oidc_url" {
  url = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

data "aws_iam_policy_document" "assume_role_policy_cni" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "role-cni-eks" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_cni.json
  name               = "${aws_eks_cluster.eks_cluster.name}-vpc-cni-role"
}

resource "aws_iam_role_policy_attachment" "cni-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.role-cni-eks.name
}