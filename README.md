# terraform-nixos-nginx-webserver

An example project of a basic Terraform project (and modules) that create the AWS infrastructure for a webserver on NixOS.

This project is intended to accompany the blog post about this project (see www.mikemcgirr.com for that). 

- Uses Let's Encrypt for HTTPS
- Supports IPv4 and IPv6 

## Requirements 

- An AWS account
- Terraform version 0.12 installed (tested with Terraform v0.12.24)
- This also uses the aws-env helper script which you can find [here](https://github.com/fpco/devops-helpers/blob/master/aws/aws-env.sh)
