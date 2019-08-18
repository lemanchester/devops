# Operations

This folder is about setting up the infrastructure of Kubernetes, the deployment of servers, load balancers, clusters and other AWS resources.

The infrastructure is hosted using AWS and provisioned with [Hashicorp Terraform](https://www.terraform.io/).

## Structure

* **terraform/** -> Provisioning the Kubernetes infrastructure with Terraform


## Getting Started

Install the necessary dependencies using Homebrew (or your favourite package manager):

```
$ brew update && brew install awscli terraform
```


Make sure you have your own AWS IAM key pair. Once you have them, run
`aws configure` and input they key ID and access key when asked.

The default region name is **us-east-1**.

Now you can test your configuration:

```
$ aws s3 ls
```

Also make sure you have your SSH keys or you can run:

```
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Than you can add the key_pair_public_key to `terraform/terraform.tfvars` by running the following:

```
$ cat ~/.ssh/id_rsa.pub | awk '{print "key_pair_public_key = " "\"" $0 "\""}' > terraform/aws_pub_key.tfvars
```

Now you are ready to provision the Kubernetes on AWS.


### Terraform

It's structured on the following pattern:

* terraform/initialize.tf: Default vars used on the project as aws_region, availability zones, environment name
* terraform/modules: Abstraction creation of AWS resources as eks, vpc
* terraform/ouputs: Outputs after running terraform
* terraform/aws_pub_key.tfvar): Local env with SSH pub key to set on server
* terraform/terraform.tf: Declarative infrastructure to be created using local modules


#### Provisioning

Go to the terraform directory
```
$ cd terraform/
```

Install all terraform dependencies:

```
$ terraform init
```

Now you can run plan, it's going to display as resources planned to be created on AWS.

```
$ terraform plan -var-file="aws_pub_key.tfvars"
```

Finally you can apply to create the infrastructure:

```
$ terraform apply -var-file="aws_pub_key.tfvars"
```

Once finished you can run:

```
$ terraform destroy -var-file="aws_pub_key.tfvars"
```
