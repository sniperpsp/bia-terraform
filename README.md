# Desafio 2 - Curso de Terraform 2024

Este repositório contém os arquivos necessários para o Desafio 2 do curso de Terraform do Henrylle Maia. Abaixo, uma explicação detalhada de cada arquivo e suas funções.

## Pré-requisitos

Antes de executar qualquer comando Terraform, é necessário configurar o AWS CLI com o perfil de sua preferência e alterar o perfil no arquivo `main.tf` para o que você criou em sua máquina. Para isso, execute o comando:

```sh
aws configure --profile bia
```

Siga as instruções para inserir suas credenciais AWS, região padrão e formato de saída.

## Arquivos e suas funções

### `main.tf`

Este é o arquivo principal do Terraform, onde são definidos os recursos a serem criados na AWS.

- **Bloco `terraform`**: Define os provedores necessários e a versão mínima do Terraform.  
- **Bloco `provider "aws"`**: Configura o provedor AWS com a região e o perfil no meu caso o perfil é `bia` no seu caso coloque o nome do seri perfil.  
- **Recurso `aws_instance "biaTF"`**: Cria uma instância EC2 com as especificações fornecidas, incluindo AMI, tipo de instância, grupos de segurança, sub-rede e tags.
- **Recurso `aws_security_group "SG-Terraform"`**: Define um grupo de segurança com regras de entrada e saída.
- **AMI** ela tambem deve ser alterada para uma AMI valida, caso não tenha nenhuma vá para o market place da AWS e procure pelo nome da distribuição que você quer, no meu caso foi o Amazon Linux 2024.03.1

### `variables.tf`

Define as variáveis utilizadas no arquivo `main.tf`.

- **`instance_name`**: Nome da instância EC2.
- **`ami`**: ID da AMI a ser utilizada para a instância EC2.

### `state_config.tf`

Configura o backend do Terraform para armazenar o estado em um bucket S3.

- **Bloco `backend "s3"`**: Define o bucket S3, chave, região e perfil para armazenar o estado do Terraform. Caso queri deixar os arquivos de estado no S3, basta deixar como está, caso contrário, comente o bloco ou coloque local no campo `backend "local"`.

### `.gitignore`

Especifica os arquivos e diretórios que devem ser ignorados pelo Git.

- **`**/.terraform/*`**: Ignora a pasta `.terraform` e seus conteúdos.
- **`terraform.tfstate*`**: Ignora arquivos de estado do Terraform.
- **`.terraform.lock*`**: Ignora arquivos de lock do Terraform.

### `README.md`

Este arquivo contém informações sobre o desafio e instruções importantes para configurar as variáveis de ambiente do Terraform.

### `outputs.tf`

Define as saídas do Terraform, que são informações sobre os recursos criados.

- **`instance_id`**: ID da instância EC2.
- **`instance_type`**: Tipo da instância EC2.
- **`security_groups`**: Grupos de segurança da instância EC2.
- **`ami`**: AMI da instância EC2.
- **`private_ip`**: IP privado da instância EC2.
- **`instace_public_ip`**: IP público da instância EC2 (nota: há um erro de digitação, deveria ser `instance_public_ip`).

Caso queria ver mais saidas pode utilizar o comando terraform show após criar o ambiente uma vez e pegar as informaçes que quiser ver.

## Comandos Úteis

- **Mudar variável na execução do apply**:
  ```sh
  terraform apply -var 'instance_name=biaTF-2'
  ```
- **Mudar variável e AMI na criação da EC2**:
  ```sh
  terraform apply -var 'instance_name=biaTF-2' -var 'ami=ami-0b72123ee41605393'
  ```
- **Mostrar informações sobre um recurso específico**:
  ```sh
  terraform state show aws_security_group.SG-Terraform
  terraform state show aws_instance.biaTF
  ```

Certifique-se de seguir as instruções e configurar corretamente o perfil AWS para garantir que todos os comandos funcionem conforme esperado.