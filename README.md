# Deployment of Sock shop and A Voting Application with Kubernetes

This repository contains kubernetes files for the sock shop application and another kubernetes file for the voting application
the application is a micoservice application hence kubernetes services are leverage for communication between the application

To deploy this application, follow the following steps

- Create a Linux Ubuntu server
- Clone this repository
- Create a Linode account have a get a authentication token
- run the setup.sh script
- it'll prompt you for an authentication token, input it
- allow it to run

# How the Setup.sh works

The setup starts by installing tools like terraform, kubectl and helm

The setup uses terraform (set up to work with Linode cloud provider) to create a kubernetes cluster

Once the cluster is created it setup a kube-config to connect your server with the clusters and enable kubectl commands.

kubectl creates the pods and services and helm installs prometheus for logging and monitoring and installs ingress controller (nginx ingress controller) for external accesss to the cluster.

Another Terraform configuration runs lastly to register the domain name and subdomains in Linodes A record.

- result.dudeyouhavenoidea.me
- voting.dudeyouhavenoidea.me
- minisock.dudeyouhavenoidea.me

### NOTE

if you are going to run this script, you should change the domainName value to your domain name in /terraform-domain/terraform.tfvars
