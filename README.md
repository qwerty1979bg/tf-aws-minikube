# Quickly fire up an AWS VM with minikube installed

This repository contains terraform code that creates an AWS EC2 *spot* instance running minikube.

## Prerequisites:
1. AWS account
2. SSH Keypair

## Usage

1. [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Clone this repository and `cd` into it.
3. Run the following:

```
$ export TF_VAR_aws_access_key=<YOUR AWS ACCESS KEY>
$ export TF_VAR_aws_secret_key=<YOUR AWS SECRET KEY>
$ export TF_VAR_key_name=<THE NAME OF YOUR SSH KEY>
$ terraform init
$ terraform apply
...
$ terraform destroy
```
