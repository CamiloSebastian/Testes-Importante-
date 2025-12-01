CREATE DATABASE  vartestes;

USE vartestes;

CREATE TABLE pessoas (
   id_m INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100),
   idade INT 
);

INSERT INTO pessoas(nome,idade) 
VALUES 
('Elena', 18),
('Rose', 36),
('Draco', 29),
('Lucie', 18),
('Janet', 36),
('Bernad', 29),
('Klaus', 25);

# variaveis 

SET @adjet1 := 'Bonita';
SET @adjet2 := 'Forte';
SET @adjet3 := 'Esperto';
SET @adjet4 := 'Insuportável';
SET @num := 3;

# dando adjetivos as pessoas
SELECT CONCAT(nome, ' é muito ', @adjet1, '.') AS adjetivo
FROM pessoas
LIMIT 1;

SELECT CONCAT(nome, ' é bem forte ', @adjet2, '.') AS adjetivo
FROM pessoas
LIMIT 2, 1;

SELECT CONCAT(nome, ' é muito ', @adjet4, '.') AS adjetivo
FROM pessoas
LIMIT 4, 1;

# ligações entre pessoa com pessoa
SELECT CONCAT(p1.nome, ' não gosta de ', p2.nome, '.') AS frase
FROM pessoas p1
JOIN pessoas p2
WHERE p1.id_m = 4   -- pessoa X
  AND p2.id_m = 7;  -- pessoa Y
  
SELECT CONCAT(p1.nome, ' é casada com ', p2.nome, '.') AS frase
FROM pessoas p1
JOIN pessoas p2
WHERE p1.id_m = 2   -- pessoa X
  AND p2.id_m = 5;  -- pessoa Y
  
#fazendo contas
  SELECT 
       (@num * 5) AS calculo;
       
	SELECT 
       (@num * 5 + 7 - 5 + 7) AS calculo;
       
# pessoa não sabe fazer uma conta simples
SELECT CONCAT( nome,' não sabe que ', @num ,' + ', @num ,' é igual a ', (@num * 2)) AS afirmando
FROM pessoas
LIMIT 5, 1;
