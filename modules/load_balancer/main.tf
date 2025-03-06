# modules/load_balancer/main.tf
data "external" "fetch_neg_name" {
  program = ["bash", "${path.module}/fetch_neg_name.sh", var.nginx_service_name, var.nginx_namespace]
}

data "google_compute_network_endpoint_group" "nginx_neg" {
  name       = data.external.fetch_neg_name.result["neg_name"]
  zone       = "${var.region}-a"
}

resource "google_compute_health_check" "nginx_health_check" {
  name               = "nginx-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
  http_health_check {
    port         = 80
    request_path = "/"
  }
}

resource "google_compute_backend_service" "nginx_backend" {
  name        = "nginx-backend"
  protocol    = "HTTP"
  timeout_sec = 30
  backend {
    group            = data.google_compute_network_endpoint_group.nginx_neg.id
    balancing_mode   = "RATE"
    max_rate_per_endpoint = 100
  }
  health_checks = [google_compute_health_check.nginx_health_check.self_link]
}

resource "google_compute_url_map" "global_lb" {
  name            = "global-lb"
  default_service = google_compute_backend_service.nginx_backend.self_link
  host_rule {
    hosts        = [var.domain]
    path_matcher = "nginx-path-matcher"
  }
  path_matcher {
    name            = "nginx-path-matcher"
    default_service = google_compute_backend_service.nginx_backend.self_link
    path_rule {
      paths   = ["/nginx"]
      service = google_compute_backend_service.nginx_backend.self_link
    }
  }
}

resource "google_compute_global_address" "nginx_lb_ip" {
  name = "nginx-lb-ip"
}

resource "google_compute_target_http_proxy" "nginx_lb_target_proxy" {
  name    = "nginx-lb-target-proxy"
  url_map = google_compute_url_map.global_lb.self_link
}

resource "google_compute_global_forwarding_rule" "nginx_lb_forwarding_rule" {
  name       = "nginx-lb-forwarding-rule"
  target     = google_compute_target_http_proxy.nginx_lb_target_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.nginx_lb_ip.address
}