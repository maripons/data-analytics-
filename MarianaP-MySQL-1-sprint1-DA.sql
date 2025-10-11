

select distinct c.country, t.amount
from company c
join transaction t
on t.company_id = c.id;


-- 3.2 Lista las empresas que han realizado transacciones 
-- por un amount superior a la media de todas las transacciones.
select c.company_name
from company c
where id IN(
SELECT company_id
from transaction 
where amount > (
select avg(amount)
from transaction));   

-- 3.3 Eliminarán del sistema las empresas que carecen de transacciones registradas, entrega el listado de estas empresas.
select c.company_name
from company c
where not exists (
	select company_id
	from transaction t
	where t.company_id = c.id
	and amount > 0 or null
);


-- Identifica los cinco días que se generó la mayor cantidad de ingresos en la empresa por ventas. 
-- Muestra la fecha de cada transacción junto con el total de las ventas.
SELECT 
    DATE(t.timestamp) AS sale_date,
    c.company_name,
    SUM(t.amount) AS total_sales
FROM transaction t
JOIN company c ON c.id = t.company_id
GROUP BY sale_date, c.company_name
ORDER BY total_sales DESC
LIMIT 5;


-- Ejercicio 2
-- ¿Cuál es la media de ventas por país? Presenta los resultados ordenados de mayor a menor medio. 
SELECT 
    c.country,
    AVG(t.amount) AS average_sales
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.amount > 0
GROUP BY c.country
ORDER BY average_sales DESC;


-- Ejercicio 3
-- En tu empresa, se plantea un nuevo proyecto para lanzar algunas campañas publicitarias para hacer competencia a la compañía “Non Institute”. Para ello, te piden la lista de todas las transacciones realizadas por empresas que están ubicadas en el mismo país que esta compañía.
-- 3.1 Muestra el listado aplicando JOIN y subconsultas.

SELECT 
    t.id AS transaction_id,
    t.company_id,
    c.company_name,
    c.country,
    t.timestamp,
    t.amount
FROM transaction t
JOIN company c ON c.id = t.company_id
WHERE c.country = (
    SELECT country 
    FROM company 
    WHERE company_name = 'Non Institute'
);




-- 3.2 Muestra el listado aplicando solo subconsultas.
SELECT *
FROM transaction
WHERE company_id IN (
    SELECT id
    FROM company
    WHERE country = (
        SELECT country
        FROM company
        WHERE company_name = 'Non Institute'
    )
);


SELECT t.*,
       (SELECT country
        FROM company
        WHERE id = t.company_id
        LIMIT 1) AS country
FROM transaction t
WHERE company_id IN (
    SELECT id
    FROM company
    WHERE country = (
        SELECT country
        FROM company
        WHERE company_name = 'Non Institute'
        LIMIT 1
    )
);


-- Nivel 3
-- Ejercicio 1
-- Presenta el nombre, teléfono, país, fecha y amount, de aquellas empresas que realizaron transacciones con un valor comprendido entre 350 y 400 euros y en alguna de estas fechas: 
-- 29 de abril de 2015, 
-- 20 de julio de 2018
-- 13 de marzo de 2024. 
-- Ordena los resultados de mayor a menor cantidad.


SELECT 
    c.company_name,
    c.phone,
    c.country,
    DATE(t.timestamp) AS transaction_date,
    t.amount
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE 
    t.amount BETWEEN 350 AND 400
    AND DATE(t.timestamp) IN ('2015-04-29', '2018-07-20', '2024-03-13')
ORDER BY t.amount DESC;


-- Ejercicio 2
-- Necesitamos optimizar la asignación de los recursos y dependerá de la capacidad operativa que se requiera, 
-- por lo que te piden la información sobre la cantidad de transacciones que realizan las empresas, 
-- pero el departamento de recursos humanos es exigente y 
-- quiere un listado de las empresas en las que especifiques si tienen más de 400 transacciones o menos.


SELECT 
    c.company_name,
    COUNT(t.id) AS total_transactions,
    CASE 
        WHEN COUNT(t.id) > 400 THEN 'More than 400'
        ELSE 'Fewer than 400'
    END AS transaction_status
FROM company c
LEFT JOIN transaction t ON c.id = t.company_id
GROUP BY c.id, c.company_name
ORDER BY total_transactions DESC;


