##############################
# resource/module
##############################
resource "kubernetes_namespace" "lbv2_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "lbv2" {
  name       = "aws-load-balancer-controller"
  repository = var.chart_repo_url
  version    = var.chart_version
  chart      = "aws-load-balancer-controller"
  namespace  = var.namespace
  values     = length(var.helm_values) > 0 ? var.helm_values : ["${file("${path.module}/helm-values.yaml")}"]
  dynamic "set" {
    for_each = var.extra_set_values
    content {
      name  = set.value.name
      value = set.value.value
      type  = set.value.type
    }
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.name"
    value = var.service_account
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.lb_role.arn
  }
  set {
    name  = "image.repository"
    value = var.image_repo
  }
  set {
    name  = "image.tag"
    value = var.image_tag
  }
  depends_on = [
    kubernetes_namespace.lbv2_namespace
  ]
}
