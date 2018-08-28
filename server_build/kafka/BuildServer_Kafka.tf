data "google_compute_image" "coreos_stable" {
  name  = "centos-7-v20180401"
  project = "centos-cloud"
}

module "compute-instance" {
  source  = "../../modules/terraform-gce"

  amount       = 3

  name_prefix  = "e4gs01kfkvaps00"
  region       = "us-east4"
  project      = "e-comm-sit"
  subnet       = "secureapp-non-pci-virginia"
  host_project = "sharedinfra-host-test"

  

  machine_type = "n1-standard-1"
  disk_size    = "80"
  disk_image   = "${data.google_compute_image.coreos_stable.self_link}"
  disk_size_data = "100"


  tags         = ["allow-kafka-zk","natgw-virginia-internet-access"]
  user_data    = ""
  start_script = "gsutil cp gs://bbby-packages/scripts/kafka_setup.sh /tmp/ && chmod 755 /tmp/kafka_setup.sh && ./tmp/kafka_setup.sh \"e4gs01zkvaps001:2181,e4gs01zkvaps002:2181,e4gs01zkvaps003:2181\" >> /tmp/setup.out"
  
  service_act  = "470021401767-compute@developer.gserviceaccount.com"
}
