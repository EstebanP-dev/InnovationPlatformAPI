from json import loads

from src.shared import Depends, QueryHandler, Result, List
from .query import GetProjectsQuery
from .response import GetProjectsResponse, ProjectMembersResponse, ProjectDeliverableResponse
from ...infrastructure import ProjectsRepository
from ...domain import ProjectStatusEnum


class GetProjectsQueryHandler(QueryHandler[GetProjectsQuery, GetProjectsResponse]):
    def __init__(self, projects_repository: ProjectsRepository = Depends()):
        self._projects_repository = projects_repository

    async def handle(self, query: GetProjectsQuery) -> Result[List[GetProjectsResponse]]:
        projects = await self._projects_repository.get_projects(query.user_id)

        response = [self.map_project_to_response(project) for project in projects]

        return Result.success(response)

    @staticmethod
    def map_project_to_response(project):
        return GetProjectsResponse(
            id=project.get('id'),
            status=ProjectStatusEnum(project.get('status')),
            title=project.get('title'),
            description=project.get('description'),
            type=project.get('type'),
            assessor=ProjectMembersResponse(**loads(project.get('assessor'))),
            authors=[ProjectMembersResponse(**author) for author in loads(project.get('authors'))],
            deliverables=[ProjectDeliverableResponse(**deliverable)
                          for deliverable in loads(project.get('deliverables'))],
            created_at=project.get('created_at'),
            updated_at=project.get('updated_at')
        )
