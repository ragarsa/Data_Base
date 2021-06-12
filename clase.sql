******************   Coincidencia de texto

SELECT *
FROM iexe.orders
WHERE ship_country similar to 'C%';

SELECT *
FROM iexe.orders
WHERE ship_country ILIKE 'm%';

SELECT *
FROM iexe.orders
WHERE ship_country ~ '^M'


*************************** Manipulación fechas


SELECT now();

SELECT extract(year from current_date)|| '-' ||LPAD(extract(month from current_date)::CHAR,2,'0')


SELECT extract(year from current_date)::varchar


***************   CREAR SECUENCIAS

DROP SEQUENCE IF EXISTS sec_libros;

CREATE SEQUENCE iexe.sec_libros
start with 1
increment by 1
maxvalue 999999
minvalue 1; 

select *
from iexe.sec_libros;


SELECT NEXTVAL('iexe.sec_libros');

	
CREATE TABLE iexe.libros(
codigo int default nextval('iexe.sec_libros'),
titulo varchar (60),
autor varchar (50),
editorial varchar (50),
primary key(codigo)
);

INSERT INTO iexe.libros (titulo, autor, editorial)
values ('Ensayo sobre la ceguera', 'Jose Saramago','Porrua');

SELECT *
FROM iexe.libros


CREATE TABLE iexe.libros2(
codigo varchar(30) default nextval('iexe.sec_libros'),
titulo varchar (60),
autor varchar (50),
editorial varchar (50),
primary key(codigo)
);

INSERT INTO iexe.libros2 (codigo,titulo, autor, editorial)
values (CONCAT('VENT-',NEXTVAL('iexe.sec_libros')),'Ensayo sobre la ceguera', 'Jose Saramago','Porrua');


SELECT *
FROM iexe.libros2


INSERT INTO iexe.libros2 (codigo,titulo, autor, editorial)
values (CONCAT('VENT-',LPAD(CAST(NEXTVAL('iexe.sec_libros') AS VARCHAR),8,'0')),'Ensayo sobre la ceguera', 'Jose Saramago','Porrua');


***************************   WITH


WITH CTE_orders as (
SELECT *
FROM IEXE.ORDERS
WHERE ship_country = 'Mexico'
AND order_date BETWEEN DATE_TRUNC('YEAR', CURRENT_DATE) - interval '24 YEAR' AND DATE_TRUNC('YEAR', CURRENT_DATE) - interval '23 YEAR'
)
SELECT *
from CTE_orders
WHERE ship_via = '2'


SELECT *
FROM CTE_orders



SELECT DATE_TRUNC('month', CURRENT_DATE) - interval '1 month'


SELECT 2021 -1998


-------------------- Ventas o funciones analíticas

*************+ Función ventana suma

SELECT order_id, ship_country, freight, sum(freight)
OVER(
partition by ship_country
order by ship_country
)suma_pesos
from iexe.orders
WHERE ship_via = '2';

411.07

SELECT 217.86 + 17.22 + 22.57 + 38.82 + 1.27 + 63.77 + 49.56


*************************** función ventana (ranking)

SELECT ship_country, ship_via, sum(freight), rank()
over(
order by freight desc
)ranking
from iexe.orders
group by 1,ship_via, freight


*********** top 3


SELECT ship_country , ship_via, freight, top3
from (
SELECT ship_country, ship_via, sum(freight) as freight, ROW_number()
over(
partition by ship_country, ship_via
order by freight desc
)top3
from iexe.orders
group by 1,ship_via, freight
)tmp
WHERE top3 <= 3
Order by ship_country, ship_via, top3