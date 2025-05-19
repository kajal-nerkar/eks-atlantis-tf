resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "4.12.1" # Pinned version
  namespace  = kubernetes_namespace.atlantis.metadata[0].name
  timeout    = 600

  values = [
    file("${path.module}/atlantis-values.yaml")
  ]

  set_sensitive {
    name  = "github.token"
    value = var.github_token
  }

  set_sensitive {
    name  = "github.secret"
    value = var.github_webhook_secret
  }

  depends_on = [module.eks]
}

data "kubernetes_service" "atlantis" {
  metadata {
    name      = "atlantis"
    namespace = "atlantis"
  }
  depends_on = [helm_release.atlantis]
}