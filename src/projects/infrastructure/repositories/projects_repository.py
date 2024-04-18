from sqlalchemy import text
from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class ProjectsRepository(Repository):

    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'projects'

    def from_view(self, view_name: str, limit: int = 5, offset: int = 0):
        pass

    async def insert_project(self, project):
        authors_str = ','.join(project.authors)
        deliverables_str = ';'.join([f"{deliv.type},{deliv.name},{deliv.url},{deliv.description}"
                                     for deliv in project.deliverables])

        sql = text(
            """
            CALL sp_projects_insert(
                :assessor_id, :project_type_id, :project_title, :project_description, 
                :project_status, :authors_str, :deliverables_str
            )
            """
        )

        self._context.execute(sql, {
            'assessor_id': project.assessor,
            'project_type_id': project.type,
            'project_title': project.title,
            'project_description': project.description,
            'project_status': project.status.value,
            'authors_str': authors_str,
            'deliverables_str': deliverables_str
        })

        self._context.commit()

        return True

    def get_projects(self, user_id: str):
        sql = text("CALL sp_get_projects(:user_id)")
        result = self._context.execute(sql, {'user_id': user_id})
        project_data = result.fetchall()
        self._context.commit()
        return project_data
