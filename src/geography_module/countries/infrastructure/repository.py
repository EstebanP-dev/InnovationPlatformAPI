from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class CountryRepository(Repository):
    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return "country"
