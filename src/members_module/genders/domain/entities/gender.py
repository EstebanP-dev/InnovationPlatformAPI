from src.shared import BASE, Column, String, CHAR

class Gender(BASE):
    __tablename__ = "genders"

    id = Column(CHAR(36), primary_key=True, index=True)
    name = Column(String(60), unique=True, nullable=False)
    abbreviation = Column(CHAR(5), nullable=False)
