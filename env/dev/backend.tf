terraform {
 backend "gcs" {
   bucket    = "my-devops-org-terraform"
   prefix    = "/terraform.tfstate"
   project   = "my-devops-org"
 }
}
