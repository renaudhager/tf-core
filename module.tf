#
# AMIS
#
module "ami_ebs" {
  source        = "github.com/terraform-community-modules/tf_aws_ubuntu_ami"
  region        = "${var.region}"
  virttype      = "hvm"
  architecture  = "amd64"
  distribution  = "trusty"
  storagetype   = "ebs"
}
