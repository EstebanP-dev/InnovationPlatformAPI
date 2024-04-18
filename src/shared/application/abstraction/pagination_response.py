from pydantic import BaseModel
from typing import Generic, List, TypeVar

T = TypeVar('T')


class PaginationResponse(BaseModel, Generic[T]):
    data: List[T]
    page: int = 0
    rows: int = 0
    total_rows: int = 0
    total_pages: int = 0
