from src.shared import APIRouter
from .presentation import token_router, user_router

authentication_module_router = APIRouter(prefix="/auth", tags=["Authentication"])

authentication_module_router.include_router(token_router)
authentication_module_router.include_router(user_router)
