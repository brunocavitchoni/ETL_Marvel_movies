<h1>Projeto de ETL (Extração, Transformação e Carregamento de dados), com banco de dados em formato CSV, referente aos filmes da Marvel Cinematic Universe, disponibilizado pela plataforma Kaggle.</h1>

<h2>Utilizei este tema para treinamento do processo de ingestão de dados de ponta a ponta, utilizando apenas SQL.</h2>

![Diagrama sem nome drawio](https://github.com/user-attachments/assets/35b46806-be26-42ea-b556-b9f63587bcb4)

<h3>Criação de ETL utilizando a Arquitetura Medallion:</h3>

-----------------------------------------------------------------


<h1>CAMADA BRONZE</h1>

<h2>Armazenamento de dados brutos, sem transformação</h2>

![image](https://github.com/user-attachments/assets/a7126d59-04e7-4457-8531-779404c0896e)

![image](https://github.com/user-attachments/assets/d3270f88-d311-487f-b37c-06dc706f8a32)

<h2>VISUALIZAÇÃO DE DADOS DA TABELA bronze_marvel_movies:</h2>

![image](https://github.com/user-attachments/assets/50ee5fb0-a2e1-4bf3-961a-f7aacc5c3b93)

<h6>Utilizei apenas as 10 primeiras linhas, para facilitar a visualização dos dados neste arquivo.</h6>
<h3>Conteúdo das colunas</h3>
<p>movie_title: Nome do filme</p>
<p>mcu_phase: Fase do filme dentro do MCU</p>
<p>release_date: Data de lançamento</p>
<p>tomato_meter: Nota dos críticos no Rotten Tomatoes</p>
<p>audience_score: Nota do público geral</p>
<p>movie_duration: Duração do filme em minutos</p>
<p>production_budget: Gastos com a produção do filme em US$</p>
<p>opening_weekend: Arrecadação da bilheteria no primeiro final de semana após a estreia</p>
<p>domestic_box_office: Arrecadação da bilheteria nos Estados Unidos</p>
<p>worldwide_box_office: Arrecadação da bilheteria em todo o mundo, incluindo Estados Unidos</p>

-----------------------------------------------------------------

<h1>CAMADA SILVER</h1>

<h2>Primeira transformação dos dados, modificando os tipo das colunas release_date, production_budget, opening_weekend, domestic_box_office e worldwide_box_office:</h2>

![image](https://github.com/user-attachments/assets/7fd2e40f-620e-4240-b13c-6ac59d478dd0)

<h3>Modificações realizadas:</h3>

<p>Modificação de release_date de varchar para DATE</p>
<p>Modificação de production_budget de varchar para DECIMAL, com até 20 digitos, e com 2 digitos decimais</p>
<p>Modificação de opening_weeked de varchar para DECIMAL, com até 20 digitos, e com 2 digitos decimais</p>
<p>Modificação de domestic_box_office de varchar para DECIMAL, com até 20 digitos, e com 2 digitos decimais</p>
<p>Modificação de worldwide_box_office de varchar para DECIMAL, com até 20 digitos, e com 2 digitos decimais</p>

<h2>VISUALIZAÇÃO DE DADOS DA TABELA silver_marvel_movies:</h2>

![image](https://github.com/user-attachments/assets/cb78e36e-2469-45a8-92a2-d561d50d2b74)

<h2>Criação de tabela com a divisão de franquias</h2>

![image](https://github.com/user-attachments/assets/b4a0e9db-53f7-47a3-a01f-d0623d1be163)

<h2>VISUALIZAÇÃO DE DADOS DA TABELA silver_franchise_mapping:</h2>

![image](https://github.com/user-attachments/assets/4727e6ab-299d-4960-b2f5-dedfdee068b8)

<p>O MCU pode ser dividido por franquias. O que eu fiz aqui foi adicionar cada filme a uma franquia em específico</p>
-----------------------------------------------------------------

<h1>CAMADA GOLD</h1>

<h3>Transformação final dos dados, criando tabelas úteis para análises posteriores. Criei tabelas para análises qualitativas (gold_movies_summary e gold_franchises_summary), referente às notas que cada filme e franquia receberam pela audience e pela crítica no site Rotten Tomatoes, e tabelas para análise quantitativa (gold_movies_financial_performance e gold_franchises_financial_performance), referente aos valores arrecadados por filme e por franquia</h3>

<h2>CRIAÇÃO DA TABELA gold_movies_summary</h2>

![image](https://github.com/user-attachments/assets/34c468fe-b1ed-4bd9-82a7-f833da950f17)

<p>Esta tabela tem por objetivo a visualização dos dados referentes as notas da crítica e da audiência para cada filme, ordenadas pela maior nota da crítica, em ordem decrescente</p>

<h2>VISUALIZAÇÃO DOS DADOS DA TABELA gold_movies_summary</h2>

![image](https://github.com/user-attachments/assets/5bb91450-8a21-4a54-b59a-1c2f1082b75e)

<h2>CRIAÇÃO DA TABELA gold_movies_financial_performance</h2>

![image](https://github.com/user-attachments/assets/92c09560-7e44-445f-8103-20166749264c)

<p>Esta tabela tem por objetivo a visualização dos dados referentes a arrecadação financeira para cada filme, ordenadas pelo lucro total, em ordem decrescente</p>

<h2>VISUALIZAÇÃO DOS DADOS DA TABELA gold_movies_financial_performance</h2>

![image](https://github.com/user-attachments/assets/9ec947d4-c2b0-4777-a6cd-f1d594873221)

<h2>CRIAÇÃO DA TABELA gold_franchises_summary</h2>

![image](https://github.com/user-attachments/assets/398b363e-cc1a-4899-b350-fdcf2006e71f)

<p>Esta tabela tem por objetivo a visualização dos dados referentes as notas da crítica e da audiência para cada franquia, ordenadas pela maior nota da crítica, em ordem decrescente</p>

<h2>VISUALIZAÇÃO DOS DADOS DA TABELA gold_franchises_summary</h2>

![image](https://github.com/user-attachments/assets/97429633-d409-4ca2-9565-a1a3868d6352)


<h2>CRIAÇÃO DA TABELA gold_franchises_financial_performance </h2>
  
![image](https://github.com/user-attachments/assets/ae767a10-3a18-49ab-b5ef-3c1437cd9eb3)

<p>Esta tabela tem por objetivo a visualização dos dados referentes a arrecadação financeira para cada franquia, ordenadas pelo lucro total, em ordem decrescente</p>

<h2>VISUALIZAÇÃO DOS DADOS DA TABELA gold_franchises_financial_performance</h2>
  
![image](https://github.com/user-attachments/assets/c71807f0-4805-4aee-a453-443a6978239f)

