-- CREAR SECUENCIAS 

-- CREATE SEQUENCE sec_libros
-- start with 1 
-- increment by 1 
-- maxvalue 999999
-- minvalue 1 

-- select * from sec_libros

-- SELECT NEXTVAL('sec_libros');

create table libros (
codigo INT DEFAULT nextval('sec_libros'),
titulo VARCHAR(60),
autor VARCHAR(50),
editorial VARCHAR(50),
PRIMARY KEY(codigo)
);

insert into libros(titulo, autor, editorial) 
values ('Oda A La Alegría', 'Wagner', 'PressEurope');


select * 
from libros

create table libros2 (
codigo VARCHAR(30) DEFAULT nextval('sec_libros'),
titulo VARCHAR(60),
autor VARCHAR(50),
editorial VARCHAR(50),
PRIMARY KEY(codigo)
);

insert into libros2(codigo, titulo, autor, editorial) 
values (CONCAT('VENT-', NEXTVAL('sec_libros')),'Oda A La Alegría', 'Wagner', 'PressEurope');

insert into libros2(codigo, titulo, autor, editorial) 
values (CONCAT('VENT-', LPAD(CAST(NEXTVAL('sec_libros') AS VARCHAR),8,'0')),'Un Paseo Por La Ciudad', 'Wagner', 'PressEurope');


select * 
from libros2



******* WITH 
-- REUTILIZA CODIGO CON OTROS SCRIPTS ESTA FUNCION BUSCA TODO LO DE UN AÑO, SE CREA UNA TABLA TEMPORAL
with cte_orders as (
SELECT * 
	FROM orders 
	WHERE ship_country = 'Mexico'
	AND order_date BETWEEN date_trunc('YEAR', current_date) - INTERVAL '24 YEAR' 
	AND date_trunc('YEAR', current_date) - INTERVAL '23 YEAR'
)
--Funcion con with 
SELECT *
FROM cte_orders 
WHERE ship_via = '2'

-- select date_trunc('month', current_date) - INTERVAL ' 1 month' as fecha_modificada
-- select date_trunc('week', current_date) - INTERVAL ' 1 week' as fecha_modificada

-- SELECT 2021 - 1998

--VENTAS O FUNCIONES ANALÍTICAS 

************************* FUNCION VENTANA SUMA 

SELECT DISTINCT order_id, ship_country, freight, sum(freight)
OVER(
partition by ship_country
order by ship_country
) suma_pesos
from orders 
WHERE ship_via = '2'


************************Funcion VENTANA (RANKING)
SELECT ship_country, ship_via, sum(freight), rank()
over(
order by freight desc
) ranking 
from orders
group by ship_country, ship_via freight

SELECT ship_country, ship_via, sum(freight), rank()
over(
order by freight desc
) ranking 
from orders
group by 1, 2, freight


**************TOP 

SELECT ship_country, ship_via, freight, top3
FROM (
SELECT ship_country, ship_via, sum(freight) as freight, ROW_NUMBER()
over(
partition by ship_country, ship_via
order by freight desc
) top3 
from orders
group by 1, 2, freight
)tmp 
WHERE top3 <= 3
ORDER BY ship_country, ship_via, top3


