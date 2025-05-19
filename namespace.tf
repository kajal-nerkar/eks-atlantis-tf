# namespace.tf
resource "kubernetes_namespace" "atlantis" {
  metadata {
    name = "atlantis"
  }
}

resource "kubernetes_namespace" "atlantis_demo" {
  metadata {
    name = "atlantis_demo"
  }
}
