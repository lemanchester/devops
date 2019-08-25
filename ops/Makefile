init:
	(cd terraform && terraform init)

plan: init
	(cd terraform && terraform plan -var-file="aws_pub_key.tfvars")

apply: init
	(cd terraform && terraform apply -auto-approve -var-file="aws_pub_key.tfvars") && \
	aws eks update-kubeconfig --name dev && \
	(cd k8s && kubectl create -f ./dev-namespace.yaml && \
	 kubectl config set-context --current --namespace=dev && \
	 kubectl apply -f rbac-role.yaml && \
	 kubectl apply -f alb-ingress-controller.yaml)

ingress:
	(./bin/create_k8s_ingress)

destroy: init
	(cd terraform && terraform destroy -var-file="aws_pub_key.tfvars")
