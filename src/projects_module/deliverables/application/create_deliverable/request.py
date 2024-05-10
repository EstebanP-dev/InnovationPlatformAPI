from fastapi import UploadFile
from pydantic import BaseModel, Field
from typing import Optional


class CreateDeliverableRequest(BaseModel):
    project: Optional[str] = Field(None, description="Project of deliverable")
    type: Optional[str] = Field(None, description="Type of deliverable")
    name: Optional[str] = Field(None, description="Name of deliverable")
    identifier: Optional[str] = Field(None, description="Identifier of deliverable")
    description: Optional[str] = Field(None, description="Description of deliverable")
