resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  namespace        = "ingress-nginx"
  create_namespace = true

  depends_on = [ aws_eks_cluster.eks_cluster ]
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.2"
  namespace        = "argocd"
  create_namespace = true


  values = [
    templatefile("./helm-values/argo-cd.yaml", { argoAdminPassword = var.argoAdminPassword })
  ]
  force_update = true

  depends_on = [ aws_eks_cluster.eks_cluster ]
}
