from src.shared import BASE, Column, String, CHAR


class DocumentType(BASE):
    __tablename__ = "document_types"

    id = Column(CHAR(36), primary_key=True, index=True)
    name = Column(String(60), unique=True, nullable=False)
    abbreviation = Column(CHAR(5), nullable=False)
