from pydantic import BaseModel


class GetCountryResponse(BaseModel):
    abbreviation: str
    name: str
    zip_code: str
