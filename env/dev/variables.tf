variable "gcp_project" {
  default = "gcp-devops-terraform"
}

variable "module_path" {
  default = "/Users/jp0003/Documents/devops/devops-terraform/modules"
}

//Spinnaker
variable "spinnaker_zone" {
  default = "us-east1-b"
}

variable "spinnaker_gcs_location" {
  default = "us-east1"
}

variable "spinnaker_service_account" {
  default = "terraform"
}

variable "spinnaker_cluster_name" {
  default     = "spinnaker"
  description = "GKE cluster name"
}

variable "spinnaker_cluster_nodes_count" {
  default     = 2
  description = "Number of nodes in the GKE cluster"
}

variable "spinnaker_cluster_node_type" {
  default     = "n1-standard-2"
  description = "VM Node type"
}

variable "spinnaker_version" {
  default = "1.8.5"
  description = "Spinnaker Version (hal version list)"
}
