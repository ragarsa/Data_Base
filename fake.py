from faker import Faker

fake = Faker('es-Mx') 

for i in range(1,1000):

    print(fake.administrative_unit())