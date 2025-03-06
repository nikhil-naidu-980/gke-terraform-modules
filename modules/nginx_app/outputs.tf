
output "service_name" {
  value = kubernetes_service.nginx_app_service.metadata[0].name
}

output "namespace" {
  value = kubernetes_namespace.nginx_app_namespace.metadata[0].name
}