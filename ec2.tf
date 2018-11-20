resource "aws_instance" "web" {
    ami = "ami-031a3db8bacbcdc20"
    instance_type = "t2.micro"
    key_name = "introDevops"
    subnet_id = "${aws_subnet.public_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.allow_all_egress.id}", "${aws_security_group.http_https.id}", "${aws_security_group.ssh.id}"]

    tags {
        Name = "DevOps"
    }

}
