from src.shared import BaseModel, List


class GetCurrentUserResponse(BaseModel):
    id: str
    full_name: str
    email: str
    user_name: str
    roles: List[str]
