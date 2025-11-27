CREATE DATABASE ppot;

USE ppot;

CREATE TABLE Jogador (
   id_jogador INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   idade INT NOT NULL,
   vitorias INT DEFAULT 0,
   empates INT DEFAULT 0,
   derrotas INT DEFAULT 0
);
CREATE TABLE Partida (
   id_partida INT PRIMARY KEY AUTO_INCREMENT,
   jogador1 VARCHAR(100) NOT NULL,
   result1 ENUM('Pedra','Papel','Tesoura'),
   vs ENUM('x'),
   result2 ENUM('Pedra','Papel','Tesoura'),
   jogador2 VARCHAR(100) NOT NULL
);

SELECT * FROM Jogador;


# GATILHO ONDE FAZ O PEDRA,PAPEL OU TESOURA FUNCIONAR
DELIMITER $$
CREATE TRIGGER PPT
AFTER INSERT ON Partida
FOR EACH ROW
BEGIN
	# setando os empates
    IF NEW.result1 = 'Pedra' AND NEW.result2 = 'Pedra' THEN
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Papel' AND NEW.result2 = 'Papel' THEN
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Tesoura' AND NEW.result2 = 'Tesoura' THEN
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET empates = empates + 1 WHERE nome = NEW.jogador2;
    # setando as vitorias e derrotas
    ELSEIF NEW.result1 = 'Papel' AND NEW.result2 = 'Pedra' THEN
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Pedra' AND NEW.result2 = 'Papel' THEN
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Pedra' AND NEW.result2 = 'Tesoura' THEN
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Tesoura' AND NEW.result2 = 'Pedra' THEN
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Tesoura' AND NEW.result2 = 'Papel' THEN
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador2;
    
    ELSEIF NEW.result1 = 'Papel' AND NEW.result2 = 'Tesoura' THEN
        UPDATE Jogador SET derrotas = derrotas + 1 WHERE nome = NEW.jogador1;
        UPDATE Jogador SET vitorias = vitorias + 1 WHERE nome = NEW.jogador2;
    END IF;
END $$
DELIMITER ;

SELECT * FROM Jogador;

INSERT Jogador(nome,idade)
VALUES 
('Joe', 19),
('Shadow', 33),
('Gregory', 30),
('Adam',40),
('Rosaline', 24),
('Peach', 28),
('Daisy', 29),
('Eve',22);

SELECT * FROM Partida;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

#TESTANDO O GATILHO DO PEDRA PAPEL OU TESOURA, coloquei cada um para ter 3 partidas, para testar
-- Partidas dos jogadores: Joe, Rosaline, Shadow, Peach
INSERT INTO Partida (jogador1, result1, vs, result2, jogador2) VALUES
('Joe', 'Pedra', 'X', 'Tesoura', 'Shadow'),  
('Joe', 'Papel', 'X', 'Pedra', 'Peach'),   
('Joe', 'Tesoura', 'X', 'Papel', 'Rosaline'), 
('Rosaline', 'Tesoura', 'X', 'Papel', 'Peach'),  
('Rosaline', 'Pedra', 'X', 'Tesoura', 'Shadow'),  
('Shadow', 'Papel', 'X', 'Tesoura', 'Peach');  

-- Partidas dos jogadores: Gregory, Daisy, Adam e Eve
INSERT INTO Partida (jogador1, result1, vs, result2, jogador2) VALUES
('Gregory', 'Pedra', 'X', 'Tesoura', 'Adam'), 
('Gregory', 'Tesoura', 'X', 'Pedra', 'Eve'),  
('Gregory', 'Papel', 'X', 'Pedra', 'Daisy'),  
('Daisy', 'Tesoura', 'X', 'Pedra', 'Adam'),  
('Daisy', 'Pedra', 'X', 'Papel', 'Eve'),  
('Adam', 'Pedra', 'X', 'Tesoura', 'Eve');  

# FIM DOS TESTES

SELECT * FROM Jogador;

# criando uma view para vê quem tem mais vitorias
CREATE VIEW rank_jogadores AS 
SELECT 
    nome,
    vitorias,
    empates,
    derrotas
FROM Jogador
ORDER BY vitorias DESC;

SELECT * FROM rank_jogadores;









