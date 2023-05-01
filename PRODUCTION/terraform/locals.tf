locals {
         owner                  = "leaddevopsengineer"
         account_type           = "production"
         environment            = "leaddevopsengineer-cluster01"
         cidr_block             = "10.40.0.0/16"
         az_count               = 3
         azs                    = slice(data.aws_availability_zones.available.names, 0, local.az_count)
         public_cidr            = cidrsubnet(local.cidr_block, 3, 0)
         private_cidr           = cidrsubnet(local.cidr_block, 2, 1)
         public_subnet_cidrs    = slice(cidrsubnets(local.public_cidr, 3, 3, 3, 3), 0, local.az_count)
         private_subnet_cidrs   = slice(cidrsubnets(local.private_cidr, 2, 2, 2, 2), 0, local.az_count)
         cluster_name           = local.environment
         tags                   = {
           Owner   = local.owner
           Project = "${local.owner}-${local.environment}"
           }
       }


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

