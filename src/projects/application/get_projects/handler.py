from src.shared import Depends, QueryHandler, Result
from ...infrastructure import ProjectsRepository
from . import query as q, response as r
from json import loads
from ...domain import ProjectStatusEnum


class GetProjectsQueryHandler(QueryHandler[q.GetProjectsQuery, r.GetProjectsResponse]):
    def __init__(self, projects_repository: ProjectsRepository = Depends()):
        self._projects_repository = projects_repository

    async def handle(self, query: q.GetProjectsQuery) -> Result[r.GetProjectsResponse]:
        projects = self._projects_repository.get_projects(query.user_id)

        response = [self._map_project_to_response(project) for project in projects]

        return Result.success(response)

    @staticmethod
    def _map_project_to_response(project):
        return r.GetProjectsResponse(
            id=project.get('id'),
            status=ProjectStatusEnum(project.get('status')),
            title=project.get('title'),
            description=project.get('description'),
            type=project.get('type'),
            assessor=r.ProjectMembersRequest(**loads(project.get('assessor'))),
            authors=[r.ProjectMembersRequest(**author) for author in loads(project.get('authors'))],
            deliverables=[r.ProjectDeliverableRequest(**deliverable)
                          for deliverable in loads(project.get('deliverables'))],
            created_at=project.get('created_at'),
            updated_at=project.get('updated_at')
        )