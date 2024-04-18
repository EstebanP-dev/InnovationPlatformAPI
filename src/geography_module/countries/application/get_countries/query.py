from src.shared import PaginationParameters


class GetCountriesQuery:
    def __init__(self, pagination_parameters: PaginationParameters = None):
        self.pagination_parameters = pagination_parameters
