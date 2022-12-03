import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


db_name = os.environ.get('DB_NAME')
user_name = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
env = os.environ.get['APP_MODE']


if env == "dev":
    # for the local-testing with proxy
    private_ip = "127.0.0.1" 
    port = "3306"
elif env == "prod":
    private_ip = "10.5.48.7"
    port = "5432"
else:
    print("APP_MODE not defined!")
    exit()
    
# SQLALCHEMY_DATABASE_URL = "sqlite:///./service.db"
SQLALCHEMY_DATABASE_URL = f"postgresql://{user_name}:{password}@{private_ip}:{port}/{db_name}"


engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)