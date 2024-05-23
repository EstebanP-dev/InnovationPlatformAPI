from typing import Optional, List
from pydantic import BaseModel
from datetime import datetime

from ...domain import ProjectStatusEnum


class ProjectMembersResponse(BaseModel):
    id: Optional[str] = None
    full_name: Optional[str] = None


class ProjectDeliverableResponse(BaseModel):
    id: Optional[str] = None
    url: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None
    status: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None


class GetProjectsResponse(BaseModel):
    id: Optional[str] = None
    status: Optional[ProjectStatusEnum] = None
    title: Optional[str] = None
    description: Optional[str] = None
    type: Optional[str] = None
    assessor: Optional[ProjectMembersResponse] = None
    authors: Optional[List[ProjectMembersResponse]] = None
    deliverables: Optional[List[ProjectDeliverableResponse]] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
