from sqlalchemy import text
from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class UsersRepository(Repository):

    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'users'

    async def get_user(self, field: str):
        sql = text("CALL sp_get_user(:field)")
        result = self._context.execute(sql, {'field': field})
        user_data = result.fetchone()
        self._context.commit()
        return user_data
