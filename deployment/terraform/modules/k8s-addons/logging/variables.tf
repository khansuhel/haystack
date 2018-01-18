variable "kubectl_context_name" {}
variable "kubectl_executable_name" {}
variable "container_log_path" {}
variable "es_nodes" {}
variable "k8s_storage_class" {}
variable "es_storage_volume" {}

variable "enabled" {
  default = false
}
