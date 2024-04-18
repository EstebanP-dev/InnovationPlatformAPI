from src.shared import BASE, Column, String, CHAR


class CountryEntity(BASE):
    __tablename__ = "country"

    id = Column(CHAR(36), primary_key=True, index=True)
    abbreviation = Column(CHAR(5), nullable=False)
    name = Column(String(60), unique=True, nullable=False)
    zip_code = Column(CHAR(8), nullable=False)
