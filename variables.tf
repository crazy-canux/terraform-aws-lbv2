variable "cluster_name" {
  description = "k8s cluster name"
  type        = string
}

variable "oidc_issuer" {
  description = "OIDC provider, leave in blank for EKS clusters"
  type        = string
  default     = null
}

variable "lbv2_namespace" {
  description = "lbv2 namespace"
  type        = string
  default     = "kube-system"
}

variable "lbv2_service_account" {
  description = "Service account to be created for use with the lbv2 controller"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "lbv2_chart_repo_url" {
  description = "URL to repository containing the lbv2 helm chart"
  type        = string
  default     = "https://aws.github.io/eks-charts"
}

variable "lbv2_chart_version" {
  description = "lbv2 helm chart version"
  type        = string
  default     = "1.4.2"
}

variable "helm_values" {
  description = "Values for lbv2 Helm chart in raw YAML."
  type        = list(string)
  default     = []
}

variable "extra_set_values" {
  description = "Specific values to override in the external-dns Helm chart (overrides corresponding values in the helm-value.yaml file within the module)"
  type = list(object({
    name  = string
    value = any
    type  = string
    })
  )
  default = []
}

variable "image_repo" {
  type    = string
  default = "602401143452.dkr.ecr.us-west-1.amazonaws.com/amazon/aws-load-balancer-controller"
}

variable "image_tag" {
  type    = string
  default = "v2.4.2"
}
