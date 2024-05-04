from src.shared import (BaseModel,
                        Optional,
                        Field,
                        List,
                        UUID_REGEX,
                        EMAIL_REGEX,
                        PHONE_NUMBER_REGEX,
                        USER_CODE_REGEX,
                        USER_NAME_REGEX,
                        NAME_REGEX)


class CreateUserCommand(BaseModel):
    branch: str = Field(..., pattern=UUID_REGEX)
    document_type: str = Field(..., pattern=UUID_REGEX)
    gender: str = Field(..., pattern=UUID_REGEX)
    roles: List[str] = Field(..., min_items=1, max_items=2)
    code: str = Field(..., min_length=5, max_length=20, pattern=USER_CODE_REGEX)
    document_number: str = Field(..., min_length=5, max_length=20)
    email: str = Field(..., min_length=5, max_length=100, pattern=EMAIL_REGEX)
    user_name: str = Field(..., min_length=5, max_length=100, pattern=USER_NAME_REGEX)
    password: str = Field(..., min_length=8, max_length=12)
    phone_number: str = Field(..., min_length=5, max_length=20, pattern=PHONE_NUMBER_REGEX)
    birth_date: str = Field(..., pattern=r'^\d{4}-\d{2}-\d{2}$') # YYYY-MM-DD
    given_name: str = Field(..., min_length=5, max_length=100, pattern=NAME_REGEX)
    family_name: str = Field(..., min_length=5, max_length=100, pattern=NAME_REGEX)
    avatar: Optional[str] = Field(None, max_length=255)
    assessor_code: Optional[str] = Field(None, min_length=5, max_length=20, pattern=USER_CODE_REGEX)
