  
provider "aws" {
 region = "eu-central-1"
}

resource "aws_instance" "gitmvn" {
 ami = "ami-0e342d72b12109f91"
 instance_type = "t2.micro"
 key_name = "my-key4"
 security_groups = ["launch-wizard-2"]
 connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = "${file("~/.ssh/my-key4.pem")}"
  } 

 provisioner "file"{
   source      = "git::https://github.com/PZA-git/boxfuse3.git"
   destination = "myapp"
 }
}