#
# AWS Provisioning
#
variable "access_key"          {}
variable "secret_key"          {}
variable "owner"               {}
variable "tld"                 {}
variable "additional_domain"   {}
variable "vdc"                 {}
variable "ssh_key_name"        {}
variable "region"              { default = "eu-west-1" }

variable "azs" {
  default = {
    "eu-west-1"      = "a,b,c"
    "eu-central-1"   = "a,b"
    "us-east-1"      = "a,b,c"
    "us-west-1"      = "a,c"
    "us-west-2"      = "b,c"
    "ap-southeast-2" = "a,b,c"
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

#
# RDS Configuration
#
variable "rds_instance"                { default = "db.t2.small" }
variable "rds_version"                 { default = "9.4.5" }
variable "rds_size"                    { default = "10" }
variable "rds_name"                    { default = "puppetdb" }
variable "rds_username"                {}
variable "rds_password"                {}
variable "rds_multi_az"                { default = "true" }
variable "rds_maintenance_window"      { default = "Sun:01:00-Sun:04:00" }
variable "rds_backup_window"           { default = "11:00-11:45" }
variable "rds_backup_retention_period" { default = "3" }
