variable "kubectl_context_name" {}
variable "kubectl_executable_name" {}
variable "base_domain_name" {}
variable "haystack_cluster_name" {}
variable "haystack_domain_name" {}
variable "traefik_node_port" {}
variable "add_logging_addons" {}
variable "add_monitoring_addons" {}
variable "add_dashboard_addons" {}
variable "container_log_path" {}
variable "logging_es_nodes" {}


variable "grafana_storage_volume" {
  default = "100Mi"
}
variable "k8s_storage_class" {
  default = "standard"
}
variable "influxdb_storage_volume" {
  default = "100Mi"
}

variable "es_storage_volume" {
  default = "100Mi"
}
