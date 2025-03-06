
resource "kubernetes_namespace" "nginx_app_namespace" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "nginx_app_deployment" {
  metadata {
    name      = "${var.app_name}-deployment"
    namespace = kubernetes_namespace.nginx_app_namespace.metadata[0].name
    labels = { app = var.app_name }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = { app = var.app_name }
    }
    template {
      metadata {
        labels = { app = var.app_name }
        annotations = { "cloud.google.com/neg" = jsonencode({"exposed_ports" = {"80" = {}}}) }
      }
      spec {
        node_selector = { "cloud.google.com/gke-nodepool" = var.node_pool_name }
        container {
          name  = "${var.app_name}-container"
          image = "nginx:latest"
          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_app_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace.nginx_app_namespace.metadata[0].name
    annotations = { "cloud.google.com/neg" = jsonencode({"exposed_ports" = {"80" = {}}}) }
  }
  spec {
    selector = { app = var.app_name }
    port {
      port        = 80
      target_port = "80"
    }
    type = "ClusterIP"
  }
}