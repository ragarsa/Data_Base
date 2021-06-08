-- SELECT 'The client ' ||(first_name || ' ' || last_name || ' opened the bank account the '|| TO_CHAR(aperture_date, 'Day Month of ') ||EXTRACT(year from aperture_date) || ' and its debit type is ' || card_name) as estado 
-- from client, debit_card 
-- where client.id = debit_card.id_client ;

-- SELECT DISTINCT 'The client '|| first_name || ' has ' ||TO_CHAR(amount, ' FM$999,999,999.00 ') || 'in the bank '||bank_name  FROM bank, client, debit_card 
-- where bank.bank_name = 'Banamex' and debit_card.amount < 3000

-- SELECT DISTINCT 'Years to expire the debit card of '|| bank_name ||' for ' ||first_name || ' is ' || EXTRACT(year from outdate) - EXTRACT (year from current_date) || ' years ' FROM debit_card, client, bank WHERE bank.bank_name = 'Banamex';

-- SELECT DISTINCT 'The bank ' ||b.bank_name|| ' are in the city ' || ci.city || ' since ' || EXTRACT(year from b.aperture_date)  from client ci 
-- LEFT JOIN bank b
-- ON b.city = ci.city

-- SELECT 'The client with number card ' || TO_CHAR(card_number, 'FM9999-9999-9999-9999') || ' belongs to ' || bank_name from debit_card, bank