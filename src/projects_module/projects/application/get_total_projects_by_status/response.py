from src.shared import BaseModel, List
from datetime import datetime


class StatusResponse(BaseModel):
    status: str
    total: int
    last_created: datetime


class GetTotalProjectsByStatusResponse(BaseModel):
    total_projects: int
    status: List[StatusResponse]
