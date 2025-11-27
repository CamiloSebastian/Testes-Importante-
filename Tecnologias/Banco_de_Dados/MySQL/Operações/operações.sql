CREATE DATABASE contas;

USE contas;

CREATE TABLE calculos (
   id INT PRIMARY KEY AUTO_INCREMENT,
   num1 INT NOT NULL,
   operacao ENUM ('+', '-','/','*') NOT NULL,
   num2 INT NOT NULL,
   resultado DECIMAL (10,2)
);

DELIMITER $$

#CRIANDO O GATILHO QUE VAI FAZER AS OPERAÇÕES FUNCIONAREM
CREATE TRIGGER opera
BEFORE INSERT ON calculos
FOR EACH ROW 
BEGIN
    IF NEW.operacao = '+' THEN
        SET NEW.resultado = NEW.num1 + NEW.num2;

    ELSEIF NEW.operacao = '-' THEN
        SET NEW.resultado = NEW.num1 - NEW.num2;

    ELSEIF NEW.operacao = '*' THEN
        SET NEW.resultado = NEW.num1 * NEW.num2;

    ELSE
        SET NEW.resultado = NEW.num1 / NEW.num2;
    END IF;
END $$

DELIMITER ;


SELECT * FROM calculos;

#TESTANDO SE TA FUNCIONANDO
INSERT INTO calculos (num1, operacao, num2)
VALUES 
(1, '+', 2);

INSERT INTO calculos (num1, operacao, num2)
VALUES 
(2, '-', 2),
(1, '*', 5),
(8, '/', 2),
(10, '+', 100),
(20, '*', 5);