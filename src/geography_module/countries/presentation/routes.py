from src.shared import Depends, PaginationParameters, pagination_parameters, handle_result
from src.shared.presentation import APIRouter, Response, status, Body
from ..application.get_countries import GetCountriesQuery, GetCountriesQueryHandler
from ..application.get_country import GetCountryQuery, GetCountryQueryHandler
from ..application.create_country import CreateCountryCommandHandler, CreateCountryRequest

country_router = APIRouter(prefix="/countries")


@country_router.get("/", status_code=status.HTTP_200_OK)
async def get_countries(parameters: PaginationParameters = Depends(pagination_parameters),
                        handler: GetCountriesQueryHandler = Depends()):

    print(parameters.direction)

    query = GetCountriesQuery(pagination_parameters=parameters)
    result = handler.handle(query)

    return handle_result(result)


@country_router.get("/{country_id}", status_code=status.HTTP_200_OK)
async def get_country(country_id: str, handler: GetCountryQueryHandler = Depends()):
    query = GetCountryQuery(country_id)
    result = handler.handle(query)

    return handle_result(result)


@country_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_country(request: CreateCountryRequest = Body(...),
                         handler: CreateCountryCommandHandler = Depends()):

    result = handler.handle(**request.dict())

    return handle_result(result)
