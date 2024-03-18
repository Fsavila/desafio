# Arquitetura

A ideia é propor uma arquitetura escalavel tanto de forma horizontal quanto vertical para publicar esta aplicação e futuras que poderiam vir a ser necessario ter um ambiente semelhante, nesta forma podemos reutilizar esta arquitetura para o deploy de novas apps. Mesmo que a aplicação de comentários em questão não seja escalavel(não possui persistencia de dados), preferi optar por uma arquitetura escalavel para simular um cenário real do dia-a-dia.

## Tecnologias

Utilizarei Kubernetes para orquestração de containers e facilitação em criar uma arquitetura escalavel e de alta disponibilidade.

Fiz reflexões de formas para disponibilizar o k8s, entre fazer o deploy do cluster com RKE2 em instancias EC2 ou utilizar kubernetes gerenciado da AWS(EKS). Optei por utilizar kubernetes gerenciado da AWS(EKS) primeiramente devido a facilidade ao subir e nao precisar gerenciar os control plane, alem disto, por questões de custo eu nao precisaria manter EC2 on-demand para executar control plane e workers. Com o EKS consigo utilizar instancias spot para suportar o workload.

Para fazer o deploy de infraestrutura, será utilizado terraform que é uma ferramenta opensource para provisionamento de infraestrutura, optei devido a facilidade de uso e documentação.

O processo todo de deploy de infra via Github actions, com atlantis para review de Pull requests com diff de apply do Terraform. Para deploy de aplicações, será utilizado ArgoCD visando criar uma estrutura que seja expansivel para outras apps.



****** organização do codigo terraform em modulos

****** utilizado repositorio publico no docker hub para nao expor em plain text nos manifestos o account_id, region da minha conta na aws caso fosse utilizado ECR.

****** servicos internos(argo, prometheus, grafana) em um LB interno *melhoria*


****** importar grafana dashboard e setar como default