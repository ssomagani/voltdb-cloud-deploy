output "sg_id" {
  value 			= "${aws_security_group.allow_all.id}"
}

output "vpc_id" {
  value 			= "${aws_vpc.main.id}"
}

resource "aws_vpc" "main" {
  cidr_block 			= "${var.vpc_cidr_block}"
  tags				= {
    Name 			= "main"
  }
}

resource "aws_route_table" "route" {
  vpc_id 			= "${aws_vpc.main.id}"
  
  route {
    cidr_block 			= "0.0.0.0/0"
    gateway_id 			= "${aws_internet_gateway.igw.id}"
  }
  
  tags = {
    Name 			= "main"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id        	 	= "${aws_vpc.main.id}"
  route_table_id 	 	= "${aws_route_table.route.id}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id 			= "${aws_vpc.main.id}"

  tags 				= {
    Name 			= "Main"
  }
}

resource "aws_security_group" "allow_all" {
  name        			= "allow_all"
  description 			= "Allow all inbound traffic"
  vpc_id 			= "${aws_vpc.main.id}"

  ingress {
    from_port   		= 0
    to_port     		= 0
    protocol    		= "-1"
    cidr_blocks 		= ["0.0.0.0/0"]
  }

  egress {
    from_port       		= 0
    to_port         		= 0
    protocol       		= "-1"
    cidr_blocks     		= ["0.0.0.0/0"]
  }
}
