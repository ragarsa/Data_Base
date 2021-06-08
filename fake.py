from faker import Faker
from query_client import get_id_client

id = get_id_client()
fake = Faker('es-Mx') 
print(id)
for i in range(1,1000):

    print(fake.administrative_unit())