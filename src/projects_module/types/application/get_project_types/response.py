from src.shared import BaseModel, Optional


class GetProjectTypesResponse(BaseModel):
    id: Optional[str] = None
    name: Optional[str] = None
