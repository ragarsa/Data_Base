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
            CREATE TABLE Client (
            ID SERIAL PRIMARY KEY, 
            Name VARCHAR(140) NOT NULL,
            Address VARCHAR(120) NOT NULL,
            Bank_Name VARCHAR(60) NOT NULL,
            City VARCHAR(60) NOT NULL,
            Aperture_Date TIMESTAMP,
            Bank_Code BIGINT NOT NULL, 
            FOREIGN KEY (Bank_Code) REFERENCES Bank(ID)
            )
            """,
            """
            CREATE TABLE Debit_Card(
                ID SERIAL PRIMARY KEY, 
                card_number INTEGER NOT NULL unique, 
                Amount INTEGER NOT NULL, 
                Card_Name VARCHAR(60) NOT NULL, 
                Outdate DATE NOT NULL, 
                id_client BIGINT NOT NULL,
                FOREIGN KEY (id_client) REFERENCES Client(ID)
            )
            """,
            """
            CREATE TABLE Movements(
                id_client_sending BIGINT NOT NULL,
                card_number INTEGER NOT NULL ,
                id_client_receiving INTEGER NOT NULL, 
                amount INTEGER NOT NULL,
                date DATE,
                FOREIGN KEY (id_client_sending) REFERENCES Client(ID),
                FOREIGN KEY (card_number) REFERENCES Debit_Card(card_number)
                
            )
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
            # print(command)
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
