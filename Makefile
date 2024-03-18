TERRAFORM := $(which terraform 2> /dev/null)
AWS := $(which aws 2> /dev/null)
KUBECTL := $(which kubectl 2> /dev/null)

ifeq ($(TERRAFORM),1)
	$(error Please install terraform)
endif

ifeq ($(AWS),1)
	$(error Please install AWSCli)
endif

ifeq ($(KUBECTL),1)
	$(error Please install kubectl)
endif

ifndef AWS_ACCESS_KEY_ID
	$(error AWS_ACCESS_KEY_ID is undefined)
endif

ifndef AWS_SECRET_ACCESS_KEY
	$(error AWS_SECRET_ACCESS_KEY is undefined)
endif

ifndef TF_VAR_argoAdminPassword
	$(error TF_VAR_argoAdminPassword is undefined)
endif

ifndef TF_VAR_grafanaAdminPassword
	$(error TF_VAR_grafanaAdminPassword is undefined)
endif

deploy-infrastructure:
	cd iac && terraform init && terraform apply

	aws eks update-kubeconfig --region us-east-1 --name eks-desafio

	HOSTNAME=$$(kubectl get service ingress-nginx-controller --namespace ingress-nginx --output jsonpath='{.status.loadBalancer.ingress[0].hostname}') ; \
	IP=$$(dig @8.8.8.8 $$HOSTNAME +short | head -n1) ; \
	echo "$$IP argocd.felipeavila.com.br hello-world.felipeavila.com.br comentarios.felipeavila.com.br grafana.felipeavila.com.br prometheus.felipeavila.com.br" | sudo tee -a /etc/hosts

	 @echo "Deploy de infraestrutura finalizado!"

destroy-infrastructure:
	cd iac && terraform init && terraform destroy
