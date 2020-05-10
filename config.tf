  
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

 provisioner "remote-exec" {
    inline = [
         "sudo apt update",
         "sudo apt install -y git",
         "sudo apt install -y maven",
         "git clone https://github.com/PZA-git/boxfuse3.git myapp",
         "cd myapp && mvn package", 
    ]
 }
}

resource "aws_instance" "tomcat8" {
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
 
 provisioner "remote-exec" {
    inline = [
         "sudo apt update",
         "sudo apt install -y tomcat8",
    ]
 }

 provisioner "file"{
   source      = "~/myapp/hello-1.0.war"
   destination = "/var/lib/tomcat8/webapps/"
 connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = "${file("~/.ssh/my-key4.pem")}"
   } 
 } 
 provisioner "file"{
   source      = "~/.ssh/my-key4.pem"
   destination = "~/.ssh/my-key4.pem"
 connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = "${file("~/.ssh/my-key4.pem")}"
    host =  "{gitmvn}"
   } 
 }

 provisioner "file"{
   source      = "~/myapp/hello-1.0.war"
   destination = "/var/lib/tomcat8/webapps/"
 connection {
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = "${file("~/.ssh/my-key4.pem")}"
    host = "{gitmvn}"
   } 
 }
}
