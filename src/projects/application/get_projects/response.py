from typing import Optional, List
from pydantic import BaseModel
from datetime import datetime

from ...domain import ProjectStatusEnum


class ProjectMembersRequest(BaseModel):
    id: Optional[str] = None
    full_name: Optional[str] = None


class ProjectDeliverableRequest(BaseModel):
    url: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None


class GetProjectsResponse(BaseModel):
    id: Optional[str] = None
    status: Optional[ProjectStatusEnum] = None
    title: Optional[str] = None
    description: Optional[str] = None
    type: Optional[str] = None
    assessor: Optional[ProjectMembersRequest] = None
    authors: Optional[List[ProjectMembersRequest]] = None
    deliverables: Optional[List[ProjectDeliverableRequest]] = None
    created_at: Optional[str] = None
    updated_at: Optional[str] = None
