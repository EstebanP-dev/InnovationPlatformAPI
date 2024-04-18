from src.shared import BaseModel, Field


class CreateCountryCommand(BaseModel):
    name: str = Field(..., max_length=4, min_length=2)
    code: str = Field(..., max_length=60)
    continent: str = Field(..., max_length=8, min_length=4)
