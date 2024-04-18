from src.shared import BaseModel, Field, Optional


class CreateCountryRequest(BaseModel):
    abbreviation: Optional[str] = None
    name: Optional[str] = None
    zip_code: Optional[str] = None
