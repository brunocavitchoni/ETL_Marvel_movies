Projeto de ETL (Extração, Transformação e Carregamento de dados), com banco de dados em formato CSV, referente aos filmes da Marvel Cinematic Universe, disponibilizado pela plataforma Kaggle.

Utilizei este tema para treinamento do processo de ingestão de dados de ponta a ponta, utilizando apenas SQL. 

Criação de ETL utilizando a Arquitetura Medallion:

-----------------------------------------------------------------

CAMADA BRONZE

Armazenamento de dados brutos, sem transformação

![image](https://github.com/user-attachments/assets/a7126d59-04e7-4457-8531-779404c0896e)

![image](https://github.com/user-attachments/assets/d3270f88-d311-487f-b37c-06dc706f8a32)

VISUALIZAÇÃO DE DADOS DA TABELA bronze_marvel_movies:

![image](https://github.com/user-attachments/assets/50ee5fb0-a2e1-4bf3-961a-f7aacc5c3b93)

Utilizei apenas as 10 primeiras linhas, para facilitar a visualização dos dados neste arquivo.

-----------------------------------------------------------------

CAMADA SILVER

Primeira transformação dos dados, modificando os tipo das colunas release_date, production_budget, opening_weekend, domestic_box_office e worldwide_box_office:

![image](https://github.com/user-attachments/assets/7fd2e40f-620e-4240-b13c-6ac59d478dd0)

VISUALIZAÇÃO DE DADOS DA TABELA silver_marvel_movies:

![image](https://github.com/user-attachments/assets/cb78e36e-2469-45a8-92a2-d561d50d2b74)

Criação de tabela com a divisão de franquias

![image](https://github.com/user-attachments/assets/b4a0e9db-53f7-47a3-a01f-d0623d1be163)

VISUALIZAÇÃO DE DADOS DA TABELA silver_franchise_mapping:

![image](https://github.com/user-attachments/assets/4727e6ab-299d-4960-b2f5-dedfdee068b8)

-----------------------------------------------------------------

CAMADA GOLD

Transformação final dos dados, criando tabelas úteis para análises posteriores. Criei tabelas para análises qualitativas (gold_movies_summary e gold_franchises_summary), referente às notas que cada filme e franquia receberam pela audience e pela crítica no site Rotten Tomatoes, e tabelas para análise quantitativa (gold_movies_financial_performance e gold_franchises_financial_performance), referente aos valores arrecadados por filme e por franquia

CRIAÇÃO DA TABELA gold_movies_summary

![image](https://github.com/user-attachments/assets/d120e187-a19c-4b47-82a1-2d9c287c602d)

VISUALIZAÇÃO DOS DADOS DA TABELA gold_movies_summary

![image](https://github.com/user-attachments/assets/4076e54a-27bc-4172-a4d5-76ca4ef75030)

CRIAÇÃO DA TABELA gold_movies_financial_performance

![image](https://github.com/user-attachments/assets/c54f0665-7853-4ceb-a87a-b74fe1c08aad)

VISUALIZAÇÃO DOS DADOS DA TABELA gold_movies_financial_performance

![image](https://github.com/user-attachments/assets/7148c1dd-5f45-4803-b18e-ce2eb6b72e58)

CRIAÇÃO DA TABELA gold_franchises_summary

![image](https://github.com/user-attachments/assets/29076d52-bdb8-4b27-9c4d-a882b45dd593)

VISUALIZAÇÃO DOS DADOS DA TABELA gold_franchises_summary

![image](https://github.com/user-attachments/assets/97429633-d409-4ca2-9565-a1a3868d6352)


CRIAÇÃO DA TABELA gold_franchises_financial_performance
![image](https://github.com/user-attachments/assets/57074806-9bba-40e7-9254-4359b118d44b)

VISUALIZAÇÃO DOS DADOS DA TABELA gold_franchises_financial_performance
![image](https://github.com/user-attachments/assets/412b50af-4061-4513-a86e-02f39bcc2be6)
