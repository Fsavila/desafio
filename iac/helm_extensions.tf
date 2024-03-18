resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  namespace        = "ingress-nginx"
  create_namespace = true

  values = [
    file("./helm-values/ingress-nginx.yaml")
  ]
  depends_on = [ 
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_managed_node_group
  ]
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

  depends_on = [ 
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_managed_node_group
  ]
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
    aws_eks_node_group.eks_managed_node_group,
    helm_release.argo_cd
  ]
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  version          = "25.17.0"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    file("./helm-values/prometheus.yaml")
  ]
  depends_on = [ 
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_managed_node_group
  ]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "7.3.7"
  namespace        = "monitoring"
  create_namespace = true

  values = [
        templatefile("./helm-values/grafana.yaml", { grafanaAdminPassword = var.grafanaAdminPassword })

  ]
  depends_on = [ 
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.eks_managed_node_group
  ]
}