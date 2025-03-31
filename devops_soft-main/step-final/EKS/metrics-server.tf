resource "helm_release" "metrics" {
  depends_on       = [aws_eks_node_group.danit-amd]
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server"
  chart            = "metrics-server"
  version          = "3.12.1"
  namespace        = "kube-system"
  create_namespace = true
}
