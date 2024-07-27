-- Criar Database
CREATE DATABASE IF NOT EXISTS marvel_movies_db;

-- Selecionar database
USE marvel_movies_db;

-- Camada Bronze
-- Criar tabela bronze_marvel_movies
CREATE TABLE IF NOT EXISTS bronze_marvel_movies (
    movie_title VARCHAR (255), 
    mcu_phase INT,
    release_date VARCHAR(10),
    tomato_meter INT,
    audience_score INT,
    movie_duration INT,
    production_budget VARCHAR(20),
    opening_weekend VARCHAR(20),
    domestic_box_office VARCHAR(20),
    worldwide_box_office VARCHAR(20)
);

-- Importar arquivo CSV para a tabela
LOAD DATA INFILE 'C:/Users/Bruno/Desktop/projeto_eng_dados/marvel/mcu_box_office.csv'
INTO TABLE bronze_marvel_movies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(movie_title, mcu_phase, release_date, tomato_meter, audience_score, movie_duration, production_budget, opening_weekend, domestic_box_office, worldwide_box_office);

SELECT * FROM bronze_marvel_movies;

-- Camada silver
-- Criar tabela silver_marvel_movies 
CREATE TABLE IF NOT EXISTS silver_marvel_movies (
    movie_title VARCHAR (255), 
    mcu_phase INT,
    release_date DATE,
    tomato_meter INT,
    audience_score INT,
    movie_duration INT,
    production_budget DECIMAL(20,2),
    opening_weekend DECIMAL(20,2),
    domestic_box_office DECIMAL(20,2),
    worldwide_box_office DECIMAL(20,2)
);

-- Inserir dados na tabela silver_marvel_movies
INSERT INTO silver_marvel_movies
SELECT 
    movie_title,
    mcu_phase,
    STR_TO_DATE(release_date, '%m/%d/%Y') AS release_date,
    tomato_meter,
    audience_score,
    movie_duration,
    REPLACE(REPLACE(production_budget,'"',''),',','') + 0 AS production_budget,
    REPLACE(REPLACE(opening_weekend,'"',''),',','') + 0 AS opening_weekend,
    REPLACE(REPLACE(domestic_box_office,'"',''),',','') + 0 AS domestic_box_office,
    REPLACE(REPLACE(worldwide_box_office,'"',''),',','') + 0 AS worldwide_box_office
FROM bronze_marvel_movies;

SELECT * FROM silver_marvel_movies;

-- Criar tabela silver_franchise_mapping
CREATE TABLE silver_franchise_mapping 
SELECT 
    movie_title,
    CASE
        WHEN movie_title LIKE '%iron%' THEN 'Iron Man'
        WHEN movie_title LIKE '%hulk%' THEN 'Hulk'
        WHEN movie_title LIKE '%thor%' THEN 'Thor'
        WHEN movie_title LIKE '%america%' THEN 'Captain América'
        WHEN movie_title LIKE '%avengers%' THEN 'Avengers'
        WHEN movie_title LIKE '%guardians%' THEN 'Guardians of the Galaxy'
        WHEN movie_title LIKE '%ant-man%' THEN 'Ant-Man'
        WHEN movie_title LIKE '%strange%' THEN 'Doctor Strange'
        WHEN movie_title LIKE '%spider%' THEN 'Spider-Man'
        WHEN movie_title LIKE '%panther%' THEN 'Black Panther'
        WHEN movie_title LIKE '%marvel%' THEN 'Captain Marvel'
        WHEN movie_title LIKE '%widow%' THEN 'Black Widow'
        WHEN movie_title LIKE '%shang%' THEN 'Shang-Chi'
        WHEN movie_title LIKE '%eternals%' THEN 'Eternals'
        ELSE 'Unknow'
    END AS 'franchise_name'
FROM silver_marvel_movies
GROUP BY movie_title
ORDER BY franchise_name;

SELECT * from silver_franchise_mapping;

-- Camada Gold
-- Criar tabela gold_movie_summary

CREATE TABLE gold_movies_summary
SELECT 
    release_date,
    mcu_phase,
    movie_title,
    tomato_meter,
    audience_score
FROM silver_marvel_movies;

SELECT * FROM gold_movies_summary;

-- Criar tabela gold_movie_financial_performance
CREATE TABLE gold_movies_financial_performance
SELECT 
    release_date,
    mcu_phase,
    movie_title,
    CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED) AS production_budget,
    CAST(REPLACE(REPLACE(opening_weekend,'"',''),',','') AS UNSIGNED) AS opening_weekend,
    CAST(REPLACE(REPLACE(domestic_box_office, '"',''),',','') AS UNSIGNED) AS domestic_box_office,
    CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED) AS worldwide_box_office,
    CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED) - CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED) AS total_profit
FROM silver_marvel_movies;

SELECT * FROM gold_movies_financial_performance;

-- Criar tabela gold_franchises_summary
CREATE TABLE gold_franchises_summary
SELECT 
    f.franchise_name,
    count(*) as total_movies,
    ROUND(AVG(m.tomato_meter),2) AS AVG_tomato_meter,
    ROUND(AVG(m.audience_score),2) AS AVG_audience_score
FROM silver_franchise_mapping AS f
JOIN silver_marvel_movies AS m
ON f.movie_title = m.movie_title
GROUP BY franchise_name
ORDER BY AVG_tomato_meter DESC, AVG_audience_score DESC;

SELECT * FROM gold_franchises_summary;

-- Criar tabela gold_franchises_financial_performance
CREATE TABLE gold_franchises_financial_performance
SELECT
    f.franchise_name,
    count(*) AS total_movies,
    SUM(CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED) - CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED)) AS total_profit,
    ROUND(AVG(CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED) - CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED)),2) AS AVG_profit,
    SUM(CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED)) AS total_production_budget,
    SUM(CAST(REPLACE(REPLACE(opening_weekend,'"',''),',','') AS UNSIGNED)) AS total_opening_weekend,
    SUM(CAST(REPLACE(REPLACE(domestic_box_office, '"',''),',','') AS UNSIGNED)) AS total_domestic_box_office,
    SUM(CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED)) AS total_worldwide_box_office,
    ROUND(AVG(CAST(REPLACE(REPLACE(production_budget,'"',''),',','') AS UNSIGNED)),2) AS AVG_production_budget,
    ROUND(AVG(CAST(REPLACE(REPLACE(opening_weekend,'"',''),',','') AS UNSIGNED)),2) AS AVG_opening_weekend,
    ROUND(AVG(CAST(REPLACE(REPLACE(domestic_box_office, '"',''),',','') AS UNSIGNED)),2) AS AVG_domestic_box_office,
    ROUND(AVG(CAST(REPLACE(REPLACE(worldwide_box_office,'"',''),',','') AS UNSIGNED)),2) AS AVG_worldwide_box_office

FROM silver_franchise_mapping AS f
JOIN silver_marvel_movies AS m
ON f.movie_title = m.movie_title
GROUP BY franchise_name
ORDER BY total_profit DESC, AVG_profit DESC;

SELECT * FROM gold_franchises_financial_performance;