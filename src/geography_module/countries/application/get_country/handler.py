from src.shared import Depends, QueryHandler, Result, Error
from ...infrastructure import repository
from . import query as q, response as r


class GetCountryQueryHandler(QueryHandler[q.GetCountryQuery, r.GetCountryResponse]):
    def __init__(self, country_repository: repository.CountryRepository = Depends()):
        self.country_repository = country_repository

    def handle(self, query: q.GetCountryQuery) -> Result[r.GetCountryResponse]:
        countries, _, _ = self.country_repository.find(query.id)

        data = [r.GetCountryResponse(**country) for country in countries]

        if not data:
            return Result.failure(errors=Error.not_found(f"the country with {query.id} was not found."))

        return Result.success(data[0])
