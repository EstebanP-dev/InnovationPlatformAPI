from typing import Optional

from pydantic import BaseModel


class GetAuthorsResponse(BaseModel):
    id: Optional[str] = None
    avatar: Optional[str] = None
    full_name: Optional[str] = None
