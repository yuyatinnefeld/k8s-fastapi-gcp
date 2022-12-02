import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# TODO: save in k8s config map
instance_name = "postgresql-instance"
user_name = "postgres"
password = "password"
db_name = "postgres"

env = os.environ['ENV']

if env == "DEV":
    private_ip = "127.0.0.1" # for the local-testing with proxy
    port = "3306" # for the local-testing with proxy
elif env == "PROD":
    private_ip = os.environ['PRIVATE_IP']
    port = "5432"
else:
    print("setup ENV")

# SQLALCHEMY_DATABASE_URL = "sqlite:///./service.db"
SQLALCHEMY_DATABASE_URL = f"postgresql://{user_name}:{password}@{private_ip}:{port}/{db_name}"


engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)