provider "aws" {
  region = "ap-south-1"
  # Credentials should be provided via environment variables or AWS CLI configuration
  # For security, never hardcode credentials in your Terraform files
}

// resource "provider_resource" "example" {
  # Configuration for the resource
// }
resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "development"
      }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-south-1a"
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
  availability_zone = "ap-south-1a"
  tags = {
    Name: "subnet-2-default"
  }
}

# done till 1 VPC and 2 subnets
