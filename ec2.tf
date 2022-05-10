resource "aws_instance" "web-1" {
    count = "${var.env == "Prod" ? 1 : 1}"
    #ami = var.imagename
    #ami = "ami-0b0af3577fe5e3532"
    ami = "${lookup(var.amis,var.region)}"
    #ami = ${data.aws_ami.my_ami.id}"
    #availability_zone = "us-east1-1"
    instance_type = "t2.micro"
    key_name = "aws-key"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true

    tags = {
        Name = "Server-${count.index+1}"
        Env = "${var.env}"
        Owner = "dilly"
        CostCenter = "abcd"
    }

    user_data = <<-EOF
      #!/bin/bash
      sudo yum update
      sudo yum install -y nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx
      echo "<h1>Server-${count.index+1}</h1>" | sudo tee /var/www/html/index.html
    EOF
    
    # lifecycle {
    #     create_before_destroy = true
    #     #prevent_destroy = true
    # }



}