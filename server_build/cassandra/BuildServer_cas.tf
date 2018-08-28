data "google_compute_image" "coreos_stable" {
  name  = "centos-7-v20180401"
  project = "centos-cloud"
}

module "compute-instance" {
  source  = "../../modules/terraform-gce"

  amount       = 3
  name_prefix  = "e4gs01dsevdb00"
  
  region       = "us-east4"
  project      = "e-comm-sit"
  subnet       = "securedb-non-pci-virginia"
  host_project = "sharedinfra-host-test"
  
  machine_type = "n1-standard-4"
  disk_size    = "100"
  disk_image   = "${data.google_compute_image.coreos_stable.self_link}"
  disk_size_data = "200"
    
  tags         = ["allow-cassandra","natgw-virginia-internet-access"]
  user_data    = ""
  start_script = "gsutil cp gs://bbby-packages/scripts/cas_setup.sh /tmp/ && chmod 755 /tmp/cas_setup.sh && ./tmp/cas_setup.sh test >> /tmp/setup.out"

 
  service_act  = "470021401767-compute@developer.gserviceaccount.com"
}
