from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error,
                        Created)
from .command import CreateCountryCommand
from ...infrastructure import CountryRepository
from ...domain import CountryEntity


class CreateCountryCommandHandler(CommandHandler[CreateCountryCommand, Created]):
    def __init__(self, country_repository: CountryRepository = Depends()):
        self._country_repository = country_repository

    def handle(self, command: CreateCountryCommand) -> Result[Created]:
        country = CountryEntity(**command.model_dump())

        self._country_repository.create(country)

        return Result.success(Created())
