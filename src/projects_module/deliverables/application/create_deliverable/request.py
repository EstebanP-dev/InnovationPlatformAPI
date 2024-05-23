from typing import Optional

from pydantic import BaseModel, Field

from ...domain import DeliverableStatusEnum


class CreateDeliverableRequest(BaseModel):
    type: Optional[str] = Field(None, description="Type of deliverable")
    status: Optional[DeliverableStatusEnum] = Field(None, description="Status of deliverable")
    name: Optional[str] = Field(None, description="Name of deliverable")
    url: Optional[str] = Field(None, description="URL of deliverable")
    description: Optional[str] = Field(None, description="Description of deliverable")
