# Desafios IDwall

Aqui estão o chart da aplicação app-chart, junto com o script de deploy.

**Instruções Pré-Execução:**

- Esse desafio foi criado utilizando minikube, para que o deploy seja realizado com sucesso é necessário o minikube estar rodando (`minukube start`) com uma instância do helm up (`helm init`).

- Além disso, é necessário adicionar o recurso de Ingress do Minikube para que ele repasse a requisição para o Cluster (`minikube addons enable ingress`).

- Adicionar a entrada `chart-example.local` no `/etc/hosts` apontando para o ip do minikube (`minikube ip`)


**Instruções de Execução:**

- **Para efetuar o deploy rode o comando `./run.sh`.**

- Após o deploy ser finalizado, acessar http://chart-example.local/ 
