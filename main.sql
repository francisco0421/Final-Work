-- 1 - Criar UML sobre qualquer tema de teu interesse. Deve conter no mínimo 7 tabelas.
 
-- 2 - Gerar conteúdo de dados .csv ou .json ou .txt referentes às sete tabelas do enunciado anterior. Os dados podem ser sintéticos e devem conter ao menos 15 linhas cada. 
 
-- 3 - Criar schema próprio para o presente trabalho.
 
-- 4 - Criar no MySQL as tabelas que receberão os dados, portanto, mostrar código de criação de cada uma das tabela. 
 
-- 5 - Especificar as chaves primárias e estrangeiras e escolher por um tipo de delete (cascade, set null ou no action). Justificar a escolha na documentação.
 
-- 6 - Trazer cinco consultas com join.
 
-- 7 - Trazer cinco consultas com order by.
 
-- 8 - Trazer cinco consultas com group by.
 
-- 9 - Trazer três consultas que combinem join e order by (sem repetir as anteriores).
 
-- 10 - Trazer sete consultas que contemplem funções matemáticas (e.g. AVG, SUM...)
 
-- 11 - Criar cinco visões.
 
-- 12 - Criar cinco savepoints.
 
-- 13 - Criar três usuários distintos sendo que um deles só poderá ter acesso às views, um só poderá inserir dados sem ver e o outro apenas poderá ver sem nenhuma outra ação.

CREATE SCHEMA final_work;
USE FINAL_WORK;

CREATE TABLE CAR_DEALERSHIP (
DEALERSHIP_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
DEALERSHIP_NAME VARCHAR(50) NOT NULL,
LOCATION VARCHAR(50),
FOREIGN KEY (HOLDER_FIRST_NAME) REFERENCES HOLDER(FIRST_NAME),
CARS VARCHAR(50));

SELECT * FROM CAR_DEALERSHIP;

CREATE TABLE HOLDER (
HOLDER_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL
);

SELECT * FROM HOLDER;

CREATE TABLE CARS (
CAR_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
RELEASE_YEAR INT NOT NULL,
CAR_BRAND VARCHAR(50) NOT NULL,
CAR_MODEL VARCHAR(50) NOT NULL,
CAR_TYPE VARCHAR(50) NOT NULL
);

SELECT * FROM CARS;

CREATE TABLE CAR_INFO (
CAR_INFO_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CAR_ID INT NOT NULL,
SERIAL_NUMBER INT NOT NULL,
ENGINE_TYPE VARCHAR(50) NOT NULL
);

SELECT * FROM CAR_INFO;

CREATE TABLE LOCATION (
LOCATION_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
CITY VARCHAR(50) NOT NULL,
STATE VARCHAR(50) NOT NULL,
COUNTY VARCHAR(50) NOT NULL
);

SELECT * FROM LOCATION;

CREATE TABLE CUSTOMERS (
CUSTOMER_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL
);

SELECT * FROM CUSTOMERS;

CREATE TABLE CUSTOMER_INFO (
CUSTOMER_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
BIRTH_DATE VARCHAR(50) NOT NULL,
AGE INT NOT NULL
);

SELECT * FROM CUSTOMER_INFO;

-- FALTA FAZER O UPLOAD DAS TABELAS COM O IMPORT WIZARD! (VERIFICAR SE ESTÁ TUDO CERTO PRIMEIRO!)

-- 5)
DELETE FROM CUSTOMERS
WHERE CUSTOMER_ID = 2;
-- Esse tipo de delete foi escolhido por causa da praticidade e por ser fácil de entender.

-- 6)
SELECT LOCATION.CITY, CAR_DEALERSHIP.LOCATION
FROM LOCATION
LEFT OUTER JOIN CAR_DEALERSHIP ON LOCATION.CITY = CAR_DEALERSHIP.LOCATION
WHERE LOCATION.CITY = 'Los Angeles' ;

SELECT CUSTOMERS.FIRST_NAME, CUSTOMER_INFO.FIRST_NAME
FROM CUSTOMERS
RIGHT OUTER JOIN CUSTOMER_INFO ON CUSTOMERS.FIRST_NAME = CUSTOMER_INFO.FIRST_NAME
WHERE CUSTOMERS.FIRST_NAME = 'Annie' ;

-- MUDAR O JOIN OU A TABELA DO SELECT ABAIXO
SELECT HOLDER.FIRST_NAME, CAR_DEALERSHIP.DEALERSHIP_NAME
FROM HOLDER
LEFT JOIN CAR_DEALERSHIP ON HOLDER.HOLDER_ID = CAR_DEALERSHIP.DEALERSHIP_ID; 

SELECT CAR_DEALERSHIP.CARS, CARS.CAR_MODEL
FROM CAR_DEALERSHIP
INNER JOIN CARS ON CAR_DEALERSHIP.CARS = CARS.CAR_MODEL
WHERE CARS.CAR_MODEL = 'Civic';

