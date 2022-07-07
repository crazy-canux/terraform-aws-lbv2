# terraform-aws-lb

provision aws-load-balancer-controller with terraform.

## HowTo

    module "lbv2" {
      source               = "crazy-canux/lbv2/aws"
      version              = "0.1.0"
      namespace_name = local.namespace
      helm_values          = ["${file("${path.module}/helm-values.yaml")}"]
      depends_on = [data.terraform_remote_state.eks]
    }
