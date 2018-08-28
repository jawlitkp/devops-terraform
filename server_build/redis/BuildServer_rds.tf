data "google_compute_image" "coreos_stable" {
  name  = "centos-7-v20180401"
  project = "centos-cloud"
}

module "compute-instance" {
  source  = "../../modules/terraform-gce"

  amount       = 3
  name_prefix  = "w1gp01rdsdb01"
  
  region       = "us-west1"
  project      = "production-project-195021"
  subnet       = "securedb-non-pci-oregon"
  host_project = "prod-host-project"
  
  machine_type = "n1-standard-16"
  disk_size    = "100"
  disk_image   = "${data.google_compute_image.coreos_stable.self_link}"
  disk_size_data = "350"
    
  tags         = ["allow-redis","natgw-oregon-internet-access"]
  user_data    = ""
  start_script = "gsutil cp gs://bbby-packages/scripts/redislabs_setup.sh /tmp/ && chmod 755 /tmp/redislabs_setup.sh && ./tmp/redislabs_setup.sh cl10.rds.wst1.bbby-app.com prod >> /tmp/setup.out"

 
  service_act  = "684206696648-compute@developer.gserviceaccount.com"
}
