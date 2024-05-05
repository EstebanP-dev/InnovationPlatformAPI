from src.shared import Depends, create_session, Repository, SESSION_LOCAL


class DeliverableTypesRepository(Repository):
    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'project_deliverable_types'

    async def get_deliverable_types(self):
        return await self.execute_view('vw_project_deliverable_types')

    async def deliverable_type_is_valid(self, deliverable_type_id: str):
        return await self.execute_stored_procedure_with_in_params("sp_exists_deliverable_type",
                                                                  {'deliverable_type_id': deliverable_type_id})
