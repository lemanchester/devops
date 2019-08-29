help: ## Show help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

provision: ## Provision Terraform with Kubernetes (EKS).
	(cd ops && make apply)

deploy: ## Deploy App Application to Kubernetes.
	(cd app && ./bin/deploy)

ingress: ## Create ALB that it will be redirect to K8s services.
	(cd op && make ingress)

hostname: ## Update local /etc/hosts to access services deployed.
	(./bin/update_hosts)
