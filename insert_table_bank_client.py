import psycopg2
from config import config
import random
from datetime import datetime
from faker import Faker

lst_bank = ['Banamex', 'Bancomer', 'Scotiabank',
            "American Express", 'Inbursa', 'Banco Azteca', 'Banorte']
fake = Faker('es-Mx')


def insert_tables(**kwargs):

    sql = {

        "bank": 'INSERT INTO bank(id, bank_name, city, address, aperture_date) VALUES ({})'.format(','.join(['%s']*5)),
        "client": 'INSERT INTO client(first_name, address, city, aperture_date, bank_code, last_name) VALUES ({})'.format(','.join(['%s']*6))
    }

    conn = None

    try:
        params = config()

        conn = psycopg2.connect(**params)

        cur = conn.cursor()

        for kw in kwargs.keys():
            if kw == 'bank':
                bank = kwargs[kw]
                # print(bank, sql[kw])
                cur.executemany(sql[kw],bank)
            if kw == 'client':
                client = kwargs[kw]
                
                cur.executemany(sql[kw], client)

        conn.commit()
        cur.close()

    except(Exception, psycopg2.DatabaseError) as error:
        print('Reason: ',error)
    finally:
        if conn is not None:
            conn.close()
            print('Closed connection')


if __name__ == '__main__':
    bank = []
    client = []

    data = {'bank': (),
            'client': ()
            }
    id_bank = []
    city_bank = []
    for x in range(0, len(lst_bank)):
        tup_bank = []

        id_bank.append(str(x+1))
        tup_bank.append(id_bank[x])
        tup_bank.append(str(lst_bank[x]))
        tup_bank.append(fake.state())
        tup_bank.append(fake.street_address())
        tup_bank.append(datetime.now())
        bank.append(tuple(tup_bank))
    for id in range(0, len(id_bank)):
        for person in range(10):
            tup_costumer = ()
            tup_costumer += tuple([fake.first_name()])
            tup_costumer += tuple([fake.street_address()])
            tup_costumer += tuple([fake.state()])
            year = random.randint(1999, 2021)
            month = random.randint(1, 12)
            day = random.randint(1, 28)
            aperture = '{}-{:02d}-{:02d}'.format(year,month,day)
            tup_costumer += tuple([str(aperture)])
            tup_costumer += tuple([random.choice(id_bank)])
            tup_costumer += tuple([fake.last_name()])
            client.append(tup_costumer)
            # print(aperture)
    
    data['bank'] = bank
    data['client'] = client
    print(data)
    
    # insert_tables(**data)



