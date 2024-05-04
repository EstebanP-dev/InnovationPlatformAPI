from src.shared import BaseModel, Optional, List


class CreateUserRequest(BaseModel):
    document_type: Optional[str] = None
    gender: Optional[str] = None
    roles: Optional[List[str]] = []
    code: Optional[str] = None
    document_number: Optional[str] = None
    email: Optional[str] = None
    user_name: Optional[str] = None
    password: Optional[str] = None
    phone_number: Optional[str] = None
    birth_date: Optional[str] = None
    given_name: Optional[str] = None
    family_name: Optional[str] = None
    avatar: Optional[str] = None
    assessor_code: Optional[str] = None
