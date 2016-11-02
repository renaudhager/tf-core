#
# AWS Provisioning
#
variable "access_key"          {}
variable "secret_key"          {}
variable "owner"               {}
variable "tld"                 {}
variable "vdc"                 {}
variable "region"              { default = "eu-west-1" }

variable "azs" {
  default = {
    "eu-west-1"    = "a,b,c"
    "eu-central-1" = "a,b"
    "us-east-1"    = "a,b,c"
    "us-west-1"    = "a,c"
    "us-west-2"    = "b,c"
  }
}

#
# INSTANCES SIZES
#

# CORE
variable "instance_jump"         { default = "t2.nano" }
variable "instance_puppetdb"     { default = "t2.small" }
variable "instance_nginx"        { default = "t2.small" }

#
# NETWORK
#
variable "vpc_cidr"              { default = "172.16.8.0/24" }
variable "subnet_bits"           { default = "3" }
variable "route53_ttl"           { default = "60" }

#
# SECURITY
#
variable "allowed_ips"           { default = "0.0.0.0/0" }

#
# PUPPET AGENT
#
variable "puppet_agent_version"  { default = "1.7.0-1trusty" }
variable "puppet_env"            { default = "aws" }
