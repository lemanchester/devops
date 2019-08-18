# Web application

Simple java web application.

### Dependencies

 - [Docker](https://www.docker.com/)
 - [Kustomize](https://kustomize.io/)
 - [Jq](https://stedolan.github.io/jq/)


## Installation

 ```
 $ brew update && brew install kustomize jq
 ```

### Docker

Build the image:
```
$ docker build --tag=webapp .
```

Running the container:
```
$ docker run -p 8080:8080 webapp
```

### Web application

The application expose the port 8080 and you check running by:

http://localhost:8080/

It also provides a health check endpoint:

http://localhost:8080/actuator/health

## Docker Registry

In order to deploy our application to Kubernetes we have first build and push the image to AWS ECR:

Let's create a local env that it would be used to PUSH the image:

```
$ WEBAPP_REPO=$(aws ecr describe-repositories --repository-names webapp | jq -r '.repositories[0].repositoryUri')
```

After building the image we can tag and push it

```
$ docker tag java-helloworld:latest $WEBAPP_REPO
$ docker push $WEBAPP_REPO
```

## Kubernetes

This project it's using [Kustomize](https://github.com/kubernetes-sigs/kustomize) to handle the Kubernetes configurations files, that an excellent tool to handle multiple configuration per environments, although, it's not this case we are going to use it anyway.

### Structure

* **k8s/**: All files related to the application and deployment of Kuberenetes

### Deployment

Go to the kubernetes folder:

```
$ cd k8s/
```

In order to deploy our web application to Kubernetes make sure you have pushed the image to the Docker repository and defined the `$WEBAPP_REPO` var above.

Now we can finally run the `kuztomize buid` that it will generate all resources to be create on Kubernetes.

obs. The sed command it's updating the final output with the repository url from out env $WEBAPP_REPO


```
$ kustomize build | sed -e 's,WEBAPP_REPO,'$WEBAPP_REPO',g' | kubectl apply -f -
```

You now have the PODS running you can check running:


```
$ kubectl get pods -n dev
```
