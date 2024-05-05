from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class ProjectAssessorsRepository(Repository):
    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return ''

    async def get_assessors(self):
        return await self.execute_view('vw_assessor_members')
