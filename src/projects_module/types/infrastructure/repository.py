from src.shared import Depends, create_session, Repository, SESSION_LOCAL


class ProjectTypesRepository(Repository):
    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'project_types'

    async def get_project_types(self):
        return await self.execute_view('vw_project_types')
