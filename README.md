# tf-aws-network
Terraform Module AWS Network


Example usage:
```
module "network" {
  source   = "github.com/gadgetry-io/tf-aws-network"
  vpc_name = "test"
  vpc_cidr = "192.100.0.0/16"

  vpc_private_subnets = {
    us-east-1a = "192.100.1.0/24"
    us-east-1b = "192.100.3.0/24"
    us-east-1c = "192.100.5.0/24"
  }

  vpc_public_subnets = {
    us-east-1a = "192.100.2.0/24"
    us-east-1b = "192.100.4.0/24"
    us-east-1c = "192.100.6.0/24"
  }

  vpc_dmz_subnets = {}
}
```