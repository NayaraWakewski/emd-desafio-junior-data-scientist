# Desafio Técnico - Cientista de Dados Júnior
# Candidata - Nayara Valevskii

Para este desafio será necessário ter acesso ao Google Cloud Platform (GCP) para utilizar o BigQuery, onde serão visualizados e consultados os dados disponíveis no projeto `datario`.

## 1- Análise SQL - GCP

1. Ir até o [GCP Console](https://console.cloud.google.com/) e criar uma conta Google ou utilizar a sua conta existente para realizar login
2. Criar ou selecionar um projeto existente com a opção *Sem organização*
3. Na barra de pesquisas ou no menu lateral procurar pelo *BigQuery*, que é onde iremos acessar os dados
4. Após entrar no console do *BigQuery*, iremos adicionar um novo projeto clicando em "+ Adicionar Dados" na barra Explorer.
5. Em seguida, clique em "Fixar projeto por nome" e procure pelo projeto **datario**.
6. Agora o projeto datario já está disponível na nossa barra explorer e podemos realizar nossas consultas.
7. Clicando no botão *New Query* é possível adicionar uma consulta SQL. As consultas deste projeto estão na página [analise_sql](https://github.com/nayarawakewski/emd-desafio-junior-data-scientist/blob/desafio-nayara-valevskii/analise_sql.sql). Para visualizar, copie o trecho de uma das consultas, cole na caixa de texto e clique em **Run**/**Executar** (Não consultar as querys todas de uma vez, por conta do tamanho da base, as consultas ficaram lentas; opte por consultar trecho por trecho).


---
## 2- Análise Python - Jupyter Notebook
1. Entre no site do Google Colabory, essa é a forma mais fácil e sem necessidade de instalar sistemas na máquina: [analise_sql](https://colab.research.google.com/?hl=pt_BR)
2. Em seguida, clique em `fazer login`, acesse com sua conta do Google.
3. Abrirá uma página para você importar um arquivo notebook jupyter, que será o arquivo `analise_sql.ipynb` que está nesse repositório. Lembre-se de clonar esse repositório antes ou baixar o arquivo jupyter.
4. Após importar o arquivo `analise_sql.ipynb` para o Colab, você pode executar as células para ver as análises em Python.
5. Execute primeiro as atualizações das bibliotecas do Google, após isso execute a célua de instalação da biblioteca `basedosdados`, essa biblioteca fará a conexão com os dados da base `datario`.
6. Para baixar os dados utilizando a biblioteca **basedosdados** será necessário utilizar o ID do projeto criado anteriormente no GCP. Para isso, clique no nome do projeto ou em "Selecionar um projeto" no Console do GCP e copie o **ID** do projeto.
7. Nas células de seleção das tabelas, você irá alterar o trecho:
```sql
query, billing_project_id="ID DO SEU PROJETO", reauth = True
```
   Esse ID do projeto será utilizado no notebook `analise_python.ipynb`.
   
8. Agora é possível executar todas as células presentes no notebook e visualizar as análises em Python.

   Para mais detalhes, verifique o tutorial a seguir: [Como acessar dados no BigQuery](https://docs.dados.rio/tutoriais/como-acessar-dados/#como-criar-uma-conta-na-gcp)

---


## 3- Visualização de Dados - PowerBi

1. Para criar a visualização em PowerBi, foi salvo os dataframes df_chamados_1746 e df_bairros, da análise em Python feito anteriormente em extensão CSV.
2. Foi utilizado o Figma para fazer os frames (Telas) das páginas do PowerBi, foi considerado  como base o layout do site Chamado 1746 do Rio de Janeiro.
3. Foram criadas algumas análises:

- Página 1: `Total Chamados`, `Chamados Resolvidos`, `Chamados Não Resolvidos`, `TopN5 Tipos de Chamados`;
- Página 2: `TopN5 Tipos de Chamados Não Resolvidos`;
- Página 3: `TopN5 Bairros com Chamados Não Resolvidos`;
- Filtros das Páginas: `Ano`, `Mês`, `Tipo Chamado`, `Subprefeitura`, `Bairro`;

Para visualizar o dashboard, acesso o link abaixo:

[Análise Chamados ](https://app.powerbi.com/view?r=eyJrIjoiODc1ZWJkMTUtZmU3ZC00ZDdlLWI0ZWYtY2YxMWRiZjRjNmNkIiwidCI6ImVjYTFhZTJkLWU5MjktNGM2OS1iZmEyLTAxNWQ0YzQ3OGY4YSJ9)

## 4- Considerações

A idéia inicial era criar um aplicativo e dashboard no Streamlit, mas por conta do tamanho da base de dados, o aplicativo ficou muito lento, mesmo dividindo a base em vários dataframes e análises menores. Por este motivo foi optado por utilizar o PowerBi, optando por fazer análises mais simples, mais explicando o entendimento de cada análise feita.

## 🎁 Expressões de gratidão

* Obrigada pela oportunidade de participar do processo seletivo 📢;

---
⌨️ com ❤️ por [Nayara Vakevskii](https://github.com/NayaraWakewski) 😊
