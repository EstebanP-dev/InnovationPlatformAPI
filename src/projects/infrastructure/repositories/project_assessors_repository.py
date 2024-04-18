from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class ProjectAssessorsRepository(Repository):

    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        pass

    def from_view(self, view_name: str = 'vw_assessor_members', limit: int = 5, offset: int = 0):
        return super().from_view(view_name, limit, offset)
