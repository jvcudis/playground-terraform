output "address" {
  access = "${aws_instance.frontend.public_dns}"
}
