provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.aws_region}"
}

# Setup the security group since we need to access the resource instance for provisioning purposes.
resource "aws_security_group" "default" {
  name = "instance_secgroup"

  // Allow ssh access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow http access
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outside internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Setup the server instance
resource "aws_instance" "frontend" {
  # Use t2.micro since it's within the free-tier limit
  instance_type = "t2.micro"

  # Select the AMI id based on the region specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  key_name = "${var.key_name}"

  security_groups = ["${aws_security_group.default.name}"]

  user_data = "${file("provision.sh")}"

  tags {
    name = "frontend"
  }
}
