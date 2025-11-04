-- Nivell 1
-- Descàrrega els arxius CSV

CREATE SCHEMA sprint_4;

USE sprint_4;

CREATE TABLE transactions (
id VARCHAR (100) PRIMARY KEY,
card_id VARCHAR (100),
business_id	VARCHAR (100),
timestamp VARCHAR (100),	
amount VARCHAR (100),
declined VARCHAR (100),	
product_ids	VARCHAR (100),
user_id	VARCHAR (100),
lat	VARCHAR (100),
longitude VARCHAR (100)
);

-- aquí tuve que revisar en notepad++ cuales eran las terminaciones de cada campo. Y después adaptar el comando para esa tabla.
-- NOTA: reemplazar ¨ \ ¨ por ¨ / ¨ 
-- Comando original:
LOAD DATA INFILE 'C:/mysql-files/archivo.csv'
INTO TABLE productos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Adaptación TRANSACTIONS
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';'
IGNORE 1 ROWS;

SELECT * FROM transactions;

-- ----------- PRODUCTS

CREATE TABLE products (
id VARCHAR (100) PRIMARY KEY,
product_name VARCHAR (100),
price VARCHAR (100),
colour VARCHAR (100),
weight VARCHAR (100),
warehouse_id VARCHAR (100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

SELECT * FROM products;

-- --------- european_users

CREATE TABLE european_users (
id VARCHAR (100) PRIMARY KEY,
name VARCHAR (100),
surname  VARCHAR (100),
phone VARCHAR (100),
email VARCHAR (100),
birth_date VARCHAR (100),
country VARCHAR (100),
city VARCHAR (100),
postal_code VARCHAR (100),
address  VARCHAR (100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/european_users.csv'
INTO TABLE european_users 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

SELECT * FROM european_users

-- ------------- CREDIT_CARDS

CREATE TABLE credit_cards (
id VARCHAR (100) PRIMARY KEY,
user_id VARCHAR (100),
iban VARCHAR (100),
pan VARCHAR (100),
pin VARCHAR (100),
cvv VARCHAR (100),
track1 VARCHAR (100),
track2 VARCHAR (100),
expiring_date VARCHAR (100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_cards.csv'
INTO TABLE credit_cards 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;


SELECT * FROM credit_cards;


-- --------- COMPANIES

CREATE TABLE companies (
company_id VARCHAR (100),
company_name VARCHAR (100),
phone VARCHAR (100),
email VARCHAR (100),
country VARCHAR (100),
website VARCHAR (100)
);

ALTER TABLE companies
ADD PRIMARY KEY (company_id);

SELECT company_id 
FROM companies
UPDATE PRIMARY KEY; 

Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'UPDATE PRIMARY KEY' at line 3


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/companies.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


SELECT * FROM companies;

-- ---------- AMERICAN_USERS
american_users.csv

CREATE TABLE american_users (
id VARCHAR (100) PRIMARY KEY,
name VARCHAR (100),
surname VARCHAR (100),
phone VARCHAR (100),
email VARCHAR (100),
birth_date VARCHAR (100),
country VARCHAR (100),
city VARCHAR (100),
postal_code VARCHAR (100),
address VARCHAR (100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/american_users.csv'
INTO TABLE american_users 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;


SELECT * FROM american_users;

-- -------------------------------------------------------

-- Nivel 1 - previa
-- estudiales y diseña una base de datos con un esquema de estrella que contenga, 
-- al menos 4 tablas de las que puedas realizar las siguientes consultas:

SHOW CREATE TABLE american_users;

SHOW CREATE TABLE companies;

SHOW CREATE TABLE credit_cards;

SHOW CREATE TABLE european_users;

SHOW CREATE TABLE products;
-- COMENTARIO: en la tabla 'products' hay una columna llamada 'product_ids' con varios ids en la misma fila.
-- No confundir product_id con product_ids** transactionsamerican_users 

SHOW CREATE TABLE transactions;

transactions.id - PARENT TABLE (todas las demás tablas dependen de ella)
companies.company_id PK
credit_card.id PK
products.id PK (no conecta con las demás en un primero ommento)
european_users.id PK 
american_users.id  PK

european_users.id + american_users.id (FK) -> dentro de user_id en la tabla Transactions
credit_card.id (FK) -> dentro de card_id en la tabla Transactions
company_id (FK) -> dentro de business_id en la tabla Transactions 

-- definir la FK manualmente con comandos
ALTER TABLE tabla_hija
ADD CONSTRAINT nombre_de_la_clave
FOREIGN KEY (columna_en_tabla_hija)
REFERENCES tabla_padre(columna_en_tabla_padre);

USE sprint_4;

ALTER TABLE transactions
ADD CONSTRAINT fk_business_id
FOREIGN KEY (business_id)
REFERENCES companies(company_id);

SHOW CREATE TABLE transactions;
'transactions', 'CREATE TABLE `transactions` (\n  `id` varchar(100) NOT NULL,\n  `card_id` varchar(100) DEFAULT NULL,\n  `business_id` varchar(100) DEFAULT NULL,\n  `timestamp` varchar(100) DEFAULT NULL,\n  `amount` varchar(100) DEFAULT NULL,\n  `declined` varchar(100) DEFAULT NULL,\n  `product_ids` varchar(100) DEFAULT NULL,\n  `user_id` varchar(100) DEFAULT NULL,\n  `lat` varchar(100) DEFAULT NULL,\n  `longitude` varchar(100) DEFAULT NULL,\n  PRIMARY KEY (`id`),\n  KEY `business_id` (`business_id`),\n  CONSTRAINT `fk_business_id` FOREIGN KEY (`business_id`) REFERENCES `companies` (`company_id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'

-- ------

ALTER TABLE transactions
ADD CONSTRAINT fk_card_id
FOREIGN KEY (card_id)
REFERENCES credit_cards(id);

-- -----

ALTER TABLE transactions
ADD CONSTRAINT fk_european_users
FOREIGN KEY (user_id)
REFERENCES european_users(id);

Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`sprint_4`.`#sql-1854_9`, CONSTRAINT `fk_european_users` FOREIGN KEY (`user_id`) REFERENCES `european_users` (`id`))

verificación de valores que no son compatibles:

SELECT user_id
FROM transactions
WHERE user_id IS NOT NULL
  AND user_id NOT IN (
    SELECT id FROM european_users
);

id,name,surname,phone,email,birth_date,country,city,postal_code,address
id,name,surname,phone,email,birth_date,country,city,postal_code,address

-- Crear la nueva tabla users
CREATE TABLE all_users (
    id VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(100),
    email VARCHAR(100),
    birth_date VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    postal_code VARCHAR(100),
    address VARCHAR(100),
    region VARCHAR(100) -- 'european' o 'american'
);


-- Migrar datos desde european_users

INSERT INTO all_users (id, name, surname, phone, email, birth_date, country, city, postal_code, address, region)
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address, 'european'
FROM european_users;

-- Migrar datos desde american_users

INSERT INTO all_users (id, name, surname, phone, email, birth_date, country, city, postal_code, address, region)
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address, 'european'
FROM american_users;


-- ADD FOREIGN KEY 'users'
ALTER TABLE transactions
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES all_users(id);




-- -----------------------------------------------------
-- Nivel 1
-- Exercici 1
-- Realiza una subconsulta que muestre a todos los usuarios con más de 80 transacciones utilizando al menos 2 tablas.

USE sprint_4;

-- Total de usuarios con más de 80 transaciones:
SELECT *
FROM all_users
WHERE id IN (
    SELECT user_id
    FROM transactions
    GROUP BY user_id
    HAVING COUNT(*) > 80
);

-- Numero de transaciones totales por cada uno de los 4 usuarios:

SELECT au.id, au.name, au.surname, 
    COUNT(t.id) AS total_transactions
FROM all_users au
JOIN transactions t ON au.id = t.user_id
GROUP BY au.id, au.name, au.surname
HAVING COUNT(t.id) > 80;

-- comentarios: el mismo ID de all_users puede tener muchas transaciones.



-- -------------------------------------------------
-- Nivel 1
-- Ejercicio 2
-- Muestra la media de amount por IBAN de las tarjetas de crédito en la compañía Donec Ltd., 
-- utiliza por lo menos 2 tablas.
-- TABLAS: companiescredit_cardscompanies + credit_cards + transactions

USE sprint_4; 

-- Primero confirmar el nombre de la compañia
-- NOTA: es Donec Ltd sin el punto.

SELECT company_name
FROM companies
WHERE company_name = 'Donec Ltd';


-- Aquí quiero ordenar desde la mayor media por amount 

SELECT c.company_name, cc.iban, AVG(t.amount)
FROM transactions t
JOIN credit_cards cc ON t.card_id = cc.id
 JOIN companies c ON t.business_id = c.company_id
 WHERE c.company_name = 'Donec Ltd'
GROUP BY cc.iban, company_name
ORDER BY AVG(t.amount) DESC;

-- Y aquí, ordenar desde la mayor media por el iban 
SELECT c.company_name, cc.iban, AVG(t.amount)
FROM transactions t
JOIN credit_cards cc ON t.card_id = cc.id
 JOIN companies c ON t.business_id = c.company_id
 WHERE c.company_name = 'Donec Ltd'
GROUP BY cc.iban, company_name
ORDER BY cc.iban;

-- -------------------------------------------------------------


-- Nivel 2
-- Crea una nueva tabla que refleje el estado de las tarjetas de crédito 
-- basado en si las TRES ULTIMAS transacciones han sido: 
-- declinadas = 1 = INACTIVO 
-- declinadas = 0 =  ACTIVO

-- PASO 1: Crear la nueva tabla con los datos que me van a ayudar a identificar el estado de las tarjetas

CREATE TABLE IF NOT EXISTS card_status (
    card_id VARCHAR(50) PRIMARY KEY,
    status VARCHAR(50),
    declined VARCHAR (2)
);

-- PASO 2: Insertar datos de la columna id de la tabla 'credit_card' en la columna card_id de la tabla 'card_status':

INSERT INTO card_status (card_id)
SELECT id FROM credit_cards;


-- PASO 3: Actualizar la tabla card_status cs con datos de las columnas de transaction t con subconsultas para definir y agrupar los datos 'declined' de las 3 ultimas fechas:

UPDATE card_status cs
JOIN (
    SELECT t.card_id,
           CASE 
               WHEN SUM(t.declined) = 3 THEN 'Inactiva'
               ELSE 'Activa'
           END AS new_status
    FROM transactions t
    WHERE (
        SELECT COUNT(*) 
        FROM transactions tp2
        WHERE tp2.card_id = t.card_id
          AND tp2.timestamp > t.timestamp
    ) < 3  
    GROUP BY t.card_id
    ) AS last_3_dates 
ON cs.card_id = last_3_dates.card_id
SET cs.status = last_3_dates.new_status
WHERE cs.card_id != '';

SELECT * FROM card_status;


-- PASO 4: Crear una FOREIGN KEY para relacionar la tabla 'transactions' con la tabla 'card_status'

ALTER TABLE transactions 
ADD CONSTRAINT cs_transactions
FOREIGN KEY (card_id)
REFERENCES card_status(card_id);


-- Partiendo de esta tabla responde:
-- Ejercicio 1
-- ¿Cuántas tarjetas están activas?

SELECT COUNT(*)
FROM card_status
WHERE status = 'Activa';

-- ------------------------------------------------------------
-- Nivel 3
-- Crea una tabla con la que podamos unir los datos del nuevo archivo products.csv con la base de datos creada, 
-- teniendo en cuenta que desde transaction tienes product_ids. 
-- Genera la siguiente consulta:
-- Ejercicio 1
-- Necesitamos conocer el número de veces que se ha vendido cada producto.

-- PASO 1: Crear la tabla y insertar la base de datos csv.
-- **ya la había reado en NIVEL 1

-- PASO 2: Crear una ‘Tabla de Puente’ por ser el caso de una relación entre tablas de muchos a muchos.

SELECT product_ids FROM transactions;


CREATE TABLE IF NOT EXISTS each_product_transactions (
    transaction_id VARCHAR(100), 
    product_id VARCHAR(100),
    PRIMARY KEY (transaction_id, product_id)
    );
    
    
-- PASO 4: Para separar cada producto de cada fila en diferentes columnas, se necesita utilizar JSON:

INSERT INTO each_product_transactions (transaction_id, product_id)
SELECT t.id, CAST(j.value AS UNSIGNED) AS product_id 
FROM transactions t
JOIN JSON_TABLE(
    CONCAT(
        '["', 
        REPLACE(t.product_ids, ',', '","'),
        '"]'
    ),
    '$[*]' COLUMNS (value VARCHAR(50) PATH '$')
) AS j;

        
SELECT * FROM each_product_transactions;
   
-- PASO 4: relacionar la base de datos de la tablas each_product_transactions con las tabla products y transactions:

ALTER TABLE each_product_transactions
ADD CONSTRAINT ept_product
FOREIGN KEY (product_id)
REFERENCES products(id);

ALTER TABLE each_product_transactions
ADD CONSTRAINT ept_transactions
FOREIGN KEY (transaction_id)
REFERENCES transactions(id);

-- PASO 5: Ejercicio 1
-- Necesitamos conocer el número de veces que se ha vendido cada producto.
  
SELECT product_id, COUNT(*) AS sales_number
FROM each_product_transactions
GROUP BY product_id
ORDER BY sales_number DESC;
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



