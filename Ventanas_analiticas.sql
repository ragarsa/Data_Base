with temp_table as (
SELECT bank_name, card_name, amount, first_name, client.city as city_client, bank.city
FROM bank, debit_card, client
)

-- SELECT bank_name, card_name, amount,
-- 		sum(amount) over(Partition by bank_name ORDER BY card_name ASC
-- 		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- 						 )
-- 		as suma_total
		
-- SELECT first_name, amount, bank_name, temp_table.city_client,
-- 		rank() OVER (PARTITION BY first_name ORDER By amount  ROWS BETWEEN 2 PRECEDING AND current row) AS posicion, 
-- 		avg(amount) OVER (PARTITION BY first_name ORDER By amount 
-- 		ROWS BETWEEN 2 PRECEDING AND current row)  AS promedio

-- SELECT first_name, amount, bank_name, temp_table.city_client,
-- 		TOP() OVER (PARTITION BY temp_table.city_client ORDER By amount  ROWS BETWEEN 2 PRECEDING AND current row) AS posicion, 
-- 		avg(amount) OVER (PARTITION BY temp_table.city_client ORDER By amount 
-- 		ROWS BETWEEN UNBOUNDED PRECEDING AND 3 FOLLOWING)  AS promedio

-- SELECT bank_name, temp_table.city_client ,
-- 	count(bank_name) OVER (PARTITION BY temp_table.city_client order by bank_name) as conteo
-- FROM temp_table
-- WHERE bank_name = 'Banamex' and city = temp_table.city_client

SELECT bank_name, temp_table.city_client , card_name,  
		rank() OVER (partition by card_name order by bank_name) as ranking,
		count(bank_name) OVER (PARTITION BY temp_table.city_client order by bank_name) as conteo
		
FROM temp_table


