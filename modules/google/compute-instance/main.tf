provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
}


data "google_compute_zones" "available" {
  region = "${var.region}"
  status = "UP"
}

resource "google_compute_address" "instances" {
  count = "${var.amount}"
  address_type = "INTERNAL"
  name  = "${var.name_prefix}${count.index+1}"
  subnetwork = "projects/${var.host_project}/regions/${var.region}/subnetworks/${var.subnet}"
}


resource "google_compute_disk" "datadisk" {
  count = "${var.amount}"
  name = "${var.name_prefix}${count.index+1}-data"
  type = "${var.disk_type_data}"
  zone = "${data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]}"
  size = "${var.disk_size_data}"

  provisioner "local-exec" {
    command    = "${var.disk_create_local_exec_command_or_fail}"
    on_failure = "fail"
  }

  provisioner "local-exec" {
    command    = "${var.disk_create_local_exec_command_and_continue}"
    on_failure = "continue"
  }

  provisioner "local-exec" {
    when       = "destroy"
    command    = "${var.disk_destroy_local_exec_command_or_fail}"
    on_failure = "fail"
  }

  provisioner "local-exec" {
    when       = "destroy"
    command    = "${var.disk_destroy_local_exec_command_and_continue}"
    on_failure = "continue"
  }
}

resource "google_compute_instance" "instances" {
  count = "${var.amount}"

  name         = "${var.name_prefix}${count.index+1}"
  zone         = "${data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]}"
  machine_type = "${var.machine_type}"

  tags = ["${var.tags}"]
  metadata_startup_script = "${var.start_script}"

  service_account = {
    scopes = "${var.service_act_scope}"
    email = "${var.service_act}"
  }

  boot_disk = {
    auto_delete = true
    device_name = "${var.name_prefix}${count.index+1}-root"

  initialize_params {
  	  type = "${var.disk_type}"
  	  size = "${var.disk_size}"
	  image = "${var.disk_image}"
    }
  }

  attached_disk {
     source = "${element(google_compute_disk.datadisk.*.name, count.index)}"
  }

  metadata {
    user-data = "${replace(replace(var.user_data, "$$ZONE", data.google_compute_zones.available.names[count.index]), "$$REGION", var.region)}"
  }

  network_interface = {
    subnetwork          = "${var.subnet}"
    subnetwork_project  = "${var.host_project}"
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = "true"
  }

}
