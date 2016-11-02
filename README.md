# tf-core

## Description
This repo contain terrraform code to build core function any AWS DC :
- VPC / Subnets
- NAT GW / Interet GW
- Jump host
- Common SG
- Nginx LB
- Puppetdb

All instance provisionning is made by puppet in a masterless mode.

You will need to create a file named : terraform.tfvars to store sensitives variables.
Please see terraform.tfvars.example.

## Limitation

- Currently one stack so any change can bring down the infrastructure.

## TODO

- Create 3 separate stack for instances to avoid down time during change.
