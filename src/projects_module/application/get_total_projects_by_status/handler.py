from src.shared import QueryHandler, Result, Error, Depends

from ...infrastructure import ProjectsRepository

from .query import GetTotalProjectsByStatusQuery
from .response import GetTotalProjectsByStatusResponse, StatusResponse


class GetTotalProjectsByStatusQueryHandler(QueryHandler[
                                               GetTotalProjectsByStatusQuery,
                                               GetTotalProjectsByStatusResponse]):

    def __init__(self, projects_repository: ProjectsRepository = Depends()):
        self._projects_repository = projects_repository

    async def handle(self, query: GetTotalProjectsByStatusQuery) -> Result[GetTotalProjectsByStatusResponse]:
        out_params_result, result = await (self._projects_repository.get_total_projects_by_status(
            user_id=query.user_id))

        mapped_result = [self.map_status_result_to_response(status) for status in result]

        response = GetTotalProjectsByStatusResponse(
            total_projects=out_params_result.get('total'),
            status=mapped_result
        )

        return Result.success(response)

    @staticmethod
    def map_status_result_to_response(status_result):
        return StatusResponse(
            status=status_result.get('status'),
            total=status_result.get('total'),
            last_created=status_result.get('last_created')
        )
