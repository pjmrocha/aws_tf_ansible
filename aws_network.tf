# create VPC for jenkins master node
resource "aws_vpc" "vpc-master" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-jenkins"
  }
}

# create VPC for jenkins worker nodes
resource "aws_vpc" "vpc-worker" {
  provider             = aws.region-worker
  cidr_block           = "20.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "worker-vpc-jenkins"
  }
}

# create internet gateway for vpc-master
resource "aws_internet_gateway" "igw-master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc-master.id
}

# create internet gateway for vpc-worker
resource "aws_internet_gateway" "igw-worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc-worker.id
}

# get all AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}

# create subnet #1 in eu-west-2
resource "aws_subnet" "subnet-master-1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc-master.id
  cidr_block        = "10.0.1.0/24"
}

# create subnet #2 in eu-west-2
resource "aws_subnet" "subnet-master-2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc-master.id
  cidr_block        = "10.0.2.0/24"
}

# create subnet in eu-west-1
resource "aws_subnet" "subnet-worker" {
  provider   = aws.region-worker
  vpc_id     = aws_vpc.vpc-worker.id
  cidr_block = "20.0.1.0/24"
}
