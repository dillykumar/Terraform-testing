resource "null_resource" "cluster" {
    count = "${var.env == "Prod" ? 1 : 1}"
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("aws-key.pem")
      #host = "${aws_instance.web-1.*.public_ip}"
      host = element(aws_instance.web-1.*.public_ip, count.index)
    }

  }
#Remote-exec provisioner
provisioner  "remote-exec" {
    inline = [
        "chmod +x /tmp/script.sh",
        "sudo /tmp/script.sh",
        # "sudo yum update -y",
        "sudo yum install -y cowsay unzip",
        "cowsay 'Welome to DevOps Training ... Moooooo'", 
        "wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip",
        "unzip terraform_1.1.7_linux_amd64.zip && terraform_1.1.7_linux_amd64.zip && ./terraform version"
    ]
connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("aws-key.pem")
    host = element(aws_instance.web-1.*.public_ip, count.index)
}
}
}