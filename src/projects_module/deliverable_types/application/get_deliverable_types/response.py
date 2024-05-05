from typing import Optional
from pydantic import BaseModel


class GetDeliverableTypesResponse(BaseModel):
    id: Optional[str] = None
    name: Optional[str] = None
    extension: Optional[str] = None
