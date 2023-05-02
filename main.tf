module "subnets" {
  source                    = "./subnets"
  cidr_block                = var.cidr_block
  env                       = var.env
  availability_zones        = var.availability_zones
  default_vpc_id            = var.default_vpc_id
  name                      = var.name
  vpc_id                    = var.vpc_id
  vpc_peering_connection_id = var.vpc_peering_connection_id
}

#// creating a route to igw
#resource "aws_route" "gw_route" {
#  count = var.internet_gw ? 1 : 0
#  route_table_id = aws_route_table.route_table.id
#  destination_cidr_block    = "0.0.0.0/0"
#  gateway_id = var.internet_gw_id
#
#}
#
#//creating a INTERNET_GATEWAY
#resource "aws_internet_gateway" "igw" {
#  count = var.internet_gw ? 1 : 0
#
#  vpc_id = var.vpc_id
#
#  tags = merge (local.common_tags, { Name = "${var.env}-igw" } )
#
#}
#
#// creating the ELASTIC_IP
#resource "aws_eip" "ngw-elastic" {
#  vpc      = true
#}
#
#// Creating the NAT_gateway
#resource "aws_nat_gateway" "NATGW" {
#  count = var.nat_gw ? 1 : 0
#
#  allocation_id = aws_eip.ngw-elastic.id
#  subnet_id     = var.public_subnet_ids[0]
#
#  tags = merge (local.common_tags, { Name = "${var.env}-NAT_GW" } )
#
#
#  # To ensure proper ordering, it is recommended to add an explicit dependency
#  # on the Internet Gateway for the VPC.
#  //depends_on = [aws_internet_gateway.igw]
#}