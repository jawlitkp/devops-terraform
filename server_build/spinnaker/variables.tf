variable "project" {
  description = "gcp-devops-terraform"
}

variable "zone" {
  default = "us-east1-b"
}

variable "gcs_location" {
  default = "us-east1"
}

variable "service_account" {
  default = "terraform"
}

variable "cluster_name" {
  default     = "spinnaker"
  description = "GKE cluster name"
}

variable "cluster_nodes_count" {
  default     = 2
  description = "Number of nodes in the GKE cluster"
}

variable "node_type" {
  default     = "n1-standard-2"
  description = "VM Node type"
}

variable "spinnaker_version" {
  default = "1.8.5"
  description = "Spinnaker Version (hal version list)"
}
