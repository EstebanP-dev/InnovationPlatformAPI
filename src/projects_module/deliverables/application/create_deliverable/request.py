from fastapi import UploadFile
from pydantic import BaseModel, Field
from typing import Optional


class CreateDeliverableRequest(BaseModel):
    type: Optional[str] = Field(None, description="Type of deliverable")
    name: Optional[str] = Field(None, description="Name of deliverable")
    url: Optional[str] = Field(None, description="URL of deliverable")
    description: Optional[str] = Field(None, description="Description of deliverable")
