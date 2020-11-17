module "volt" {
	nodeCount = 3
	source 	= "./voltdb"
	image 	= "voltdb-8-4-1-feb-18"
}

provider "google" {
  project 		= "${var.project}",
  region  		= "${var.region}",
  zone    		= "${var.zone}",
  credentials 	= "${var.creds}"
}
