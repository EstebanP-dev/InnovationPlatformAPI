from pydantic import BaseModel, Field
from typing import Optional

from ...domain import DeliverableStatusEnum


class ChangeStatusRequest(BaseModel):
    status: Optional[DeliverableStatusEnum] = Field(None, description="The deliverable status")
