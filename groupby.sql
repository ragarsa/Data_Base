SELECT bank_name 
FROM bank 
WHERE bank.city = 'Puebla'
group by bank_name

SELECT city, bank_name
FROM bank 
WHERE bank_name like 'Ban%'
group by city, bank_name

SELECT first_name, last_name, bank_name
FROM client, bank 
WHERE bank.id = 1
GROUP BY first_name, last_name, bank_name

SELECT bank_name, count(bank_code) total_banco
FROM client,bank
WHERE bank_name = 'Bancomer'
GROUP BY bank_name

SELECT DISTINCT card_name, sum(amount)
FROM debit_card dc
WHERE amount > 5000
GROUP BY card_name

SELECT DISTINCT bank.bank_name, sum(amount)
FROM debit_card, client, bank
WHERE client.bank_code = bank.id 
GROUP BY bank.bank_name

SELECT ' El cliente ' ||  client.id || ' con nombre ' || first_name, last_name || ' tiene la cantidad de ' || amount || ' en su banco ' || bank_name  
FROM client, bank, debit_card
WHERE  client.id = debit_card.id_client
GROUP BY client.id, bank_name, amount
 

SELECT first_name, AVG(EXTRACT(year from aperture_date))
FROM client
WHERE city <> 'Tijuana'
GROUP BY first_name
HAVING count(*) = 2

SELECT card_name, outdate
FROM debit_card
WHERE amount > 3000
GROUP BY card_name, outdate
ORDER BY EXTRACT(year from outdate)