SELECT CARS.CAR_ID, CAR_INFO.CAR_ID
FROM CARS
CROSS JOIN CAR_INFO ON CARS.CAR_ID = CAR_INFO.CAR_ID
WHERE CARS.CAR_ID = 2;

-- 7)
SELECT * FROM CAR_DEALERSHIP
ORDER BY CARS;

SELECT STATE FROM LOCATION
ORDER BY CITY;

SELECT * FROM CARS
ORDER BY CAR_BRAND DESC;

SELECT * FROM CAR_INFO
ORDER BY ENGINE_TYPE;

SELECT * FROM HOLDER
ORDER BY LAST_NAME DESC;

-- 8)
SELECT FIRST_NAME, LAST_NAME
FROM Customers
GROUP BY LAST_NAME;

SELECT LAST_NAME
FROM Customer_INFO
GROUP BY AGE;

SELECT FIRST_NAME
FROM HOLDER
GROUP BY LAST_NAME;

SELECT CAR_MODEL
FROM CARS
GROUP BY RELEASE_YEAR;

SELECT CITY
FROM LOCATION
GROUP BY STATE;

-- 9)
SELECT CAR_DEALERSHIP.HOLDER_FIRST_NAME, HOLDER.FIRST_NAME
FROM CAR_DEALERSHIP
LEFT OUTER JOIN HOLDER ON CAR_DEALERSHIP.HOLDER_FIRST_NAME = HOLDER.FIRST_NAME
WHERE CAR_DEALERSHIP.HOLDER_FIRST_NAME = 'Frank'
ORDER BY CAR_DEALERSHIP.HOLDER_FIRST_NAME ;

SELECT CUSTOMERS.LAST_NAME, HOLDER.LAST_NAME
FROM CUSTOMERS
RIGHT OUTER JOIN HOLDER ON CUSTOMERS.LAST_NAME = HOLDER.LAST_NAME
WHERE CUSTOMERS.LAST_NAME = 'Williams'
ORDER BY CUSTOMERS.LAST_NAME ;

SELECT LOCATION.LOCATION_ID, CAR_DEALERSHIP.DEALERSHIP_ID
FROM LOCATION
INNER JOIN CAR_DEALERSHIP ON LOCATION.LOCATION_ID = CAR_DEALERSHIP.DEALERSHIP_ID
WHERE LOCATION.LOCATION_ID = 6
ORDER BY LOCATION.LOCATION_ID ;

SELECT * FROM LOCATION;
SELECT * FROM CUSTOMER_INFO;

-- 10)
SELECT SUM(RELEASE_YEAR) AS SUM
FROM CARS;

SELECT MIN(CAR_ID) AS MIN
FROM CARS;

SELECT MAX(DEALERSHIP_ID) AS MAX
FROM CAR_DEALERSHIP;

SELECT AVG(CAR_INFO_ID) AS AVERAGE
FROM CAR_INFO;

SELECT SUM(CUSTOMER_ID) AS SUM
FROM CUSTOMERS;

SELECT MIN(HOLDER_ID) AS MIN
FROM HOLDER;

SELECT MAX(DEALERSHIP_ID) AS MAX
FROM CAR_DEALERSHIP;

-- 11)

CREATE VIEW VIEW_CARS
AS SELECT * FROM CARS;

CREATE VIEW VIEW_CUSTOMERS
AS SELECT * FROM CUSTOMERS;

CREATE VIEW VIEW_HOLDER
AS SELECT * FROM HOLDER;

CREATE VIEW VIEW_LOCATION
AS SELECT * FROM LOCATION;

CREATE VIEW VIEW_CAR_DEALERSHIP
AS SELECT * FROM CAR_DEALERSHIP;

-- 12)

START TRANSACTION;
INSERT INTO CARS VALUES(16, 1986, "Ford", "C10","Sedan");
SAVEPOINT SAVEPOINT1;

INSERT INTO CUSTOMERS VALUES(17, "Charlie", "Gibson");
SAVEPOINT SAVEPOINT2;

INSERT INTO LOCATION VALUES(23, "Salt Lake City", "Utah", "Brown");
SAVEPOINT SAVEPOINT3;

INSERT INTO HOLDER VALUES(19, "Bob", "Jones");
SAVEPOINT SAVEPOINT4;

INSERT INTO CUSTOMER_INFO VALUES(18, "Jason", "Statham", "07/08/1970", 52);
SAVEPOINT SAVEPOINT5;

-- 13)

CREATE USER USER1@LOCALHOST
IDENTIFIED BY '12345';

CREATE USER USER2@LOCALHOST
IDENTIFIED BY '67325';

CREATE USER USER3@LOCALHOST
IDENTIFIED BY '54321';

GRANT ALL ON CAR_DEALERSHIP.* TO 'USER1'@'LOCALHOST';

GRANT INSERT ON CUSTOMERS.* TO 'USER2'@'LOCALHOST';

GRANT SELECT ON LOCATION.* TO 'USER3'@'LOCALHOST';