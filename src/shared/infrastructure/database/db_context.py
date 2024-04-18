import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

load_dotenv()

BASE = declarative_base()

MYSQL_HOST = os.getenv("MYSQL_HOST")
MYSQL_PORT = os.getenv("MYSQL_PORT")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
MYSQL_USERNAME = os.getenv("MYSQL_USERNAME")
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE")

CONNECTION_STRING = f"mysql+pymysql://{MYSQL_USERNAME}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"

ENGINE = create_engine(CONNECTION_STRING)
SESSION_LOCAL = sessionmaker(autocommit=False, autoflush=False, bind=ENGINE)


def create_session():
    db = SESSION_LOCAL()
    try:
        yield db
    finally:
        db.close()
