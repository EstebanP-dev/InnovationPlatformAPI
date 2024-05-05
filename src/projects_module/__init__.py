from .assessors import *
from .authors import *
from .deliverable_types import *
from .deliverables import *
from .projects import *
from .types import *


from fastapi import APIRouter

project_module_router = APIRouter(prefix="/projects", tags=["Projects"])

project_module_router.include_router(assessors_router)
project_module_router.include_router(authors_router)
project_module_router.include_router(deliverable_types_router)
project_module_router.include_router(projects_router)
project_module_router.include_router(project_types_router)
