resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# DHCP options
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  domain_name_servers = ["AmazonProvidedDNS"]
}

# DHCP association
# the option needs to be associated with the VPC
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.vpc_dhcp_options.id}"
}

# Internet Gateway, required so that instances get access to the Internet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.main.id}"
}

# Internet route via Internet Gateway
resource "aws_route" "internet_route_via_igw" {
  route_table_id         = "${aws_route_table.route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route_table_association" "subnet_pub_route_table" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}