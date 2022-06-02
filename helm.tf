resource "helm_release" "cluster_autoscaler" {
  depends_on = [var.mod_dependency, kubernetes_namespace.cluster_autoscaler]
  count      = var.enabled ? 1 : 0
  name       = var.helm_chart_name
  chart      = var.helm_chart_release_name
  repository = var.helm_chart_repo
  version    = var.helm_chart_version
  namespace  = var.namespace

  set {
    name  = "fullnameOverride"
    value = var.fullname_override
    type  = "string"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
    type  = "string"
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
    type  = "string"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = var.service_account_name
    type  = "string"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.kubernetes_cluster_autoscaler[0].arn
    type  = "string"
  }

  values = [
    yamlencode(var.settings)
  ]

}
