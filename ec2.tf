# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
    ami           = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    subnet_id      = "${aws_subnet.main.id}"

    # provisioner "file" {
    # source      = "script.sh"
    # destination = "/tmp/script.sh"
    # }

    # provisioner "remote-exec" {
    #     inline = [
    #     "sudo chmod +x /tmp/script.sh",
    #     "./tmp/script.sh",
    #     ]
    # }

    tags {
        Name = "HelloWorld"
    }

}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.allow_all.id}"
  network_interface_id = "${aws_instance.web.primary_network_interface_id}"
}