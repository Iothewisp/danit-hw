# Here we must set our profile, otherwise infra will be created in the root account
provider "aws" {
  region  = var.region
  profile = var.iam_profile
}

provider "kubernetes" {
  host                   = aws_eks_cluster.danit.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.danit.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.danit.token
}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
#provider "http" {}

#terraform {
#  required_version = ">= 0.13"
#
#  required_providers {
#    kubectl = {
#      source  = "gavinbunney/kubectl"
#      version = ">= 1.7.0"
#    }
#  }
#}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.danit.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.danit.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.danit.token
  }
}

#provider "kubectl" {
#  host                   = aws_eks_cluster.kubeedge.endpoint
#  cluster_ca_certificate = base64decode(aws_eks_cluster.kubeedge.certificate_authority.0.data)
#  exec {
#    api_version = "client.authentication.k8s.io/v1beta1"
#    args        = ["--region", var.region, "eks", "get-token", "--cluster-name", var.name]
#    command     = "aws"
#  }
#}
