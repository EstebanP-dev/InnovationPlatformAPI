from src.shared import Depends, QueryHandler, Result, PaginationResponse
from ...infrastructure import CountryRepository
from . import query as q, response as r


class GetCountriesQueryHandler(QueryHandler[q.GetCountriesQuery, PaginationResponse[r.GetCountriesResponse]]):
    def __init__(self, country_repository: CountryRepository = Depends()):
        self._country_repository = country_repository

    def handle(self, query: q.GetCountriesQuery) -> Result[PaginationResponse[r.GetCountriesResponse]]:
        countries, total_rows, total_pages = (self
                                              ._country_repository
                                              .find(pagination_parameters=query.pagination_parameters))

        response = PaginationResponse[r.GetCountriesResponse](
            data=[r.GetCountriesResponse(**country) for country in countries])

        response.total_rows = total_rows
        response.total_pages = total_pages

        return Result.success(response)
