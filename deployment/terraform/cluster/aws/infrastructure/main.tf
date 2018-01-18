locals {
  container_log_path = "/var/lib/docker/containers"
}
module "haystack-k8s" {
  source = "../../../modules/k8s-cluster/aws"
  k8s_aws_nodes_subnet_ids = "${var.aws_nodes_subnet}"
  k8s_aws_ssh_key = "${var.aws_ssh_key}"
  k8s_hosted_zone_id = "${data.aws_route53_zone.haystack_dns_zone.id}"
  k8s_base_domain_name = "${var.aws_domain_name}"
  k8s_master_instance_type = "${var.k8s_node_instance_type}"
  k8s_aws_vpc_id = "${var.aws_vpc_id}"
  k8s_aws_zone = "${var.aws_zone}"
  k8s_aws_utility_subnet_ids = "${var.aws_utilities_subnet}"
  k8s_node_instance_type = "${var.k8s_node_instance_type}"
  k8s_s3_bucket_name = "${var.s3_bucket_name}"
  k8s_aws_region = "${var.aws_region}"
  k8s_node_instance_count = "${var.k8s_node_instance_count}"
  reverse_proxy_port = "${var.reverse_proxy_port}"
  kops_executable_name = "${var.kops_executable_name}"
  haystack_cluster_name = "${var.haystack_cluster_name}"
  kubectl_executable_name = "${var.kubectl_executable_name}"
}
module "k8s-addons" {
  source = "../../../modules/k8s-addons"
  kubectl_context_name = "${module.haystack-k8s.cluster_name}"
  kubectl_executable_name = "${var.kubectl_executable_name}"
  traefik_node_port = "${var.traefik_node_port}"
  base_domain_name = "${var.aws_domain_name}"
  haystack_cluster_name = "${var.haystack_cluster_name}"
  haystack_domain_name = "${module.haystack-k8s.cluster_name}"
  add_monitoring_addons = true
  add_logging_addons = true
  add_dashboard_addons = true
  container_log_path = "${local.container_log_path}"
  logging_es_nodes = "2"
  k8s_storage_class = "default"
  grafana_storage_volume = "2Gi"
  influxdb_storage_volume = "2Gi"
  es_storage_volume = "100Gi"
}
module "haystack-datastores" {
  source = "../../../modules/haystack-datastores/aws"
  aws_utilities_subnet = "${var.aws_utilities_subnet}"
  aws_vpc_id = "${var.aws_vpc_id}"
  aws_nodes_subnet = "${var.aws_nodes_subnet}"
  s3_bucket_name = "${var.s3_bucket_name}"
  aws_ssh_key = "${var.aws_ssh_key}"
  kafka_broker_instance_type = "${var.kafka_broker_instance_type}"
  kafka_broker_count = "${var.kafka_broker_count}"
  kafka_broker_volume_size = "${var.kafka_broker_volume_size}"
  aws_hosted_zone_id = "${data.aws_route53_zone.haystack_dns_zone.id}"
  cassandra_node_volume_size = "${var.cassandra_node_volume_size}"
  cassandra_node_instance_count = "${var.cassandra_node_instance_count}"
  aws_region = "${var.aws_region}"
  cassandra_node_instance_type = "${var.cassandra_node_instance_type}"
  cassandra_node_image = "${var.cassandra_node_image}"
  k8s_app_name_space = "${module.k8s-addons.k8s_app_namespace}"
  haystack_index_store_master_count = "${var.haystack_index_store_master_count}"
  haystack_index_store_instance_count = "${var.haystack_index_store_instance_count}"
  haystack_index_store_worker_instance_type = "${var.haystack_index_store_worker_instance_type}"
  haystack_index_store_es_master_instance_type = "${var.haystack_index_store_es_master_instance_type}"
  haystack_cluster_name = "${var.haystack_cluster_name}"
}