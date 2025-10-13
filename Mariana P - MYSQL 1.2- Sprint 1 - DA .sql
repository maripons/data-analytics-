-- NIVEL 1 
-- Utilizando JOIN realizarás las siguientes consultas: Lista de países que están generando ventas.

select distinct c.country
from company c
join transaction t
on t.company_id = c.id
where t.amount > 0
ORDER BY c.country asc;

 -- Identifica a la compañía con la mayor media de ventas.
select count(distinct c.country) as country_number
from company c
join transaction t
on t.company_id = c.id
where t.amount > 0;

-- Utilizando sólo subconsultas (sin utilizar JOIN): Muestra todas las transacciones realizadas por empresas de Alemania.

select c.company_name, avg(t.amount) as avg_sales
from company c
join transaction t
on t.company_id = c.id
group by c.company_name
order by avg_sales desc;

-- Ejercicio 3 - Utilizando sólo subconsultas (sin utilizar JOIN):
-- Muestra todas las transacciones realizadas por empresas de Alemania.
select * 
from transaction t
where t.company_id IN (
select id 
from company c
where country = 'Germany');

-- Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones.

select amount
from transaction t
where amount > avg 


-- CONTINUA EN EL ARCHIVO 2