help: ## Show help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build: ## Build Docker image.
	(docker build --tag=webapp .)

deploy: init ## Push Image to AWS ECR and Deployt to K8s.
	(./bin/deploy)
