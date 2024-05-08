from fastapi import UploadFile
from pydantic import BaseModel, Field

from src.shared import UUID_REGEX


class CreateDeliverableCommand(BaseModel):
    project: str = Field(..., pattern=UUID_REGEX)
    type: str = Field(..., pattern=UUID_REGEX)
    name: str = Field(..., max_length=255, min_length=5)
    identifier: str = Field(..., pattern=UUID_REGEX)
    description: str = Field(..., max_length=255, min_length=5)
    file: UploadFile = Field(...,)
