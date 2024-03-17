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

  depends_on = [ aws_eks_cluster.eks_cluster ]
}

resource "helm_release" "custom_resources" {
  name             = "custom-resources"
  repository       = "https://bedag.github.io/helm-charts/"
  chart            = "raw"
  version          = "2.0.0"
  namespace        = "default"

  values = [
    file("./helm-values/custom-resources.yaml")
  ]
  depends_on = [ 
    aws_eks_cluster.eks_cluster,
    helm_release.argo_cd
  ]
}