provider "aws" {}

// resource "provider_resource" "example" {
  # Configuration for the resource
// }
resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "development"
      }
}


variable avail_zone{}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = var.avail_zone
  tags = {
    Name: "subnet-1-dev"
  }
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = var.avail_zone
  tags = {
    Name: "subnet-2-default"
  }
}

# done till 1 VPC and 2 subnets

# when want to output the VPC ID and Subnet IDs
output "dev-vpc_id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-1_id" {
  value = aws_subnet.dev-subnet-1.id
}

/// Variables can be defined in a separate file, e.g., terraform.tfvars


# provider "aws" {
#   region = "ap-south-1"
#   # Credentials should be provided via environment variables or AWS CLI configuration
#   # For security, never hardcode credentials in your Terraform files
# }

# variable "subnet_cidr_block" {
#   description = "subnet cidr block"
#   default = "10.0.10.0/24"
#   type = string 
# }
# variable "vpc_cidr_block" {
#   description = "vpc cidr block"
# }
# resource "aws_vpc" "development-vpc" {
#   cidr_block = "var.vpc_cidr_block"
#   tags = {
#     Name: "development"
#       }
# }

# resource "aws_subnet" "dev-subnet-1" {
#   vpc_id = aws_vpc.development-vpc.id
#   cidr_block = var.subnet_cidr_block
#   availability_zone = "ap-south-1a"
#   tags = {
#     Name: "subnet-1-dev"
#   }
# }