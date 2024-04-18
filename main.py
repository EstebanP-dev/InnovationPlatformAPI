from fastapi import FastAPI, APIRouter
from src import (
    country_router,
    authorial_members_router,
    project_assessors_router,
    projects_router)
from src.shared import GeneralExceptionMiddleware

app = FastAPI(root_path="/api/v1")
projects_module_router = APIRouter(prefix="/projects", tags=["Projects"])

projects_module_router.include_router(authorial_members_router)
projects_module_router.include_router(project_assessors_router)
projects_module_router.include_router(projects_router)

app.include_router(country_router)
app.include_router(projects_module_router)

app.middleware("http")(GeneralExceptionMiddleware(app))


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
