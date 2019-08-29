# DevOps study case

The goal is to set up a highly available and load balanced cloud environment with Kubernetes running a sample java application and Jenkins for Continuous Delivery integration.

## Tools

List tools being used on the project:

 - (Docker)[http://docker.com]
 - (Terraform)[https://github.com/hashicorp/terraform]
 - (Kubernetes)[https://kubernetes.io/docs/tasks/tools/install-kubectl/]
 - (Kustomize)[https://github.com/kubernetes-sigs/kustomize]

## Structure

* [app/](app/README.md): Web application folder
* [ops/](ops/DEPLOY.md): Operations folder

## Deploying

Make you sure you have all dependencies from ops/ and app/ installed and configured.

You can create the Kubernetes infra on AWS running:

```
$ make provision
```

Than you can deploy the application:

```
$ make deploy
```

Create the Ingress on Kubernetes to receive data:

```
$ make ingress
```

Now wait couple minutes until we have the DNS available and run:

```
$ make hostname
```

Finally you can check the applications accessing:

http://webapp.dev.com/
http://jenkins.dev.com/
