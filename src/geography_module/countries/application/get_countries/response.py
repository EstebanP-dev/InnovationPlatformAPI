from pydantic import BaseModel


class GetCountriesResponse(BaseModel):
    id: str
    abbreviation: str
    name: str
    zip_code: str
