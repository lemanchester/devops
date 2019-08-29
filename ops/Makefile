help: ## Show help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

init: ## Terraform install modules.
	(cd terraform && terraform init)

plan: init # Terraform init and plan infra to be provision on AWS.
	(cd terraform && terraform plan -var-file="aws_pub_key.tfvars")

apply: init # Provision terraform planned infra.
	(cd terraform && terraform apply -auto-approve -var-file="aws_pub_key.tfvars") && \
	aws eks update-kubeconfig --name dev && \
	(cd k8s && kubectl create -f ./dev-namespace.yaml && \
	 kubectl config set-context --current --namespace=dev && \
	 kubectl apply -f rbac-role.yaml && \
	 kubectl apply -f alb-ingress-controller.yaml)

ingress: # Create ALB to ingress traffic to k8s.
	(./bin/create_k8s_ingress)

jenkins_deploy: # Deploy Jenkins to k8s.
	(cd jenkins && kubectl apply -f ./storage-claim.yaml && \
	kubectl apply -f ./jenkins.yaml)

destroy: init # Destroy infra provisioned on AWS.
	(cd terraform && terraform destroy -var-file="aws_pub_key.tfvars")
