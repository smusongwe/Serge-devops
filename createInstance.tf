resource "aws_instance" "jenkins" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.jenkins.key_name
    security_groups = ["AllOpen"]

    tags = {
      "Name" = "Jenkins"
    }

      provisioner "file" {
      source = "jenkins.sh"
      destination = "/tmp/jenkins.sh"
  }
       provisioner "remote-exec" {
        inline = [
          "chmod +x /tmp/jenkins.sh",
          "sudo /tmp/jenkins.sh",
        ]

  }
  connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = var.INSTANCE_USERNAME
      private_key = file(var.PATH_TO_PRIVATE_KEY)
    }

}

resource "aws_instance" "sonarQube" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.jenkins.key_name
    security_groups = ["AllOpen"]

    tags = {
      "Name" = "SonarQube"
    }

    provisioner "file" {
    source = "sonarQube.sh"
    destination = "/tmp/sonarQube.sh"
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sonarQube.sh",
      "sudo /tmp/sonarQube.sh",
    ]

  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

}

resource "aws_instance" "nexus" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.jenkins.key_name
    security_groups = ["AllOpen"]

    tags = {
      "Name" = "Nexus"
    }

    provisioner "file" {
    source = "nexus.sh"
    destination = "/tmp/nexus.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/nexus.sh",
        "sudo /tmp/nexus.sh",
    ]

    }
    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = var.INSTANCE_USERNAME
      private_key = file(var.PATH_TO_PRIVATE_KEY)
    }

}


resource "aws_key_pair" "jenkins" {
    key_name = "jenkins01"
    public_key = file(var.PATH_TO_PUPLIC_KEY)

}
 
output "jenkinsIP" {
  value = aws_instance.jenkins.public_ip
}

output "nexusIP" {
  value = aws_instance.nexus.public_ip
  
}
 output "sonarQubeIP" {

   value = aws_instance.sonarQube.public_ip
   
 }