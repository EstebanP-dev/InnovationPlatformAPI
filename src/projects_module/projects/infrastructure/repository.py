from src.shared import Depends, create_session, Repository, SESSION_LOCAL
from ..domain import InsertProjectEntity


class ProjectsRepository(Repository):

    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'projects'

    async def insert_project(self, project: InsertProjectEntity):
        return await self.execute_stored_procedure_from_model(
            'sp_insert_project',
            project.model_dump())

    async def get_projects(self, user_id: str):
        return await self.execute_stored_procedure_with_in_params(
            'sp_get_projects',
            {'user_id': user_id})

    async def get_total_projects_by_status(self, user_id: str):
        in_params = {'user_id': user_id}
        out_params = ['total']

        out_params_result, result = await self.execute_stored_procedure_with_in_and_out_params(
            'sp_get_total_by_status',
            in_params,
            out_params)

        return out_params_result, result
