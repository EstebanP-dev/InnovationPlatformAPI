from pydantic import BaseModel, Field

from src.shared import UUID_REGEX

from ...domain import DeliverableStatusEnum


class ChangeStatusCommand(BaseModel):
    deliverable_id: str = Field(..., pattern=UUID_REGEX)
    status: DeliverableStatusEnum = Field(...)
