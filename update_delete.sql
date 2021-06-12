UPDATE client 
SET first_name = 'Raúl'
where id = 143

UPDATE bank 
SET city = 'Puebla'
WHERE city = 'Chihuahua'

INSERT INTO movements(id_client_sending, card_number, id_client_receiving, amount, date) 
values (141, 1492198730304060, 160, 400, '2020-06-10');


UPDATE debit_card 
SET amount = debit_card.amount + trans.amount 
FROM (SELECT id_client_receiving, amount
	  FROM movements) as trans
WHERE debit_card.id_client = trans.id_client_receiving

UPDATE debit_card 
SET amount = debit_card.amount - trans.amount 
FROM (SELECT id_client_sending, amount
	  FROM movements) as trans
WHERE debit_card.id_client = trans.id_client_sending