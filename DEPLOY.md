# Deploy

Para provisionamento dos recursos de infraestrutura, deve ser executado o código terraform disponivel no diretório **iac**, para facilitar a execução, pode ser utilizado o Makefile disponivel.

Para que o deploy seja executada de forma correta, existem alguns pré-requisitos que devem estar instalados na máquina que fará a execução:
  - Terraform
  - AWS cli
  - make
  - kubectl
  - dig

Além disto, será necessário a configuração das seguintes variaveis de ambiente:

| Variável                    | Descrição                                     |
|-----------------------------|-----------------------------------------------|
| AWS_ACCESS_KEY_ID           | ID da chave de acesso da AWS para autenticação de API.|
| AWS_SECRET_ACCESS_KEY       | Chave secreta da AWS para autenticação de API.|
| TF_VAR_argoAdminPassword    | Senha desejada para acesso ao admin do ArgoCD.|
| TF_VAR_grafanaAdminPassword | Senha desejada para acesso ao admin do Grafana.|

As demais variaveis do modulo podem ser ajustadas conforme desejado através de variavel de ambiente com prefixo **TF_VAR**, elas estão com valor default neste [arquivo](https://github.com/Fsavila/desafio/blob/main/iac/variables.tf)

Depois que todos pré-requisitos estiverem configurados, basta executar o seguinte comando para iniciar o provisionamento:

```
$ make deploy-infrastructure
```

Obs: Revisar as alterações que serão feitas na infraestrutura, o planejado é da criação de 31 recursos.


Para destruir a infraestrutura, basta executar o seguinte comando:

```
$ make destroy-infrastructure
```

Para documentação do que será provisionado de infraestrutura, veja [aqui](https://github.com/Fsavila/desafio/blob/main/iac/README.md).

