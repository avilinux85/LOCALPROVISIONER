data "aws_ami" "amimumbai" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.amimumbai.id
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  tags = {
    Name = upper("local-provisioner-ec2")
  }
}
