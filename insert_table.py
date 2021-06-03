import psycopg2
from config import config
import random
from datetime import datetime

lst_bank = ['Banamex', 'Bancomer', 'Scotiabank', "American Express"]
lst_city_bank = ['Tijuana', 'CDMX', 'Monterry', "Puebla"]
lst_city_costumer = ['Chiapas', 'CDMX', 'Tabasco', "Puebla"]
lst_address = ['Concepcion street', 'Street 9', 'Liberty Street', "Park New Street"]


def insert_tables(**kwargs):

    sql = {

        "bank": " INSERT INTO bank(bank_name, city, address, aperture_date) VALUES (%s, %s, %s, %s)",
        "costumer": " INSERT INTO customer(name, address, bank_name, city, aperture_date, bank_code) VALUES (%s, %s,%s,%s, %s, %s) "
    }

    conn = None

    try:
        params = config()

        conn = psycopg2.connect(**params)

        cur = conn.cursor()

        for kw in kwargs.keys():
            if kw == 'bank':
                bank = kwargs[kw]
                # print(bank['bank_name'], sql[kw])
                cur.exectutemany(sql[kw],bank['bank_name'], bank['city'], bank['address'], bank['aperture_date'])
            if kw == 'costumer':
                costumer = kwargs[kw]
                # print('-'*40)
                # print(costumer, sql[kw])
                cur.exectutemany(sql[kw],costumer['bank_name'], costumer['city'], costumer['address'], costumer['aperture_date'])

        con.commit()
        cur.close()
    
    except(Exception, psycopg2.DatabaseError) as error: 
        print(error)
    finally: 
        if conn is not None: 
            conn.close()
            print('Conexión cerrada') 












if __name__ == '__main__':
    data = {}
    bank = {}
    for x in range(1, 4): 
        
        bank['bank_name'] = random.choice(lst_bank)
        bank['city'] = random.choice(lst_city_bank)
        bank['address'] = random.choice(lst_address)
        bank['aperture_date'] = datetime.now()
    
    data.update(bank)
    print(data)

    # insert_tables(**data)
