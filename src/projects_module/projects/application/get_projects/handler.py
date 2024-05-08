from json import loads

from src.shared import Depends, QueryHandler, Result, List, Error
from .query import GetProjectsQuery
from .response import GetProjectsResponse, ProjectMembersResponse, ProjectDeliverableResponse
from ...infrastructure import ProjectsRepository
from ...domain import ProjectStatusEnum


class GetProjectsQueryHandler(QueryHandler[GetProjectsQuery, GetProjectsResponse]):
    def __init__(self, projects_repository: ProjectsRepository = Depends()):
        self._projects_repository = projects_repository

    async def handle(self, query: GetProjectsQuery) -> Result[List[GetProjectsResponse]]:
        if not query.project_id and not query.user_id:
            return Result.failure(Error.validation('Either project_id or user_id must be provided'))

        if query.project_id:
            projects = await self._projects_repository.get_entity({
                "project_id": query.project_id,
            })

        else:
            projects = await self._projects_repository.get_projects(query.user_id)

        response = [self.map_project_to_response(project) for project in projects]

        if len(response) == 0:
            return Result.failure(Error.not_found(message='Project(s) not found'))

        if query.project_id:
            response_one = response[0]

            if not response_one:
                return Result.failure(Error.not_found(message='Project not found'))

            return Result.success(response_one)

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
