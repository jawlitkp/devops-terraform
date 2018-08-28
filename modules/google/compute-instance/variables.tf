variable "region" {}
variable "project" {}
variable "subnet" {}
variable "host_project" {}

variable "amount" {}
variable "name_prefix" {}
variable "machine_type" {}
variable "user_data" {}
variable "tags" {
  type   = "list"
}
variable "start_script" {}
variable "service_act" {}
variable "service_act_scope" {
  type = "list"
  default = ["logging-write", "monitoring-write", "storage-ro", "service-management", "service-control", "pubsub", "trace-append"]
}
variable "disk_type" {
  default = "pd-standard"
}

variable "disk_size" {}
variable "disk_image" {}

variable "disk_size_data" {}
variable "disk_type_data" {
  default = "pd-ssd"
}
variable "disk_create_local_exec_command_or_fail" {
  default = ":"
}

variable "disk_create_local_exec_command_and_continue" {
  default = ":"
}

variable "disk_destroy_local_exec_command_or_fail" {
  default = ":"
}

variable "disk_destroy_local_exec_command_and_continue" {
  default = ":"
}
