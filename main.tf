# Define the variables
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "key_name" {
  default = "macos"
}

variable "ami_name" {
  default = "ami-0f9cf087c1f27d9b1"
}

# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

# Create an MINIKUBE server
resource "aws_spot_instance_request" "minikube" {
  ami = "${var.ami_name}"

#  instance_type = "t2.micro"
  instance_type = "t2.small"
#  instance_type = "t2.medium"

  key_name = "${var.key_name}"

  #  spot_price           = "0.0035"
  wait_for_fulfillment = true
  spot_type            = "one-time"

  root_block_device {
    #    device_name           = "/dev/xvda"
    volume_type           = "standard"
    delete_on_termination = true
  }

  # Workaround for the Cloud-init
  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait ; exit 0",
    ]
  }

  # Workaround for terraform missing "sudo" option to remote-exec
  # https://github.com/hashicorp/terraform/issues/550
  provisioner "file" {
    source      = "scripts/provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "sudo -i /tmp/provision.sh",
    ]
  }

  #  provisioner "remote-exec" {
  #    script = "scripts/provision.sh"
  #  }

  #  provisioner "local-exec" {
  #    command = "echo quickly connect to ${aws_spot_instance_request.el_dockerino.public_ip}:7990"
  #  }
}

output "connect_here" {
  value = ["${aws_spot_instance_request.minikube.public_ip}"]
}
