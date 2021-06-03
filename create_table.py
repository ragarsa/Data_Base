import psycopg2
from config import config

def create_tables():

    conn = None


    try:
        commands = (
            """
            CREATE TABLE Bank (
            ID SERIAL PRIMARY KEY, 
            Bank_Name VARCHAR(60) UNIQUE,
            City VARCHAR(60) NOT NULL,
            Address VARCHAR(120) NOT NULL,
            Aperture_Date TIMESTAMP
            )
            """,
            """
            CREATE TABLE Customer (
            ID_Costumer SERIAL PRIMARY KEY, 
            Name VARCHAR(140) NOT NULL,
            Address VARCHAR(120) NOT NULL,
            Bank_Name VARCHAR(60) NOT NULL,
            City VARCHAR(60) NOT NULL,
            Aperture_Date TIMESTAMP,
            Bank_Code BIGINT NOT NULL, 
            FOREIGN KEY (Bank_Code) REFERENCES Bank(ID)
            );

            """
        )
        # read connection parameters
        params = config()
        # print(params)
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)

        # create a cursor
        cur = conn.cursor()


        # execute a statement
        print('PostgreSQL create-database:')
        
        for command in commands: 
            cur.execute(command)

        # display the PostgreSQL database server version
        

        # close the communication with the PostgreSQL
        cur.close()

        conn.commit()

    except(Exception, psycopg2.DatabaseError) as error: 
        print(error)
    finally: 
        if conn is not None: 
            conn.close()
            print('Conexión cerrada')

if __name__ == '__main__':
    create_tables() 
