import psycopg2 as po 

from config import config



def get_id_client():
    id = ()
    conn = None

    try: 
        params = config()
        conn = po.connect(**params)
        cur = conn.cursor()

        cur.execute("SELECT id FROM client")
        row = cur.fetchone()
        
        while row is not None: 
            id += row
            row = cur.fetchone()
        
        cur.close()


    except(Exception, po.DatabaseError) as error:
        print('There was a problem', error)

    finally: 
        if conn is not None: 
            conn.close()
            print('Query success')
    return list(id)

if __name__ == '__main__':
    get_id_client()
