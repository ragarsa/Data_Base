import psycopg2 as po 
import random as rd
from config import config
from randomtimestamp import randomtimestamp 
from faker import Faker
from query_client import get_id_client as id


fake = Faker('es-Mx')
id_list = id()
def insert_tables(debit):
    sql = 'INSERT INTO debit_card(card_number, amount, card_name, outdate, id_client) VALUES ({})'.format(','.join(['%s']*5))
    

    conn = None

    try: 
        params = config()

        conn = po.connect(**params)

        cur = conn.cursor()

        cur.executemany(sql, debit)

        conn.commit()

        cur.close()

    except(Exception, po.DatabaseError) as error:
        print('Reason: ', error)
    
    finally: 
        if conn is not None:
            conn.close()
            print('Updated Data')

if __name__ == '__main__':
    i = 4040
    debit = []
    
    for id in id_list:
        tup_debit = ()
        i += 1
        rd_4 = rd.randrange(0,2000)
        digits = '1492{:04d}3030{}'.format(rd_4, i)
        amount = rd.randrange(1000, 10000)
        tup_debit += tuple([digits])
        tup_debit += tuple([amount])
        if amount < 3000: 
            tup_debit += tuple(['Basic'])
        elif amount > 3000 and amount < 7000: 
            tup_debit += tuple(['Premium'])
        else: 
            tup_debit += tuple(['Gold'])
        year = rd.randint(2025, 2031)
        month = rd.randint(1, 12)
        day = rd.randint(1, 28)
        outdate = '{}-{:02d}-{:02d}'.format(year,month,day)
        tup_debit += tuple([outdate])
        tup_debit += tuple([id])
        debit.append(tup_debit)
    # print(debit)
    insert_tables(debit)