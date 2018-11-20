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
    subnet_id      = "${aws_subnet.public_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.allow_all_egress.id}", "${aws_security_group.http_https.id}", "${aws_security_group.ssh.id}"]

    tags {
        Name = "DevOps"
    }

}
